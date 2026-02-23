# Variabler

Ni är säkert bekanta med variabler från matten. I ekvationen $3x = 2$ så är $x$ en variabel med okänt värde. Jag hade också kunnat säga att konstanten $a = 3$. Variabler i programmering fungerar ganska liknande. I matten är en variabel ett okänt eller ospecificerat värde, vars värde därför kan variera. I programmering har en variabel ett känt värde, som kan ändras av programmeraren och därför kan variera. Konstanter är, precis som i matten, värden som är kända och inte kan ändras.

Du bör tänka på variabler som värde i datorns minne med ett namn så att du kan referera tillbaka till dem. Vi kan lagra precis allt som datorn kan lagra i en variabel. Variabelns värde kan vara inskrivet av dig, eller beräknat från andra värden.

## Hur man skapar variabler

Python är som tur är ett väldigt läsligt språk. Du skapar variabler precis som du hade skrivit det i en matteuppgift:

```python
min_variabel = 5
```

till exempel. I detta fallet skapade vi variabeln `min_variabel` som fick värdet 5, som är ett heltal[^python-int]. Det som gjorde detta möjligt var likhetstecknet (`=`). Ett ensamt likhetstecken heter *tillsättningsoperator* eller *assignment operator*. Den tillsätter värdet i högerled till variabelnamnet i vänsterled.

Vi hade också kunnat göra värdet till ett decimaltal som

```python
mitt_flyttal = 2.2
```

till exempel. Nu skapade vi en till variabel, med värdet 2.2 som är ett flyttal[^python-floats].

Vi kan lagra text som en s.k. *sträng* genom att skriva det inom citattecken. En sträng kan lagra nästan vilken text som helst, eftersom de kodas i UTF-8 och därmed kan lagra typ varje tecken som finns i alla världens språk samt emojis m.m.

```python
min_text = "Hej!"
```

Även sant-falskt värden, s.k. *boolska värden*, kan också finnas i en variabel.

```python
min_bool = True
```

## Att namnge sina variabler

I Python namnger vi våra variabler i `snake_case`. Det innebär att allt är små bokstäver, och understreck mellan ord. Det är även rekommenderat att koda i engelska då alla nyckelord i programmeringsspråket är på engelska, och allt material du hittar på nätet är på engelska. Det är dock inte förbjudet att skriva på svenska, det är även okej rent tekniskt med "å", "ä" och "ö" i variabelnamn. **Se till att vara konsekvent med vilket språk du använder**, men vi kommer inte säga att ni måste ha era variabler på engelska. Boken kommer framöver att använda engelska variabelnamn.

### Konstanter

Om du vill ange en konstant använder du `CAPITAL_SNAKE_CASE`, också känt som `SCREAMING_SNAKE_CASE`. Det är samma som vanliga variabler, fast med bara stora bokstäver.

Konstanter som företeelse finns inte i Python. Det enda du kan göra, är att namnge variabler som inte är menade att ändras med `CAPITAL_SNAKE_CASE`. På så sätt vet en annan programmerare, och de verktyg i VSCode som automatiskt verifierar din kod, att man inte borde ändra värde på den variabeln.

Ett exempel

```python
# Pi är en vanlig konstant man kan behöva
PI = 3.1415

# En annan kan vara allmänna gravitationskonstanten
GRAVITATIONAL_CONSTANT = 6.6743e-11
```

## Att ändra värde på variabler

Om du vill ändra värde på variabeln så är det bara att tillsätta den igen.

```python
foo = 5

foo = 6
# Nu har foo värden 6 och inte 5

foo = foo + 1
# Nu har foo värdet 7, det foo var vid tillsättningen (6) + 1
```

## Flera variabler

Som ni märkte i tidigare exemplet så kan man använda en variabel för att tillsätta en annan.

```python
x = 5
y = 3 * x + 2
# y är nu 3 * 5 + 2 = 17
```

Det kan alltid bara finns ett värde kopplat till ett viss variabelnamn i ett visst *scope*. Vad ett scope är kommer i senare kapitel.

[^python-int]: Pythons heltal är dynamiska, och kan bli precis så stora som du vill. De har också alltid tecken.

[^python-floats]: Python lagrar sina flyttal som 64-bit som standard, du behöver alltså inte oroa dig över precision för vardagliga skäl.
