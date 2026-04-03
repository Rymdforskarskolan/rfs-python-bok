#!/usr/bin/env bash
# count-myst-words.sh
#
# Per-file word counts + grand total for MyST Markdown files recursively,
# with progress logging to stderr so it doesn't interfere with the tabular output.
#
# Usage:
#   ./count-myst-words.sh [FOLDER]
#
# Env vars:
#   VERBOSE=1   -> log each file as it's processed (default)
#   VERBOSE=0   -> only periodic progress
#   EVERY=25    -> log every N files (default: 25)

set -euo pipefail

ROOT="${1:-.}"
VERBOSE="${VERBOSE:-1}"
EVERY="${EVERY:-25}"

if [[ ! -d "$ROOT" ]]; then
    echo "Error: '$ROOT' is not a directory" >&2
    exit 2
fi

log() { echo "$@" >&2; }

# Collect files (treat *.md and *.myst.md as MyST candidates)
mapfile -d '' FILES < <(find "$ROOT" -type f \( -name '*.myst.md' -o -name '*.md' \) -print0)

N="${#FILES[@]}"
if ((N == 0)); then
    echo -e "TOTAL\t0"
    exit 0
fi

log "Found $N markdown files under: $ROOT"
log "Counting words (pandoc preferred). Output table will be printed to stdout; progress logs to stderr."

to_relpath() {
    local p="$1"
    if command -v realpath >/dev/null 2>&1; then
        realpath --relative-to="$ROOT" "$p" 2>/dev/null || echo "$p"
    else
        case "$p" in
        "$ROOT"/*) echo "${p#"$ROOT"/}" ;;
        *) echo "$p" ;;
        esac
    fi
}

# --- Pandoc path (recommended) ---
if command -v pandoc >/dev/null 2>&1; then
    total=0
    tmp="$(mktemp)"
    trap 'rm -f "$tmp"' EXIT

    for i in "${!FILES[@]}"; do
        f="${FILES[$i]}"
        rel="$(to_relpath "$f")"
        idx=$((i + 1))

        if [[ "$VERBOSE" == "1" ]]; then
            log "[$idx/$N] pandoc: $rel"
        elif ((idx % EVERY == 0)) || ((idx == 1)) || ((idx == N)); then
            log "Progress: $idx/$N files..."
        fi

        # Convert to plain text and count words.
        # Note: if pandoc is slow on a specific file, the per-file log above shows which one.
        if words="$(pandoc --from=markdown --to=plain --wrap=none "$f" 2>/dev/null | wc -w | tr -d ' ')"; then
            total=$((total + words))
            printf "%s\t%s\n" "$words" "$rel" >>"$tmp"
        else
            printf "0\t%s\n" "$rel" >>"$tmp"
            log "Warning: failed to process with pandoc (counted as 0): $rel"
        fi
    done

    log "Done. Sorting output..."
    sort -nr -k1,1 -k2,2 "$tmp"
    echo -e "TOTAL\t$total"
    exit 0
fi

# --- Fallback path (python) ---
if ! command -v python3 >/dev/null 2>&1; then
    echo "Error: pandoc not found, and python3 not available for fallback." >&2
    echo "Install pandoc (recommended) or python3." >&2
    exit 3
fi

python3 - "$ROOT" "$VERBOSE" "$EVERY" "${FILES[@]}" <<'PY'
import os, re, sys

root = sys.argv[1]
verbose = sys.argv[2] == "1"
every = int(sys.argv[3])
files = sys.argv[4:]
nfiles = len(files)

def elog(msg: str):
    print(msg, file=sys.stderr, flush=True)

def rel(p: str) -> str:
    try:
        return os.path.relpath(p, root)
    except Exception:
        return p

# Best-effort Markdown cleanup (not as accurate as pandoc)
fence_re = re.compile(r"(?ms)^```.*?^```[ \t]*\n?")
html_re  = re.compile(r"(?s)<[^>]+>")
inline_code_re = re.compile(r"`[^`]*`")
link_re = re.compile(r"\[([^\]]+)\]\([^)]+\)")
img_re  = re.compile(r"!\[([^\]]*)\]\([^)]+\)")
roles_re = re.compile(r"\{[^}]*\}")
ws_re   = re.compile(r"\s+")

def count_words(text: str) -> int:
    s = text
    s = fence_re.sub(" ", s)
    s = img_re.sub(r" \1 ", s)
    s = link_re.sub(r" \1 ", s)
    s = inline_code_re.sub(" ", s)
    s = html_re.sub(" ", s)
    s = roles_re.sub(" ", s)
    s = s.replace("*", " ").replace("_", " ").replace("#", " ").replace(">", " ")
    s = ws_re.sub(" ", s).strip()
    return 0 if not s else len(s.split())

elog(f"pandoc not found; using python fallback on {nfiles} files under: {root}")

rows = []
total = 0

for i, path in enumerate(files, start=1):
    rp = rel(path)

    if verbose:
        elog(f"[{i}/{nfiles}] python: {rp}")
    elif (i % every == 0) or (i == 1) or (i == nfiles):
        elog(f"Progress: {i}/{nfiles} files...")

    try:
        with open(path, "r", encoding="utf-8", errors="ignore") as f:
            text = f.read()
        w = count_words(text)
    except Exception:
        w = 0

    total += w
    rows.append((w, rp))

elog("Done. Sorting output...")
rows.sort(key=lambda x: (-x[0], x[1]))

for w, rp in rows:
    print(f"{w}\t{rp}")
print(f"TOTAL\t{total}")
PY
