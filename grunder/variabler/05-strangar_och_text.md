---
kernelspec:
  name: python3
  display_name: Python 3
---

# Strängar och texthantering

I Python lagras som sagt text och bokstäver i en _sträng_, en `str` i kod. Det är i praktiken en lista av bokstäver. Det betyder att du kan utöka den med fler bokstäver för att bygga en större sträng.

## Att addera strängar

Man kan alltså sammanfoga två strängar för att skapa en ny sträng. Detta heter _concatenation_ på engelska och görs med `+` operatorn.

```{code-cell} ipython
:tags: []

string1 = "Hej"
string2 = "på dig!"
together = string1 + string2
print(together)
```

Se hur strängarna sattes ihop efter varandra med `+`:et? Inget mellanslag lades till, för det fanns ju inget mellanslag i strängarna som sattes ihop. Vi kan manuellt lägga till ett mellanslag dock.

```{code-cell} ipython
:tags: []

string1 = "Hej"
string2 = "på dig!"
together = string1 + " " + string2
print(together)
```

Nu stämmer det! Vi hade också kunnat baka in mellanslaget i en av variablerna.

```{code-cell} ipython
:tags: []

string1 = "Hej "
string2 = "på dig!"
together = string1 + string2
print(together)
```

Detta ger också det önskade svaret.

## Att klistra in variabelvärden i strängar

Ibland finns det något värde som inte är text som du vill infoga i en sträng. Till exempel för att skriva ut numerisk information till kodens användare. För det kan du använda en f-sträng. I en f-sträng kan du sätta variabler inom klammerparenterser som `{foo}` till exempel. Det är faktiskt så att du kan sätta godtyckligt uttryck inom klammern och det kommer att funka. Mer om andra slags uttryck kommer senare.

Säg att vi har en kod som räknar antalet poäng i ett spel. Den lagrar dessa poäng i variabeln `points`. Vi vill skriva ut poängen när spelet är klart, men en siffra är inte en sträng så den kan heller inte adderas till en sträng som innan. Då kan vi använda en f-sträng.

```{code-cell} python
points = 7
print(f"Du har samlat {points} poäng!")
```

En f-sträng skrivs alltså som `f""` med text innanför citattecknena och klammersatser (`{}`) där du vill infoga värdet av en variabel eller ett uttryck.

## Att dela upp strängar

Ibland har vi strängar som representerar listor av olika slag. Då kan det vara fiffigt att kunna dela upp de till faktiska listor. Själva datatypen `list` gås igenom i kapitlet om [kollektioner](./08-kollektioner.md) men hur man gör om strängar till listor tar vi nu.

Vi har den fiffiga metoden `str.split()`. Den tar ett argument, avskiljaren, och returnerar en lista av alla delsträngar som avskiljts med den angivna avskiljaren. Självaste avskiljaren följer inte med i resultatet. Vanliga avskiljare är `","`, `";"` och ibland mellanslag `" "`. Här kommer lite exempel på hur detta funkar.

```{code-cell} ipython
:tags: []

lista = "hej,på,dig"
print(lista.split(","))
```

```{code-cell} ipython
:tags: []

mening = "Astrid gick till skolan."
print(mening.split(" "))
```

## Att sammanfoga många strängar

Ibland har man så många strängar att additionsoperatorn inte är praktisk. Då kan vi använda oss av `str.join()`. Den tar ett argument som är en kollektion av strängar och returnerar en lång sträng där alla element har fogats samman, avskiljda med den strängen som metoden `.join()` anropades på. Här följer några exempel på det.

```{code-cell} ipython
:tags: []

namn = ["Astrid", "Jonatan", "Edward", "Paula"]
print(" ".join(namn))
print(",".join(namn))
print(" och ".join(namn))
```
