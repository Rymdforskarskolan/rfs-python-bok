#!/usr/bin/env python3
"""Render a nested JSON object as a Unicode tree.

Expected JSON shape:
{
  "root": [
    {"child_a": []},
    {"child_b": [
      {"leaf": []}
    ]}
  ]
}
"""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path
from typing import Any


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=(
            "Parse a nested JSON object and print it as a Unicode tree. "
            "Reads from FILE if provided, otherwise from stdin."
        )
    )
    parser.add_argument(
        "file",
        nargs="?",
        help="Path to JSON file. Use '-' or omit to read from stdin.",
    )
    return parser.parse_args()


def read_input(file_arg: str | None) -> str:
    if file_arg and file_arg != "-":
        return Path(file_arg).read_text(encoding="utf-8")

    data = sys.stdin.read()
    if not data.strip():
        raise ValueError("No input provided on stdin.")
    return data


def validate_node(node: Any, path: str = "$") -> None:
    if not isinstance(node, dict):
        raise ValueError(
            f"{path}: expected object with one field, got {type(node).__name__}."
        )

    if len(node) != 1:
        raise ValueError(f"{path}: expected exactly one field, got {len(node)}.")

    name, children = next(iter(node.items()))
    if not isinstance(name, str):
        raise ValueError(f"{path}: field name must be a string.")

    if not isinstance(children, list):
        raise ValueError(f"{path}.{name}: expected an array of child nodes.")

    for index, child in enumerate(children):
        validate_node(child, f"{path}.{name}[{index}]")


def render_node(
    name: str, children: list[dict[str, Any]], prefix: str, is_last: bool, is_root: bool
) -> list[str]:
    if is_root:
        lines = [name]
        child_prefix = ""
    else:
        connector = "└── " if is_last else "├── "
        lines = [f"{prefix}{connector}{name}"]
        child_prefix = f"{prefix}{'    ' if is_last else '│   '}"

    for idx, child in enumerate(children):
        child_name, child_children = next(iter(child.items()))
        lines.extend(
            render_node(
                name=child_name,
                children=child_children,
                prefix=child_prefix,
                is_last=(idx == len(children) - 1),
                is_root=False,
            )
        )

    return lines


def main() -> int:
    args = parse_args()

    try:
        raw = read_input(args.file)
        data = json.loads(raw)
        validate_node(data)

        root_name, root_children = next(iter(data.items()))
        for line in render_node(
            root_name, root_children, prefix="", is_last=True, is_root=True
        ):
            print(line)

    except FileNotFoundError as exc:
        print(f"Error: file not found: {exc.filename}", file=sys.stderr)
        return 2
    except json.JSONDecodeError as exc:
        print(
            f"Error: invalid JSON: {exc.msg} (line {exc.lineno}, col {exc.colno})",
            file=sys.stderr,
        )
        return 2
    except ValueError as exc:
        print(f"Error: {exc}", file=sys.stderr)
        return 2

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
