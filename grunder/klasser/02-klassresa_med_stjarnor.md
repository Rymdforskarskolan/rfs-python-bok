---
kernelspec:
  name: python3
  display_name: Python 3
---

# En klassresa med stjärnor

Om vi kopplar detta till verkligheten (och i RFS-anda: rymden) så kan vi betrakta stjärnor. Vi kan alla hålla med om att stjärnor faller under kategorin "abstrakt föremål", därför kan det vara en klass!

Säg att vi i vårt program måste behandla många stjärnor. Låt oss sedan säga att en stjärna karakteriseras av dess spektralklass, luminositet, yttemperatur, diameter och massa. Från det vi redan vet, hade vi ju kunnat ha en variabel per egenskap, per stjärna. Som exempel[^star-is-bad]:

```python
star1_spectral_klass = "A"
star1_luminosity = 2.7e6 # W
star1_surface_temp_K = 4000 # K
star1_diameter = 4e8 # m
star1_mass = 6e6 # kg
```

[^star-is-bad]: Denna stjärna är helt gissad av mig, Marcell, så håll inte värdena emot mig!

Du märker redan nu att detta blir bökigt om man ska göra detta för hundratals stjärnor. Det måste finnas ett bättre sätt! Någon som är extra klurig, kanske tänker att vi kan göra detta som en `dict`! Då blir det i stället:

```python
star1 = {
    "spectral_class": "A",
    "luminosity": 2.7e6 # W
    "surface_temp_K": 4000 # K
    "diameter": 4e8 # m
    "mass": 6e6 # kg
}
```

Detta är ju snäppet bättre. Nu är det bara en variabel att hålla reda på per stjärna, vilket är det vi vill ha. Däremot så har vi fortfarande ett lömskare problem: det är ganska svårt att dokumentera och hålla reda på att varje stjärn-`dict` ska se likadan ut.

## Lösningen: `Star` som en klass

För att lösa bägge våra problem kan vi i stället låta våra stjärnor tillhöra en klass som vi kallar `Star` och alla objekt av denna klass blir individuella stjärnor.

Eftersom ett färdigt kodblock är värt 1000 ord, skulle vår klass se ut som såhär:

```{code-cell} python
class Star:
    def __init__(
        self,
        spectral_class,
        luminosity,
        surface_temp_K,
        diameter,
        mass
    ):
        self.spectral_class = spectral_class
        self.luminosity = luminosity
        self.surface_temp_K = surface_temp_K
        self.diameter = diameter
        self.mass = mass
```

Vad betyder varje del då? Först, för att skapa ett objekt från en klass krävs en _konstruktor_. Det är en särskild metod som tillhör en klass, vars syfte är att skapa ett nytt objekt av klassen. Den _bygger_, konstruerar, objektet. I Python heter konstruktorn `__init__(self, ...)` för alla klasser. Konstruktorn tar alltid en parameter först: `self`, som är en referens till det objekt du bygger.

```{sidebar} Attribut & metoder
Ett attribut är en sådan variabel som "tillhör" ett objekt eller en klass. Du kommer åt attribut genom _punktnotation_: `obj.attribute`.

Notera hur jag sade _metod_ denna gång och inte _funktion_. En metod är en sådan funktion som tillhör en klass eller ett objekt. Mer exakt: en funktion som är ett attribut till en klass eller ett objekt. dessa anropas också med punktnotation: `obj.method()`.
```

Det är därefter tillrådligt att även ta samtliga värden som krävs för att tillsätta alla attribut hos objektet som ytterligare parametrar. Vi tar då `spectral_class`, `luminosity`, `surface_temp_K`, `diameter` och `mass` som parametrar för vår konstruktor.

```{code} python
:linenos:
:emphasize-lines: 10-14
class Star:
    def __init__(
        self,
        spectral_class,
        luminosity,
        surface_temp_K,
        diameter,
        mass
    ):
        self.spectral_class = spectral_class
        self.luminosity = luminosity
        self.surface_temp_K = surface_temp_K
        self.diameter = diameter
        self.mass = mass
```

I det efterföljande funktionsblocket tillsätter vi alla attribut som vi vill att objektet skall ha. Som nämn på sidan, kommer vi åt ett attribut med punktnotation. Ex. `self.spectral_class` betyder alltså: _attributet_ `spectral_class` som _tillhör_ `self`. I detta fall är `self` det objekt vi bygger, så `self.spectral_class` betyder attributet `spectral_class` som tillhör det nya objektet. Vi gör denna process för varje attribut.

```{warning} Att tänka på med attribut vs. variabler
Vårt attribut `self.spectral_class` är absolut inte samma sak som funktionsparametern `spectral_class`. De må heta samma sak, men tillhör olika saker. Det är därför vi måste använda `self.`, för att visa tillhörigheten för Pythontolken. Parametern `spectral_class` tillhör metoden och kommer sluta att existera efter den kört klart, precis som alla lokala variabler. Attributet `self.spectral_class` tillhör dock objektet vi skapar och kommer därför existera så länge som det objektet också existerar, vilket kan vara långt längre än körningen av konstruktorn.
```

## Att instansiera en klass

Nu när vi har definierat "receptet" för en `Star`, så vill vi ju kunna skapa individuella stjärnor. Ett skapa en individ, ett objekt, kallas för att _instansiera_ en klass. Med andra ord: att skapa en _instans_, synonymt med objekt, av en klass. I Python är det vanligare att man pratar om _instanser_ och inte objekt, men det är samma sak. Framöver kommer båda begrepp används utbytbart. Vi instansierar genom att anropa konstruktorn:

```{code-cell} ipython
star1 = Star("A", 2.7e6, 4000, 4e8, 6e6)

# Några rader printout för att kolla vad som registrerades
lines = [
    "Vår stjärnas egenskaper:",
    f"Spektralklass: {star1.spectral_class}",
    f"Luminositet: {star1.luminosity} W",
    f"Yttemperatur: {star1.surface_temp_K} K",
    f"Diameter: {star1.diameter} m",
    f"Massa: {star1.mass} kg"
]
print("\n".join(lines))
```

För att anropa konstruktorn skriver vi som om vi skulle anropa själva klassen. Detta anropar automatiskt konstruktorn. Returvärdet är det objekt som vi har byggt i konstruktorn, det vill säga `self` från innan. Detta värde lagras sedan i star1 som blir en referens till detta objekt.

När vi anropade konstruktorn angav vi argument för alla parametrar, precis som en vanligt funktion. Faktiskt gäller exakt samma regler för konstruktorn som för funktioner. Dock finns ett stort undantag: vad hände med `self`? Jo, `self` är ett implicit argument. Den fylls automatiskt ut av tolken och blir en referens till det objekt vi skapar. Du behöver alltså bara ange de parametrar som inte är `self`.

Vi kommer åt de attribut som vi definierat på objektet `star1` genom punktnotation. `star1.luminosity` signifierar att vi vill komma åt attributet `luminosity` som tillhör objektet `star1`.

## Att redigera instansattribut

Nu när vi har vår stjärna så vill vi kanske ändra, lägga till eller till och med ta bort attribut från den instans som vi har. För att redigera eller lägga till ett attribut använder vi samma sätt som vi tillämpade i konstruktorns defintion:

```{code-cell} ipython
import math

star1.luminosity = 2.4e22 # W
print(f"Stjärnans luminositet är nu: {star1.luminosity} W")

# Vi tillämpar mantelytan av en sfär
star1.total_flux = star1.luminosity / (4 * math.pi * (star1.diameter / 2)**2) # W / m^2
print(f"Totalt radiativt flöde genom ytan är {star1.total_flux:.2f} W / m^2")
```

I blocket ovan har vi både ändrat luminositeten och skapat ett nytt attribut `star1.total_flux`. Detta attribut är unik till den instans den är skapad på, alltså kommer den inte att finnas för framtida instanser av `Star`. Alla instanser kommer ha de attribut som definieras i konstruktorn, i alla fall till en början, men de kommer inte att automatiskt ärva nya saker du lägger till i efterhand.

Om du vill ta bort ett attribut är det mycket likt med en `dict`. Du använder dig av nyckelordet `del`.

```{code-cell} python
del star1.total_flux
```
