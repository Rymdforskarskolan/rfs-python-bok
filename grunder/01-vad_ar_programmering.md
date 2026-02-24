# Vad är programmering?

Programmering är i grundet två saker i följande ordning:

1. Författandet av {abbr}`algoritmer (strukturerade "recept" för att genomföra en viss uppgift)`, och
2. Implementerande av algoritmer i programmeringsspråk för att få datorn att utföra dem.

Punkt 1. är betydligt viktigare att förstå sig på än punkt 2. En algoritm kan ofta implementeras i vilket programmeringsspråk som helst, det enda som kommer att skilja är hur den *stavas*.

(algoritmer)=

## Att författa algoritmer

Ordboken säger följande:
> **algoritm**, *algoritmen, algoritmer* (subst.)
>
> instruktionsföljd för lösning av problem av (mer el. mindre) matematiskt slag
>
> -- Svenska Akademiens Ordlista (2026)

Detta är en riktigt bra definition av en *algoritm* för våra ändamål. Låt oss ta ett exempel. Säg att vi vill skriva en algoritm för att bestämma den 3:e vinkeln in en godtycklig triangel om vi vet de andra två vinklarna. För detta kan vi använda att faktumet att inre vinkelsumman för en triangel är 180°, eller matematiskt
:::{math}
:enumerated: false
\theta_1 + \theta_2 + \theta_3 = 180.
:::

Vi vet alltid $\theta_1$ och $\theta_2$ i exemplet. Det betyder att vi behöver ta 180, subtrahera $\theta_1$ och $\theta_2$ för att sedan få vårt resultat. Det vill säga
:::{math}
:enumerated: false
180 - \theta_1 - \theta_2 = \theta_3.
:::
Om vi vill säga det med ord kan vi skriva vårt recept, vår *algoritm*, som

1. Subtrahera $\theta_1$ från 180,
2. Subtrahera $\theta_2$ från föregående resultat och
3. Det du har kvar är $\theta_3$.

Programmering, kokat ner till det allra mest grundläggande delar, är att skriva algoritmer som ovan. Ofta bler de mer invecklade, och innehåller beslut som tar hänsyn till yttre omständigheter. Till exempel hade vi ju kunnat först kolla om $\theta_1 + \theta_2 < 180$ för annars är vårt svar meningslöst. Vi kommer behandla svårare algoritmer senare, men detta är ett bra smakprov.

### Specificitet i algoritmer för datorer

En dator är inte *smart* på något vis. Den är bara jättebra på att göra *exakt* det som önskas av den, väldigt snabbt. Önskar du fel sak kommer den glatt att göra det ändå, vilket betyder att 99% av programmeringsfel beror på människan. Vetenskapligt heter detta {abbr}`PEBCAK (Problem Exists Between Chair and Keyboard)`. På grund av det här måste vi vara noga med att vi vet vad vi menar och faktiskt skriver vad vi menar till datorn. Massor av saker en människa ser som underförstått är för en dator inte alls självklart. Mer om detta i framtida kapitel...

```{iframe} https://www.youtube.com/embed/j-6N3bLgYyQ?si=ciQKHtHTHk6O52jw
:title: En video om algorimter
:width: 95%
Ett litet exempel på varför man vill vara specifik...
```

## Att skriva ned algoritmer i kod

När du väl har din algoritm uppfunnen behöver du *implementera* den. Och det första man brukar göra är att välja vilket språk man vill använda för ett visst ändamål, men vi har valt språket åt er: Python. När språket är bestämt, är det "bara" att skriva ned processen du har i kod. Hur du gör det ägnas resten av boken åt.

### Algoritmer är språkoberoende

Det som är viktigt att komma ihåg, är allt algoritmen är språkoberoende. Allting går i allt[^språkoberoende], så när du tänker kring koncept i framtida kapitel bör du ha i bakhuvudet att det du lär dig kan tillämpas med annan syntax (läs *stavning*) än Python. Här är ett exempel på hur många olika sätt du kan skriva ut en hälsning:

`````{tab-set}

````{tab-item} Python
```{code} python
print("Hello, World!")
```
````

````{tab-item} Rust
```{code} rust
fn main() {
    println!("Hello, World!");
}
```
````

````{tab-item} C#
```{code} csharp
using System;

namespace Greeting {
    class GreetingProgram {
        static void Main(string[] args) {
            Console.WriteLine("Hello, World!);
        }
    }
}
```
````

````{tab-item} C++
```{code} cpp
#include <iostream>
using namespace std;

int main() {
    cout << "Hello, World!";
    return 0;
}
```
````
````{tab-item} Java
```{code} java
public class Main {
  public static void main(String[] args) {
    System.out.println("Hello, World!");
  }
}
```
````
`````

Alla dessa kodsnuttar är kompletta och fullt körbara och/eller kompilerbara i deras respektive språk, och kommer att göra exakt samma sak från ett användarperspektiv. Däremot *stavas* de mycket olika, detta heter att de har olika *syntax*.

### Flödesscheman för visualisering

Ett väldigt fiffigt tankeverktyg för programmering är ett *flödesschema*. Den används för att teckna ned algoritmer på att sätt som är lättare att överskåda än ord. Såhär kan en sådan se ut:

:::{mermaid}
flowchart LR
    A([Start])
    A --> B{"`Är det morgon
    eller kväll?`"}
    B -->|Innan lunch| C["Hälsa god dag!"]
    B -->|Efter lunch| D["Hälsa god eftermiddag!"]
:::

Handlingar är fyrkanter, val är romber och start och slut är ovaler. Man kan få väldigt bra förståelse för vad ens kod faktiskt förväntas att göra om du skriver ned den såhär.

## Hur kod blir från text till handling

Du har säkert tänkt vid det här laget att kod är ju text, hur kan en dator då göra nåt med det? Och svaret är ju att den inte kan det, inte direkt i alla fall. Det datorn kan göra däremot, är att tolka texten och göra om den till instruktioner som den förstår för att sedan utföra dem. Det finns två huvudsakliga sätt den kan göra detta på: *kompilering* och *tolkning*.

För att datorer ska kunna köra kod krävs en processor, en {abbr}`CPU (Central Processing Unit)`, och arbetsminne som heter {abbr}`RAM (Random Access Memory)`. Det är även användbart med lagringsutrymme på en {abbr}`SSD (Solid State Drive)` eller hårddisk. CPU:n kan genomföra en förutbestämt mängd av instruktioner, till exempel att addera två tal eller lagra ett tal till minnet. Det finns många fler instruktioner, men de flesta ligger på en sådan låg nivå som grundläggande aritmetik och minneshantering. Resten sköter operativsystemet (Windows, Linux eller MacOS till exempel).

### Programkompilering

När vi omvandlar den text vi skriver, så kallad *källkod*, hela vägen till rena instruktioner för CPU:n, så kallad *maskinkod*, kallas det kompilering[^kompilering]. Denna process har förluster, vilket innebär att den resulterande maskinkoden bara kan köra på den typ av CPU och det operativsystem som den skapades för.

```{hint} Mer om kompileringsförluster
:class: dropdown
Moderna datorer har egentligen två typer av [CPU-arkitektur](https://en.wikipedia.org/wiki/Microarchitecture): [ARM](https://en.wikipedia.org/wiki/ARM_architecture_family) och [x84-64](https://en.wikipedia.org/wiki/X86-64). Det finns dock lite andra typer också, bland annat de andra bitarna i [x86-familjen](https://en.wikipedia.org/wiki/X86). Windows, Linux och äldre MacOS använder x86-64 medan Android, iOS, ipadOS, viss modern Windows och all modern macOS använder sig av ARM.

Egentligen är det tekniskt möjligt att köra x86-64 assembly på alla x86-64 processorer, men eftersom så mycket sköts av operatives krävs i regel rätt {abbr}`OS (operativsystem)` för att maskinkoden ska funka. Därför är en viss körbar fil endast fungerade för samma typ av CPU på samma OS.
```

Fördelen med att kompilera är att all översättning är klar innan koden skall köras. Detta ger i regel snabbare kod. Det har också fördelen att den resulterande maskinkoden (ofta) står för sig själv. Du kan alltså skicka den till en kompis med samma CPU och operativsystem så kommer det att funka utan att de behöver ladda ned nåt extra.

```{hint} Om bytekod och delvis kompilering
:class: dropdown
Vissa språk, som Java, väljer att vara ett mellanting mellan tolkade språk och kompilerade språk. Dessa språk kompilerar så långt som möjligt utan att göra koden maskinspecifik. Det som resulterar kallas [bytekod](https://en.wikipedia.org/wiki/Bytecode). Tanken är att bytekoden tolkas av en programtolk när den skall köras, men det är mycket mer effektivt att tolka bytekod än att tolka ren text. Du har alltså inte fristående kod, men du har en effektiviserad version av källkoden som kan köras överallt där du har en programtolk tillgänglig.

Det finns också en intressant teknologi som heter JIT, Just-in-Time, kompilering. Detta betyder att din kod tolkas och kompileras i block vilket ger en del av hastighetsfördelarna av kompilerad kod med fördelen av en tolk.
```

### Tolkad kod

Att tolka, eller interpretera, kod innebär att källkoden läses direkt då du skall köra den, vid *run-time*. En programtolk, också kallad *interpreter*, läser din kod och kör den (ofta) rad för rad. Konvertering från källkod till maskinkod sker direkt, och maskinkoden körs också direkt. Python är ett tolkat språk till exempel.

Detta bär på fördelen att du kan köra samma Python-kod överallt det finns en Pythontolk. Och det finns en Pythontolk för väldigt många platformar. Datorerna ni använder har något som heter [CPython](https://en.wikipedia.org/wiki/Bytecode) som sin tolk, medan era mikrokontroller använder sig av [CircuitPython](https://circuitpython.org). Skriver du en tolk för en given CPU-typ och {abbr}`OS (operativsystem)` kan du köra all Pythonkällkod där.

Den andra fördelen är att du kan distribuera källkoden i mänskligt läsbart format och ändå köra denna överallt. Detta kan man inte göra med kompilerad kod, då det inte är läsbart för någon (åtminstone ingen lekman).

Den stora nackdelen av detta är prestanda. Koden måste tolkas live, vilket betyder att den tidsinvestering som vid kompilering sker i förväg sker vid run-time. Detta gör att tolkad kod i regel är mycket långsammare än motsvarande kompilerade kod. Det har också nackdelen att alla som skall köra din kod måste ha en programtolk för ditt språk. Det enda sätt du kan distribuera ett körbart, självstående program är om du skickar med hela tolken vilket är ganska mycket saker att skicka med. Därför brukar man ha tolken på mottagarens dator redan, dock kräver detta att grejer laddas ned.

(repl-intro)=

#### En REPL som en sandlåda

Tolkade språk har en annan fördel: en {abbr}`REPL (Read Evaluate Print Loop)`. Dessa tar in källkod en rad i taget, kör varje rad och skriver ut dess resultat direkt. På så vis är det jättesmidigt att pröva kod snabbt utan att behöva skriva hela filer. Ni hår pythons REPL genom att köra kommandot `python` i er terminal:

```sh
> python
Python 3.14.2 (main, Jan  2 2026, 14:27:39) [GCC 15.2.1 20251112] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> print("Hello, World!")
Hello, World!
```

Ni kommer ut genom att skriva `quit()` sedan enter i Pythons REPL.

[^språkoberoende]: Nästan allt. Rent tekniskt går allt i alla Turing-kompletta språk, vilket är nästan alla språk. Men bara för att det *går* betyder inte att det är skönt, trevligt eller effektivt att göra det.

[^kompilering]: Detta är ett förenklat påstående. Egentligen går texten till ett syntaxträd, som tolkas till assembly, som sedan länkas, som i sin tur omvandlas till maskinkod. Detta är dock utanför ramen av kursen. Om du är nyfiken, läs [](https://en.wikipedia.org/wiki/Compiler) på Wikipedia.
