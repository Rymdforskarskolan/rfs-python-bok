# Funktioner och upprepningsbar kod

Det allra mest grundläggande i ett datorprogram, efter [variabler](./variabler/02-variabler.md#hur-man-skapar-variabler), är *funktioner*[^metoder]. En funktion kan också dra många likheter till matten. Det är i grunden en bit kod som eventuellt tar in lite data, gör någonting (eventuellt med datan), sedan eventuellt ger ett resultat. Det var många "eventuellt", men det finns många sorters funktioner. Detta kapitel kommer behandla de olika typerna och hur man använder dem.

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


[^metoder]: Du kan ha hört begreppet *metoder*, i stället för funktioner. De har en särskild betydelse i objektorienterade språk som Python, som behandlas i extrakapitlet. För nu pratar vi om "funktioner" endast, då "metod" betyder något annat. Ta till exempel definitionen från [Wikipedia](https://en.wikipedia.org/wiki/Function_(mathematics))
