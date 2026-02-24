---
kernelspec:
    name: python3
    display_name: Python 3
---
# Funktioner och upprepningsbar kod

Det allra mest grundläggande i ett datorprogram, efter [variabler](./variabler/02-variabler.md#hur-man-skapar-variabler), är *funktioner*[^metoder]. En funktion kan också dra många likheter till matten. Det är i grunden en bit kod som eventuellt tar in lite data, gör någonting (eventuellt med datan), sedan eventuellt ger ett resultat. Det var många "eventuellt", men det finns många sorters funktioner. Detta kapitel kommer behandla de olika typerna och hur man använder dem.

[^metoder]: Du kan ha hört begreppet *metoder*, i stället för funktioner. De har en särskild betydelse i objektorienterade språk som Python, som behandlas i extrakapitlet. För nu pratar vi om "funktioner" endast, då "metod" betyder något annat.

## Funktioner som mekaniska lådor

Betrakta en låda som vi kallar för `foo`. Lådan `foo` har ett inre maskineri som kan göra vad vi vill. Vi låter `foo` ha ett inre maskineri som:

1. Tar in ett tal från vänster,
2. Lägger till 5 till det talet och
3. Spottar ut det till höger.

```{note} En återblick på begreppet "algoritm"
Lägg märke till att detta ju är en algoritm! Det läste ni om [tidigare](#algoritmer)!
```

Vi kan försöka rita hur det skulle se ut med ett exempel:

```{mermaid}
flowchart LR
    A((5)) --> B("` foo `")
    B --> C((10))
```

Eller varför inte med ett flyttal?

```{mermaid}
flowchart LR
    A((37.7)) --> B("` foo `")
    B --> C((42.7))
```

Betrakta nu en annan låda, `bar` som vi låter ha ett maskineri som tar in två tal från vänster, adderar dem och sedan spottar ut summan till höger.

```{mermaid}
flowchart LR
    A((37.7)) --> C("` bar `")
    B((12.3)) --> C
    C --> D((50))
```

### Hur man bör tänka på funktioner

Exemplet ovan är ett väldigt bra sätt att börja tänka kring funktioner. De är lådor som kan ta in 0 eller fler värden till vänster, göra något med dem och sedan spotta ut 0 eller fler värden till höger. Nu togs inga exempel med 0 in- eller utdata upp, men visst är det logiskt att det kan finnas en låda vars jobb är att spotta ut "5" oavsett vad när du startar den? Eller en låda vars jobb är att ta in en siffra, blinka en lampa på lådan lika många gånger som siffran, sen inte spotta ut något?

```{important} Datan måste inte vara siffror
Lådor, eller funktioner, måste inte bara ta in och ge ut siffror. Siffror är bra exempel, men värdena kan vara vad som helst. Du kan till exempel tänka dig en låda som tar in ett namn, sätter bokstäverna "Hej, " framför och "!" efter så att du får ut "Hej, <namn>!" ur andra sidan. Din fantasi sätter gränserna!
```

```{hint} Ett sidospår om matematiska funktioner
:class: dropdown
Som jag nämnde i början av kapitlet så finns det många likheter med den matematiska definitionen av en funktion. Däremot finns det vissa skillnader också.

> **Funktion**
>
> Inom matematiken tilldelar en **funktion** från en mängd $\mathbf{X}$ till en mängd $\mathbf{Y}$ för varje element i $\mathbf{X}$ exakt ett element i $\mathbf{Y}$. Mängden $\mathbf{X}$ kallas funktionens definitionsmängd, och $\mathbf{Y}$ kallas funktionens värdemängd.
>
> -- Wikipedia (2026, översatt av Marcell Ziegler)

Detta fungerar väldigt bra inom matten, men programmeringen är inte lika restriktiv. Du kan definitivt definiera en matematisk funktion i kod, men du kan också göra mycket mer. Det är till exempel fullt tillåtet att $\mathbf{X} = \varnothing$ samtidigt som $\mathbf{Y} \neq \varnothing$. Även tvärtom funkar jättebra. Det kan även gälla att $\mathbf{X},\mathbf{Y} = \varnothing$ utan problem.

Att varje värde i $\mathbf{X}$ tilldelas flera värden i $\mathbf{Y}$. Det måste inte ens vara samma antal värden i $\mathbf{Y}$ för varje i $\mathbf{X}$. Sen behöver heller inte alla värden i $\mathbf{X}$ tilldelas ett värde i $\mathbf{Y}$, det räcker med vissa eller inga.

Den andra stora skillnaden är att en funktion i kod kan ha *biverkningar*. Det innebär att medan den göra sina beräkningar så kan den påverka sin omgivning. Mer specifikt innebär det att funktionen kan ändra variabler som inte tillhör den själv, och därmed i allmänhet ändra tillståndet i minnet på ett sätt som kan påverka andra funktioner. Givetvis måste inte en funktion ens göra beräkningar, men ofta gör dem det.
```

## Hur man skriver funktioner

Äntligen är det dags för lite mer kod i stället för bara teori! Som ett inledande exempel kommer vi att återskapa vår låda, eller rättare sagt funktion, `bar` i Python.

```{code} python
:linenos:
def bar(tal1, tal2):
    return tal1 + tal2
```

Nu ska vi kolla denna kod ord för ord så att ni vet vad som händer. På rad 1 har vi den s.k. *funktionssignaturen*.

```{code} python
:linenos:
:emphasize-lines: 1
def bar(tal1, tal2):
    return tal1 + tal2
```

Först har vi {abbr}`nyckelordet (ett särskilt ord som är reserverat för en viss funktion)` `def`. Det står för "define function" och inleder alla funktionsdefinitioner. Därefter följer funktionsnamnet `bar`, och dess *parametrar*[^parametrar]. Parametrar är definierade inom parentesen som alltid följer efter namnet. Varje parameter skall ges att namn, som en variabel, och parametrar separeras med kommatecken (`,`). Efter slutparentesen skall det alltid följa ett kolon (`:`).

[^parametrar]: Ibland kallas dessa felaktigt *argument*. Ett argument är det som du matar till funktionen när du anropar det, en parameter är det du definierar i funktionssignaturen.

I det här fallet har vi definierat två parametrar: `tal1`, och `tal2`. Funktionsparametrar följer samma namngivning som variabler: `snake_case` gäller! Eftersom Python är dynamiskt typat, som vi konstaterade i [tidigare kapitel](./variabler/03-datatyper_i_python.md#datatyper-i-python), så är datatypen på dessa parametrar inte förutbestämda. När du väl skall använda `bar()`[^funktionsnotation] kommer du alltså kunna mata vilka typer du vill, men du kommer få problem om du försöker använda typer som inte definierar vad "addition" (`+` operatorn) innebär.

[^funktionsnotation]: Om du undrar varför jag satte parenteser efter `bar()` så är det för att visa att det är en funktion. Annars hade namnet lika gärna kunnat vara en variabel.

```{code} python
:linenos:
:emphasize-lines: 2
def bar(term1, term2):
    return term1 + term2
```

Efter funktionssignaturen på rad 1, så skall vi definiera vad funktionen gör. Allt som hör till funktionen skall vara inskjutet exakt 4 mellanslag jämfört med nyckelordet `def`. Det åstadkoms lättast genom att trycka på tangenten Tab på ditt tangentbord[^vscode-och-tab].

````{aside} Tab-tangenten
```{image} ../images/tab.png
:width: 40%
:align: left
```
````

[^vscode-och-tab]: Notera att Tab vanligtvis skriver ut en Tab-karaktär vars vidd definieras av programmet som läser det. Däremot så är VSCode inställd på så sätt att en Tab automatiskt expanderas till 4 mellanslag för Pythonfiler.

I vår funktioner `bar()` börjar funktionsdefinitionen med nyckelordet `return`. Den säger att funktionen skall avslutas här, och skicka tillbaka värdet av uttrycket som kommer efter. I vårt fall är det `term1 + term1` som är uttrycket som skall returneras. Som vi sade i [kapitlet om operatörer](./variabler/04-aritmetik.md#binary-operators) kommer `+` operatorn att addera talen och uttrycket utvärderas då till deras summa. Därför kommer funktionen också att returnera summan `term1 + term2`.

## Funktionsanrop

När vi kallar på en funktion att utföra sin algoritm, att starta vår mekaniska låda så att säga, kallas det för att vi *anropar* funktionen ("to call a function" på engelska). För att göra det, skriver funktionens namn följt av en parentes. I parentesen skriver du funktionens *argument*. Argumenten är värden du vill tillsätta parametrarna du definierade innan.

```{important} Viktigt om funktionsdefinitioner!
Noterat att jag inkluderat funktionsdefinitionen i kodsnutten. Det är för att du alltid behöver definiera dina funktioner innan du använder dem. Kom ihåg att kod läses rad för rad, uppifrån och ned. Därför måste definitionen komma tidigare i filen än anropet.
```

Säg att vi vill använda vår funktion `bar()` för att beräkna summan av `2` och `3`.

```{code} python
:linenos:
:emphasize-lines: 4
def bar(term1, term2):
    return term1 + term2

bar(2, 3)
```

Då skriver vi som på rad 4 ovan. Vi har du givit siffrorna `2` och `3` som *argument* till funktionen `bar()`. Argument tillsätts parametrarna i samma ordning som de definierades i funktionssignaturen. Alltså blir `2` insatt i `term1` och `3` sätts in i `term2` när funktionen körs.

````{aside} En tanke om matematiska funktioner
Har du tänkt på att vi kan definiera `bar()` helt matematiskt?
:::{math}
:enumerated: false
bar(x, y) = x + y
:::
är ju samma sak som vår kod! Här är vi ju överens om att $bar(2,3) = 2 + 3 = 5$ eller hur? Det som dock skiljer, som du snart får se, är att matten bara funkar för siffror. `bar()` är däremot inte begränsad till siffror.
````

Vid ett funktionsanrop tar koden alla givna argument, sätter in de i motsvarande parametrar och sedan körs varje rad i funktionsdefinitionen tills raderna tar slut, eller en `return` påträffas. Därefter hoppar programmet tillbaka till där funktionen anropades och funktionsanropet ersätts av det värde som returnerades eller `None` om inget värde returnerades. I vårt fall kommer `bar(2, 3)` att utvärderas till `5`.

Vi vet ju att `bar(2,3)` blir `5` logiskt, men vi vill gärna kolla vad värdet av ett viss funktionsanrop blir. För det kan vi använda oss av den inbyggda funktionen `print()`. Den skriver ut värden vi ger den på terminalen som text. Låt oss skriva ut vårt resultat.

::::{aside} Mer om `print()`
Funktionen kan ta 0 eller fler argument. Varje argument ska vara ett värde som skrivs ut på terminalen, och dessa är separerade av mellanslag. Detta har fördelen att argumenten inte måste ha samma typ som varandra. Dock ska varje argument för sig ha en typ. Om du ger 0 argument får du en tom rad.

:::{hint} Avancerad `print()`
:class: dropdown
Du kan också mata in nyckelordsargumenten `end` för att ange en sträng som skall skjutas in efter allt är utskrivet. Denna är satt till `"\n"` som default. Det andra nyckelordsargumentet är `sep` som anger en sträng att sära på argumenten med, denna är `" "` som default.
:::
::::

```{code-cell} ipython
:tags: [remove-input]

def bar(a,b):
    return a + b
```

```{code-cell} ipython
:tags: []

...
# Du behöver fortfarande definiera funktionen innan du anropar den,
# jag kommer dock utlämna det, visat med "...", f.o.m. nu.

print(bar(2,3))
```

Titta, vårt resultat är som väntat! (Resultatet visas i tunn, grå text under kodrutan)

## Variabler och funktioner tillsammans

Du kan använda variabler som argument, du kan använda returvärden när du tillsätter variabler och du kan skapa nya, tillfälliga variabler i funktion. De första två egenskaperna sammansatt ser ut som nedan.

```{code-cell} python
:label: bar-cell
...

a = 7
b = 3.2
summa = bar(a, b)
print(summa)
```

Resultatet blir ju igen som väntat. Nu går vi igenom detta rad för rad så att vi vet varför det blir rätt.

```{code} python
:linenos:
:emphasize-lines: 1-2
a = 7
b = 3.2
summa = bar(a, b)
print(summa)
```

Här definierar vi två variabler: heltalet `a` med värdet `7` och flyttalet `b` med värdet `3.2`.

```{code} python
:linenos:
:emphasize-lines: 3
a = 7
b = 3.2
summa = bar(a, b)
print(summa)
```

Sedan tillsätter vi en tredje variabel: `summa`. Den får värdet av `bar(a, b)`, vilket enligt ovan blir `10.2`. Vi har alltså använt oss av variablerna `a` och `b` för att vara argument till `bar()`. Du kan tänka på det som att koden kör

```python
term1 = a
term2 = b
```

i bakgrunden när vi anropar `bar(a, b)`. `term1` blir alltså lika med `a`, och `term2` får värdet i `b`. Funktionen räknar ut summan, och returnerar denna[^scope]. Då blir uttrycket `bar(a, b)` utvärderat till `10.2` och detta värde sätts in i `summa`.

````{important} Viktigt!
Det är fortfarande **endast ordningen** som avgör vilka argument som hamnar i vilka parametrar. Se detta exempel:
```{code} python
term1 = 2
term2 = 4
bar(term2, term1)
```
När koden inom `bar()` körs, kommer `term1` (som funktionsparameter) ha värdet `4` och `term2` ha värdet `2`. Detta är trots att de yttre *variablerna* (alltså inte parametrar) `term1` och `term2` har samma nämn men angivits i omvänd ordning. Det är ordningen som du definierade parametrarna i som spelar roll, namnet att eventuella variabler du använder som argument kvittar.
````

[^scope]: Notera att `term1` och `term2` slutar att existera efter `bar()` är klar.

```{code} python
:linenos:
:emphasize-lines: 4
a = 7
b = 3.2
summa = bar(a, b)
print(summa)
```

På sista raden skriver vi sedan ut värdet i `summa`, genom att skicka det som argument till `print()`. När vi kollar resultatet i det [körda kodblocket ovan](#bar-cell) så ser vi att det stämmer med matten.

## Lokala variabler i funktioner

Det är fritt fram att skapa variabler även inom funktioner. De i en annan kontext än variabler definierade utanför funktioner så variabler inom funktioner slutar existera efter funktionen kört klart.

Om vi driver vidare med exemplet `bar()` kan jag skapa en, visserligen onödig, variabel för att demonstrera detta.

```{code} python
:linenos:
:emphasize-lines: 2
def bar(term1, term2):
    result = term1 + term2
    return result
```

Detta gör samma sak som vår kod innan, men nu har vi skapat variabeln `result` vars värde sedan returneras. Efter funktionen är klar slutar `result` att existera.

## Att namnge sina funktioner

Som tidigare nämnt är det `snake_case` som gäller även här. Se till att namnge era funktioner på ett beskrivande sätt. `bar()` är ett jättedåligt namn på en funktion. Vi vill hellre kalla den för `add()` till exempel.


