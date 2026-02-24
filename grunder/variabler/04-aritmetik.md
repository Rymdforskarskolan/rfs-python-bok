# Aritmetik och beräkningar

Aritmetik innebär grundläggande manipulering och operationer på tal. Alltså: addition, subtraktion, multiplikation, division och {abbr}`modulus (rest vid division)`. I programmeringen skiljer vi på heltalsaritmetik och flyttalsaritmetik eftersom de har olika egenskaper. Det är nämligen så att heltal aldrig kan ha avrundningsfel, men flyttal kan i vissa operationer bära med sig avrundningsfel på grund av hur datorn lagrar flyttalen.

## Operatörer

En *operator* är en matematisk funktion som *opererar*, arbetar, på ett eller fler värden. Ofta representeras en operator av en symbol, som `+` eller `-`. De operatörer som används inom aritmetiken kallar vi *aritmetiska operatörer*. Eller lite enklare: "matte-operatörer" inom programmeringens kontext.

## Binära operatörer

En binär operator arbetar på två tal (två värden). Här följer en sammaställning av de som ni kan använda er av i Python.

| Operator | Namn                 | Användning | Egenskaper                                                                                                                                                                                                                   |
| ---      | ---                  | ---        | ---                                                                                                                                                                                                                          |
| `+`      | Addition             | `5 + 5`    | Adderar heltal eller flyttal.                                                                                                                                                                                                |
| `-`      | Subtraktion          | `3 - 4`    | Subtraherar heltal eller flyttal.                                                                                                                                                                                            |
| `/`      | Division             | `1.5 / 3`  | Dividerar som vanligt, resultatet kan bli heltal eller flyttal (decimal) beroende på kvoten.                                                                                                                                 |
| `*`      | Multiplikation       | `7.6 * 5`  | Multiplicerar som vanligt, resultatet kan bli heltal eller flyttal (decimal) beroende på om ena faktorn var decimal eller ej.                                                                                                |
| `**`     | Exponentiering       | `3**2`  | Höjer upp vänstra talet till det högra. Fiffigt för att kvadrera eller höja upp till -1 till exempel.                                                                                                                           |
| `//`     | Trunkerande division (flooring division) | `3.6 // 2` | Dividerar, och tar bort decimaldelen så att det alltid blir ett heltal. Det är inte samma som att avrunda! Exempelvis blir `5 // 2 = 2` eftersom det faktiska svaret är `2.5` men decimaldelen tas bort. |
| `%`      | Modulus              | `6 % 2`    | Ger resten vid division. `4 % 2 = 0`, men `6 % 5 = 1` till exempel.                                                                                                                                                          |

## Unära operatörer

En unär operator arbetar på ett tal (ett värde).

| Operator | Namn                 | Användning | Egenskaper                                                                                                                                                                             |
| ---      | ---                  | ---        | ---                                                                                                                                                                                    |
| `-`      | Unär negation        | `-5`       | Negerar (gör negativt från positivt, eller vice versa) talet det ställs framför. Precis som i matten, men på grund av hur datorspråk funkar måste vi skilja på binärt och unärt minus. |
| `+`      | Unärt plus           | `+3`       | Negerar *inte* värdet efter sig. Det vill säga gör ingenting. Det finns där för symmetri med unärt minus.                                                                              |

## Tillsättande operatörer

Det förekommer ofta att man vill justera värdet av en variabel. Säg att du vill ta en befintlig variabel och multiplicera dess värde med två sedan lagra resultatet i samma variabel. Alternativt vill du kanske lägga till 1 till en räknare för varje upprepning av en viss del av din algoritm. Då vill du använda tillsättande operatörer. För varje binär aritmetisk operator finns en tillhörande tillsättande operator.

Ta addition som exempel. 

## Andra matematiska funktioner

Python kommer med relativt få mattefunktioner som inte explicit behöver importeras. De främsta inbyggda är `max(a,b)` och `min(a,b)`. De tar det största, resp. minsta, värdet av `a` och `b`. Vi har även `sum(...)` som ger summan av alla argument. Du har även `pow(b,e)` som ger `b**e` eller b{sup}`e`.

### Modulen `math`

Vi kommer prata mer om moduler mot slutet av kursen, men just nu kan du komma ihåg att du behöver skriva

```python
import math
```

i början av en Pythonfil för att importera resterande mattefunktioner. Du kommer åt det genom att anropa `math.<funktion>()`. Mer om hur man anropar funktioner kommer också senare. Här följer en tabell av intressanta funktioner från `math`.

| Funktion           | Användning                    | Beskrivning                                                                                                 |
| ------------------ | ----------------------------- | ----------------------------------------------------------------------------------------------------------- |
| `math.sqrt()`      | `math.sqrt(2)`                | Ger kvadratroten ur ett tal.                                                                                |
| `math.floor()`     | `math.floor(3.7)`             | Ger närmaste heltal *under* angivet värde.                                                                  |
| `math.ceil()`      | `math.ceil(5.2)`              | Ger närmaste heltal *över* angivet värde.                                                                   |
| `math.factorial()` | `math.factorial(3)`           | Ger fakulteten av angivet värde.                                                                            |
| `math.abs()`       | `math.abs(-3.2)`              | Ger absolutbeloppet (avståndet från 0, dvs. positivt oavsett vad).                                          |
| `math.exp()`       | `math.exp(4)`                 | Ger naturliga exponentieringen av talet. ($e^a$, där $a$ är argumentet)                                     |
| `math.log()`       | `math.log(5,[bas])`           | Ger logaritmen av angivet tal. Basen behöver inte anges, om den uteblir så används $e$, annars angiven bas. |
| `math.sin()`       | `math.sin(2 * math.pi)`       | Ger sinus av värdet i radianer.                                                                             |
| `math.cos()`       | `math.cos(3 * math.pi)`       | Ger cosinus av värdet i radianer.                                                                           |
| `math.tan()`       | `math.tan((2 / 3) * math.pi)` | Ger tangens av värdet i radianer.                                                                           |
| `math.degrees()`   | `math.degrees(2 * math.pi)`   | Ger värdet, angivet i radianer, konverterat till grader.                                                    |
| `math.radians()`   | `math.radians(120)`           | Ger värdet, angivet i grader, konverterat till radianer.                                                    |

```{hint} Vidare läsning för den intresserade
:class: dropdown
Detta är grunderna i Pythons matte. Du kan läsa vidare i dokumentationen: [Uttryck](https://docs.python.org/3/reference/expressions.html), [`math`](https://docs.python.org/3/library/math.html#module-math) och [inbyggda funktioner](https://docs.python.org/3/library/functions.html).

```
