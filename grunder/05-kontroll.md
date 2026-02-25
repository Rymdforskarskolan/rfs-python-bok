---
kernelspec:
    name: python3
    display_name: Python 3
---

# Kontrollstrukturer

En kontrollstruktur är en mekanism för kod att kunna "ta beslut" baserat på information i variabler som den har tillgång till eller som är en del av den miljö där den körs. Det är här vi kommer att ha nytta av de booleska värden vi tidigare diskuterat.

## `if`-satsen

En `if`-sats (`if`-statement på engelska) ställer frågan "om \_\_\_ är `True`, gör\_\_\_". Det vill säga om något är sant kör en viss bit kod, annars gör inget. Nedan följer en `if`-sats.

```{code} python
if expr:
    ...
```

Vi inleder alltså med nyckelordet `if` följt av mellanslag sedan att godtyckligt uttryck vars värde blir en `bool`, dvs. `True` eller `False`. Efter uttrycket kommer ett kolon. Under satsen skrivs raderna av kod som *bara* skall köras som `expr` utvärderas till `True`. Dessa, precis som i funktioner, skall vara inskjutna och utgör då ett *block*.

Vi kollar på några exempel.

```{code-cell} ipython
:tags: []

a = 13

if a == 13:
    print("a är 13!")

print("Klar!")
```

```{code-cell} ipython
:tags: []

a = 10

if a == 13:
    print("a är 13!")

print("Klar!")
```

Lägg märke till att raden där "a är 13!" printas bara kördes när `a` faktiskt var `13` och inte annars.

Vi kan också jämföra två olika variabler.

```{code-cell} ipython
:tags: []

a = 13
b = 3.2

if b < a:
    print("b är mindre än a!")

print("Klar!")
```

Man an också kolla variabler som har typen `bool` utan att behöva använda jämförelser.

```{code-cell} ipython
:tags: []

always_true = True

if always_true:
    print("Det var visst True!")

print("Klar!")
```

Det går också att kolla motsatser

```{code-cell} ipython
:tags: []

always_true = False

if not always_true:
    print("always_true var INTE True, dvs. False!")

print("Klar!")
```

## Booleska uttryck

Ett booleskt uttryck är ett sådant uttryck som utvärderas till en `bool` eller ett sant-falskt-värde. Oftast konstruerar vi de med hjälp av *jämförelseoperatörer*.

| Operator | Användning  | Beskrivning                                                                        |
| -------- | ----------- | ---------------------------------------------------------------------------------- |
| `==`     | `a == b`    | Likhet. `True` om `a` har samma värde som `b`, annars `false`.                     |
| `!=`     | `a != b`    | Inte lika med. Omvänt av likhet.                                                   |
| `>`      | `a > b`     | Större än. Fungerar främst för nummer av olika slag.                               |
| `<`      | `a < b`     | Mindre än. Fungerar främst för nummer av olika slag.                               |
| `>=`     | `a >= b`    | Större än eller lika med. Fungerar främst för nummer av olika slag.                |
| `<=`     | `a <= b`    | Mindre än eller lika med. Fungerar främst för nummer av olika slag.                |

Du kan kombinera booleska uttryck med *logiska operatörer*.

| Operator | Användning              | Beskrivning                                                                                                                   |
| -------- | ---------------------   | ----------------------------------------------------------------------------------------------------------------------------- |
| `and`    | `<...> and <...>`       | Blir `True` om de booleska uttrycken på båda sidor är `True`. Annars är den `False`.                                          |
| `or`     | `<...> or <...>`        | Blir `True` om höger *eller* vänster sida är `True`, eller om båda är `True`. Blir false om både höger och vänster är `False` |
| `not`    | `not <...>`             | Byter sanningsvärde på det som kommer efter. `True` blir `False`, och vice versa.                                             |

## `else`-satsen

Ibland vill man att någon kod skall köras om någonting är sant, men sen vill man att en annan kod skall köras *bara* om det visar sig vara falskt. Då använder man sig av en `else`-sats. Dessa kan inte stå för sig själva, utan måste komma efter en `if`-sats.

```{code} python
if expr:
    ...
else:
    ...
```

De skrivs som ovan, men nyckelordet `else` följt av kolon med samma inskjutningsnivå som den tillhörande `if`-satsen. Efter `else`-satsen skall all kod som *bara* körs om `expr` är `False` återigen skrivas inskjutet, och det utgör ett till block.

Vi kollar på några exempel.

```{code-cell} ipython
:tags: []

a = 12.6

if a == 12.6:
    print("a är 12.6!")
else:
    print("a är inte 12.6!")

print("Klar!")
```

```{code-cell} ipython
:tags: []

a = 1.2

if a == 12.6:
    print("a är 12.6!")
else:
    print("a är inte 12.6!")

print("Klar!")
```

Titta, och lägg märke till vilken `print()` som kördes i varje exempel.

### `elif`-satsen

En kusin av `else`-satsen är `elif`-satsen eller else-if satsen. Denna sats gör det möjligt att köra kod om den tillhörande `if`-satsens uttryck var `False` men `elif`-satsens uttryck är `True`.

```{code} python
if expr1:
    ...
elif expr2:
    ...
```

Vi skriver denna sats med nyckelordet `elif` och tillhörande kolon. Koden som skall köras är återigen inskjuten och utgör ett block.

Det är okej att ha flera `elif`-satser efter varandra, och du kan ha 0 eller 1 `else`-sats på slutet som körs om alla uttryck är `False`.

```{code} python
if expr1:
    ...
elif expr2:
    ...
elif expr3:
    ...
else:
    ...
```

:::{important} Viktigt om `elif` och kortslutning.
Pythons kontrollstrukturer är s.k. *kortslutande*. Det betyder att endast en *arm* av den sammansatta kontrollstrukturen kommer någonsin att köras. I det sista exemplet ovan, säg att `expr1` är `False` och `expr2` är `True`. Då kommer `if`-satsen att hoppas över, för den var falsk, men första `elif`-satsen kommer att köras. Därefter körs alltså *inga* fler av satserna, även om `expr3` skulle vara `True`.

Om du startar en ny sammansatt kontrollstruktur, med en ny inledande `if`-sats, börjar regeln om.
:::

## `match`-satsen

Ibland kan du hamna i en situation där en variabel har en känd mängd av möjliga värden. Du vill kolla vilket värde den har. Säg till exempel att du har en variabel `device` som kan ha värden `"phone"`, `"computer"` och `"tv"`. Du vill sen göra olika saker baserat på olika möjliga värden. Du hade kunnat använda en sammansatt `if`-sats.

```{code} python
if device == "phone":
    ...
elif device == "computer":
    ...
elif device == "tv":
    ...
```

Däremot behöver du skriva ut variabelnamnet i varje sats, och detta blir snabbt jobbigt, särskilt vid flera möjliga alternativ. I stället kan vi använda en `match`-sats.

```{code} python
match device:
    case "phone":
        ...
    case "computer":
        ...
    case "tv":
        ...
```

Detta gör samma som ovan, men kanske lite mer läsligt och smidigare att skriva. Vi kan lägga till et *default*-case som körs om inga andra cases passar.

```{code} python
:linenos:
:emphasize-lines: 8-9
match device:
    case "phone":
        ...
    case "computer":
        ...
    case "tv":
        ...
    case _:
        ...
```

::::{hint} Mer avancerad `match`
:class: dropdown
Du kan också använda `match` för att göra s.k. pattern matching. Då kan du extrahera värden du jämför ur vissa kollektioner till exempel.
:::{code} python

# point är en (x, y) tuple

match point:
    case (0, 0):
        print("Origin")
    case (0, y):
        print(f"Y={y}")
    case (x, 0):
        print(f"X={x}")
    case (x, y):
        print(f"X={x}, Y={y}")
    case _:
        raise ValueError("Not a point")
:::

Detta, likt andra språk, går att utöka till mer komplicerade typer. För mer info, se [dokumentationen](https://docs.python.org/3/tutorial/controlflow.html#match-statements).
::::
