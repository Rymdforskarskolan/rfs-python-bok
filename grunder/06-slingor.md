---
kernelspec:
    name: python3
    display_name: Python 3
---
# Slingor

En slinga, eller synonymt en *loop*, är ett block av kod som upprepas flera gånger. Det finns två typer av slingor: `for` och `while`, som fyller olika syften.

## `while`-slingan

Denna slinga beter sig som den låter: upprepa en bit kod *medan* ett uttryck är sant (`True`). Här är formen:

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

Mellan höger- och vänsterled har vi den *booleska operatorn* `or` som frågar är värdet till höger **eller** vänster `True` så är helheten `True`, annars är helheten `False`. So i ord har vi nu:

:::{sidebar} Kortslutning i `or`
Vissa av er har kanske tänkt att vi kommer få ett problem om `number` inte är ett giltigt heltal, men vi försöker göra om den till `int` ändå. Det är rätt tänkt!

Däremot är eller-operatorn, `or`, kortslutande. Alltså om vänsterledet är `True` kollar den inte ens högerledet, utan går bara vidare. Det räcker ju med ena ledet för att helheten ska vara `True`. Om `number` är ogiltigt heltal gäller ju `not number.isdecimal()`, alltså kortsluter `or` och vi stöter aldrig på felet.
:::

- (inte `number` är ett giltigt heltal)
- ELLER
- (`number` som heltal är mindre än eller lika med 0).

Om båda led här är `False` betyder det ju att `number` *är* ett giltigt heltal och är större än 0, alltså behöver vi inte fråga igen. Annars är minst ett av värden `True` och därmed helten är `True` och vi kör kodblocket som frågar efter ett nytt tal. Detta upprepas *medan* (`while`) vårt kriterium är uppfyllt.

### Oändliga `while`-slingor

Eftersom en `while`-slinga kan ta vilket booleskt uttryck som helst, kan de också ta sådana som alltid är `True`, eller alltid är `False`. Ett uttryck som alltid är `False` gör att slingan aldrig körs, så det är ganska onödigt. Däremot är slingor på formen

```python
while True:
    ...
```

väldigt användbara för att de loopar oändligt tills att de stoppas på något sätt. Det finns två sätt att stoppa en oändlig slinga:

1. Att trycka Ctrl + C i terminalen. (⌘ + . (punkt) på Mac)
    - Detta kallas en Keyboard Interrupt och avslutar den nuvarande processen. Funkar även för saker som inte är Python.
2. Att någonstans i koden använda nyckelordet `break`.
