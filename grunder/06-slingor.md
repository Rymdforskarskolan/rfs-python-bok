---
kernelspec:
  name: python3
  display_name: Python 3
---

# Slingor

En slinga, eller synonymt en _loop_, är ett block av kod som upprepas flera gånger. Det finns två typer av slingor: `for` och `while`, som fyller olika syften.

## `while`-slingan

Denna slinga beter sig som den låter: upprepa en bit kod _medan_ ett uttryck är sant (`True`). Här är formen:

```python
while expr:
    ...
```

Precis som med våra [kontrollstrukturer](./05-kontroll.md) kan `expr` vara vilket uttryck som helst som kan tolkas som ett sant-falskt-värde, en `bool`.

`while`-slingor är användbara för att skriva kod med räknare eller för att leta efter särskilda saker. En av de vanligaste användningarna är att fråga en fråga till användaren om och om igen tills att ett svar har givits på rätt format.

Ponera att vi vill fråga efter ett positivt heltal ($x \in \mathbb{Z}, x>0$). Då kan vi använda oss av `input()` från innan för att fråga efter ett tal. Därefter kollar vi om användaren angivit siffror, och ifall de siffrorna (omgjorda till ett heltal) är större än 0.

```{code-block} python
:linenos:
number = input("Ange ett positivt heltal: ")

while not number.isdecimal() or int(number) <= 0:
    number = input("Ange ett positivt heltal: ")

print(number)
```

Börja med att kopiera denna kod och kör den själv. Testa olika värden på din inmatning, både giltiga och ogiltiga heltal och se vad som händer! Förta raden tar in en sträng med vår prompt `"Ange ett positivt heltal"`. Den kollar dock inte om det är giltigt.

```{code-block} python
:linenos:
:emphasize-lines: 3
number = input("Ange ett positivt heltal: ")

while not number.isdecimal() or int(number) <= 0:
    number = input("Ange ett positivt heltal: ")

print(number)
```

Sedan har vi själva `while`-slingan med vårt [booleska uttryck](./05-kontroll.md#booleska-uttryck) som denna gång är `not number.isdecimal() or int(number) <= 0`. Detta är ganska stort, så vi delar upp det:

- `not number.isdecimal()`
- `or`
- `int(number) <= 0`

Metoden `str.isdecimal()` funkar på alla variabler och värden av typen `str` och ger `True` om alla karaktärer i strängen är en av siffrorna 0-9. Det vill säga att alla giltiga heltal i vårt talsystem ger `True` och allt annat ger `False`. Notera att "." inte är en siffra, så tal med decimaler är inte `True` här.

I högerledet har vi en vanlig jämförelse, om `int(number)` är mindre än eller lika med 0. Vi måste konvertera vår `str` till en `int` så att vi kan jämföra med 0, som också är en `int`. Om du är osäker på hur detta funkar, tänkt tillbaka till kapitlet om [datakonvertering](./variabler/06-att_andra_datatyp.md#convert-data).

Mellan höger- och vänsterled har vi den _booleska operatorn_ `or` som frågar är värdet till höger **eller** vänster `True` så är helheten `True`, annars är helheten `False`. So i ord har vi nu:

:::{sidebar} Kortslutning i `or`
Vissa av er har kanske tänkt att vi kommer få ett problem om `number` inte är ett giltigt heltal, men vi försöker göra om den till `int` ändå. Det är rätt tänkt!

Däremot är eller-operatorn, `or`, kortslutande. Alltså om vänsterledet är `True` kollar den inte ens högerledet, utan går bara vidare. Det räcker ju med ena ledet för att helheten ska vara `True`. Om `number` är ogiltigt heltal gäller ju `not number.isdecimal()`, alltså kortsluter `or` och vi stöter aldrig på felet.
:::

- (inte `number` är ett giltigt heltal)
- ELLER
- (`number` som heltal är mindre än eller lika med 0).

Om båda led här är `False` betyder det ju att `number` _är_ ett giltigt heltal och är större än 0, alltså behöver vi inte fråga igen. Annars är minst ett av värden `True` och därmed helten är `True` och vi kör kodblocket som frågar efter ett nytt tal. Detta upprepas _medan_ (`while`) vårt kriterium är uppfyllt.

### Oändliga `while`-slingor

Eftersom en `while`-slinga kan ta vilket booleskt uttryck som helst, kan de också ta sådana som alltid är `True`, eller alltid är `False`. Ett uttryck som alltid är `False` gör att slingan aldrig körs, så det är ganska onödigt. Däremot är slingor på formen

```python
while True:
    ...
```

väldigt användbara för att de loopar oändligt tills att de stoppas på något sätt. Det finns två sätt att stoppa en oändlig slinga:

1. Att trycka `Ctrl + C` i terminalen. (`⌘ + .` (punkt) på Mac)
   - Detta kallas en _Keyboard Interrupt_ och avslutar den nuvarande processen. Det funkar även för saker som inte är Python.
2. Att någonstans i koden använda nyckelordet `break`.

Vi tar en exempel för `break`. Säg att du har en räknarvariabel, som sedvanligt heter `i`, och du ska räkna från 0 till 5 i steg om heltal. Då skulle du kunna skriva

```{code-cell} ipython

i = 0
while i <= 5:
    print(f"Nu är i: {i}")
    i += 1
print("klar!")

```

Notera hur slingan upprepas ända tills kriterier inte längre gäller, dvs. på varvet då `i == 6` och därför räknar vi från 0 till 5. Sista `klar!` skrivs endast ut efter slingan slutat loopa, då den kommer _utanför blocket_, efter slingan.

För att illustrera effekt av break, skriver vi om koden med en oändlig `while`-slinga och ett `break`.

```{code-cell} ipython
:tags: []

i = 0
while True:
    print(f"Nu är i: {i}")
    i += 1
    if i > 5:
        break

print("klar!")
```

Titta, samma effekt! Däremot har jag behövt ändra kriteriet, numera loopar vi inte _medan_ ett kriterium är sant, utan tills att ett kriterium _blir_ sant. Så fort `i > 5` evalueras till `True` når vi `break` som bryter slingan där och då.

### Nyckelordet `continue`

Ett annat intressant verktyg är `continue`. Det är nästan samma som `break`, men i stället för att bryta loopen så säger den i ställer "bryt här, och börja om från början" (om kriteriet fortfarande gäller).

Säg för exemplets skull att vi vill hoppa över 3 när vi räknar. Då hade vi kunnat skriva.

```{code-cell} ipython
:tags: []

i = 0
while True:
    if i == 3:
        i += 1
        continue

    print(f"Nu är i: {i}")
    i += 1

    if i > 5:
        break

print("klar!")
```

Titta hur jag behövde ha kollen för `i == 3` allra först, för att loopen körs som vanligt fram till ett `break` eller `continue`. Jag behövde också ha en särskild `i += 1` för fallet där vi hoppar för loopen hoppar annars innan vi plussar `i` och därför skulle den vara 3 för all evighet då vi alltid börjar om innan i hinner öka.

```{note} Tips
`break` och `continue` funkar lika bra i loopar som inte är oändliga. Det finns flera användningar för dem, även i ändliga loopar.
```

```{hint} En mer effektiv metod för att fråga efter indata
:class: dropdown

Det blir snabbt väldigt jobbigt att hitta på booleska uttryck som verifierar om data är i rätt format. När man konverterar datatyper, görs ju den verifieringen åt dig egentligen men programmet kraschar om du gjorde fel. Om du är bekant med felhantering sen innan, så kan man göra som nedan i stället.

:::{code} python
data = input("Ange ett heltal: ")

while True:
    try:
        data = int(data)
        # try-blocket hoppar direkt till except vid fel.
        # break nås endast om övre raden klarar sig.
        break
    except:
        print("Ange ett heltal!")
        data = input("Ange ett heltal: ")
:::
```

## `for`-slingan

Denna slinga använder sig av s.k. _iteratorer_. En _iterator_ är ett objekt du kan {abbr}`iterera över (jobba dig genom och göra något med var och en av elementen)`. Du upprepar alltså en bit kod _för varje element_ i en given [kollektion](./variabler/08-kollektioner.md#collections) eller ett annat iterabelt värde som `range`. `for` slingan har följande form:

```python
for var in iterable:
    ...
```

där `var` är ett godt. namn på varje element som du kommer använda i din iteration och `iterable` är ett _iterabelt_ värde, dvs. ett värde som går att iterera över vilket motsvarar olika kollektioner och vissa andra typer som `range`. Slingan kommer köras för varje element i `iterable` sedan sluta.

### Iteration över sekvenser av heltal

En av de vanligaste formerna av `for`-slinga är de som itererar över en `range`. Detta är en särskild iterabel typ som ger dig alla heltal mellan ett startvärde och ett slutvärde. Startvärdet är inkluderat i intervallet, men slutet är inte det. Alltså är exempelvis `range(0,3)` en iteration över `0,1,2`. Vi gör ett enkelt exempel:

```{code-cell} ipython
:tags: []

for i in range(0,10):
    print(i)
```

Nu bryter vi ned detta steg för steg. Vi börjar slingan med `for`, därefter väljer vi ett namn på det varde som vi behandlar under en given körning av slingan som vi kallar `i` denna gång. `i` är sedvanligt vid iteration över heltalsintervall eller listindex. Därefter följer nyckelordet `in` följt av det vi skall iterera över: en `range(0,10)`, alltså alla heltal från och med 0 till, men inte med, 10.

Därefter kommer koden som skall köras varje loop, vilket i vårt fall är en `print()` som skriver ut värdet av det nuvarande elementet i iterationen. Notera hur värdet ökar från 0-9 med heltalsintervall.

### Iteration över kollektioner

Den andra vanliga tillämpningar av `for`-slingan är att göra något för varje element i en lista eller annan kollektion. Säg exempelvis att vi har en lista med namn och vill hälsa på alla i terminalen. Då kan vi använda en `for`-slinga.

```{code-cell} ipython
:tags: []

names = ["Martin", "Ida", "Rebecka", "Jonas"]

for name in names:
    print(f"Hej, {name}!")
```

Titta nu hur jag har valt ett annat namn på min _iterationsvariabel_, alltså det nuvarande värdet. Denna gång heter den `name`, för att det beskriver elementet den representerar. På liknande vis heter listan `names` för det beskriver dess innehåll.

Tuples funkar likadant som listor när det kommer till `for`.

### Iteration över en mängd

Mängder är oordnade så elementen kommer att behandlas i slumpmässig ordning.

```{code-cell} ipython
:tags: []

fruits = {"banana", "apple", "grapefruit", "aubergine", "pomegranate"}

for fruit in fruits:
    print(fruit)
```

### Iteration över en `dict`

Precis som med `in`-operatorn innan, så är det grundtillståndet att iterera över `dict`:ens nycklar. Du måste explicit säga till, om du vill iterera över värdena, eller nyckel-värde paren.

```{code-cell} ipython
:tags: []

film_scores = {"Star Wars": 8, "Star Trek": 10, "Interstellar": 6}

for film in film_scores:
    print(film)
```

```{code-cell} ipython
:tags: []

for score in film_scores.values():
    print(score)
```

```{code-cell} ipython
:tags: []

for film_and_score in film_scores.items():
    print(film_and_score)
```

Titta hur vi fick `tuple`:s i sista varianten. Det är smått opraktiskt så det finns ett tjusigt trick: vi kan demontera en tuple för att få två iterationsvariabler att jobba med.

```{code-cell} ipython
:tags: []

for film, score in film_scores.items():
    print(f"Filmen {film} fick betyg {score}/10")
```

### Upprepning utan iterationsvariabel

Vi kan använda `for`-slingor för att upprepa en bit kod ett känt antal gånger. Det gör vi genom att iterera över en `range`, men slänga bort värdet vi får varje loop. Om du bara matar ett argument till `range` så börjar intervallet automatiskt från 0. Alltså, om vi skulle vilja säga "Hej!" fem gånger kan vi skriva:

```{code-cell} ipython
:tags: []

for _ in range(5):
    print("Hej!")
```

Iterationsvariabler får det särskilda namnet `_` som sedvanligt betyder att den är obetydlig. Det är en full giltig variabel, men att den heter `_` visar att vi inte bryr oss om den. Här itererar vi alltså över `0,1,2,3,4` vilket ger 5 st loopar.
