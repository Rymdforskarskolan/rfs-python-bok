# Vad är en klass?

Vi har tidigare pratat om de [inbyggda datatyperna i Python](../variabler/03-datatyper_i_python.md). Du kanske redan har funderat på ifall det går att skapa egna datatyper. Fundera inte längre; det går och det är vad dessa kapitel handlar om!

Python är ett så kallat _objektorienterat_ språk. Det innebär att användaren uppmuntras till att använda s.k. _objekt_ när de utför sin programmering. Men innan vi går in på objekt, behöver vi först förstå vad en _klass_ är. I vardagligt tal kan en klass likställas med en datatyp. Mer specifikt är det i regel en datatyp som representerar ett abstrakt föremål, fenomen, företeelse eller allmän "sak". Man säger att datatypen `int`[^int-is-class] är en klass för "saken" _heltal_.

[^int-is-class]: Alla typer i python är faktiskt klasser, och alla uppkomster av dessa i kod är objekt av den klassen.

```{hint} Den mer snäva definitionen av _klass_
:class: dropdown
Rent programmeringstekniskt är en klass inte en datatyp som så. Det är endast ett sammanträffande att alla datatyper också är klasser. Alla klasser är däremot inte datatyper.

En klass, rent tekniskt, är en samling attribut och metoder som hör till samma _namespace_ som utgörs av klassen. En klass i python är även alltid kapabel till att instansieras till objekt av klassen.
```

## Objekt

Ett objekt är en s.k. _instans_ av en klass. Du kan tänka på det som ett "särskilt föremål/fenomen/etc." i stället för "typ/klass av föremål/fenomen/etc.".

Som ett exempel: en Maltes fotboll är en särskild boll, medan bollar i allmänhet är en klass av föremål. Därför skulle vi vilja definiera en klass för bollar, och varje individuell boll skulle vara ett objekt av den klassen. Ett liknande exempel med de inbyggda typerna: `521`, `2133` och `21` är alla _särskilda_ heltal som alla därmed är _objekt_ av klassen `int` som representerar heltal i allmänhet.

Man kan också tänka på klasser som "recept" för att bygga någonting. Säg att ditt program hanterar olika sorters pizzor, då kan du ha en klass (recept) för en `MargharitaPizza`, en för `VesuvioPizza` osv. Sedan kan du skapa objekt (individuella, särskilda pizzor) som du serverar till dina kunder. Du kan alltså ha massor av olika `MargharitaPizza`:an som alla delar gemensamma egenskaper (sås, ost, deg) men kan ha några unika egenskaper som hör till den särskilda pizzan, till exempel extra svamp.

````{note} En tanke om klasser och kategorier
Du märker kanske att jag har dragit gränsen till vad en "överkategori", dvs. en klass, är och vad som är "objekt". Vart man drar den gränsen är lite upp till programmeraren, och det är faktiskt så att vi kan ha en djupare kategorisk indelning. Det är fullt möjligt att ha `boll > fotboll > Maltes fotboll` till exempel. Mer om detta senare.

```{hint} Klasser som överkategorier och ärftlighet
:class: dropdown
Klasser kan representera många abstrakta saker. I vissa språk, som Python, kan klasser ärva egenskaper av andra klasser. En superklass kan ärva sina egenskaper till många olika subklasser också. Det gör det inte bara möjligt, utan också tillrådligt att ha så många uppdelningar som krävs för att göra din abstraktion rimlig. Har du mer än 1 typ av boll, då ska du ha en superklass `Ball` och en subklass för varje typ av boll `Football`, `Beachball`, etc. Sen varje instans av dessa kommer du sedan kunna tilldela till en viss ägare som exempel.

Mycket om om ärftlighet kommer senare, och i mer avancerade kapitel.
```

````

## Att namnge sina klasser

En klass skall alltid namnges i `PascalCase`. Alla objekt av en klass kommer lagras i vanliga variabler, och därför har de namn i `snake_case`.

När vi väl kommer dit, skall dina attribut och metoder också vara döpta i `snake_case` som om de var variabler och funktioner. Konstanta klassattribut skall vara `UPPER_SNAKE_CASE` som vanligt.
