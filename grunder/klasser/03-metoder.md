---
kernelspec:
  name: python3
  display_name: Python 3
---

# Metoder

Som vi har snuddat på i tidigare kapitel är en _metod_ en sådan funktion som tillhör ett objekt eller en klass. I detta kapitel går vi igenom hur vi använder metoder och hur vi skapar egna. Vi har faktiskt använt metoder innan: `"Hej".lower()` är ju ett metodanrop! Du känner igen det från punktnotationen. I ord säger vi "anropa metoden `lower()` på detta objekt av klassen `str`". Vårt objekt har värdet `"Hej"` och `str.lower()` returnerar en kopia av strängen med bara gemener, så uttrycket utvärderas till `"hej"`. Samma koppling gäller vid andra metoder som `list.pop()`. Alla de hör ju till ett objekt, eller en klass.

## Egna metoder: information om stjärnan

Vi driver vidare på exemplet för förra kapitlet med klassen `Star`:

```{code} python
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

Säg att du vill kunna printa den sammafattning som vi hade innan utan att behöva generera alla rader varje gång. Vi kan skapa en återanvändbar metod som gör det åt oss. Du skriver denna metod i klassdefinitionen. Alla metoder som behandlar data från en given instans tar alltid det speciella argumentet `self` först. Dessa metoder kallas _instansmetoder_, eftersom de behandlar data unik till instansen. Vi definierar nu en instansmetod som heter `Star.print_summary()` som gör samma sak som vi gjorde förra kapitlet:

```{code-cell} ipython
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

    def print_summary(self):
        lines = [
            "Vår stjärnas egenskaper:",
            f"Spektralklass: {self.spectral_class}",
            f"Luminositet: {self.luminosity} W",
            f"Yttemperatur: {self.surface_temp_K} K",
            f"Diameter: {self.diameter} m",
            f"Massa: {self.mass} kg"
        ]
        print("\n".join(lines))
```

Eftersom metoden är indenterad in i klassdefinitionen räknas den som att den tillhör klassen. Vi har också skrivit upp den speciella parameters `self`, som vi måste ha för instansmetoder. Metoden kommer bara att fungera på ett objekt, en instans, inte på klassen i sig. `self` kommer precis som i konstruktorn att ersättas av en referens till det aktuella objektet. Vi testar detta nu:

```{code-cell} ipython
my_star = Star("B", 3e12, 3125, 5e6, 6e12)

# Notera hur specialparametern self INTE behöver anges.
# Den blir automatiskt en referens till objektet
# metoden anropas på, dvs. my_star.
my_star.print_summary()
```

Titta, nu kan vi sammanfatta alla våra stjärnor utan manuellt arbete!

Printa grejer är dock inte allt vi kan göra. Säg att vi vill kunna räkna ut totalt flöde ur stjärnans yta. Om vi antar att stjärnan är en perfekt sfär så får vi

$$
\Phi = \frac{L}{4 \pi r^2}.
$$

Vi kan med hjälp av detta formulera en metod som beräknar flödet ur en given stjärna.

```{code-cell} ipython
import math # Superviktigt för att få pi

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

    def print_summary(self):
        lines = [
            "Vår stjärnas egenskaper:",
            f"Spektralklass: {self.spectral_class}",
            f"Luminositet: {self.luminosity} W",
            f"Yttemperatur: {self.surface_temp_K} K",
            f"Diameter: {self.diameter} m",
            f"Massa: {self.mass} kg"
        ]
        print("\n".join(lines))

    def total_flux(self):
        """Return total flux in W / m^2 for the Star."""
        r = self.diameter / 2
        return self.luminosity / (4 * math.pi * r**2)

```

Därefter kan vi nyttja denna metod på samma sätt som innan.

```{code-cell} ipython
my_star = Star("O", 3e14, 3005, 5e5, 6e7)
print(my_star.total_flux())
```

## Att göra din klass `print()`-kompatibel

Vi kan faktiskt gå ett steg längre. Ni minns väl att vi kan printa en variabel med `print(var)`? Kolla vad som händer ifall vi försöker med vårt `Star`-objekt:

```{code-cell} ipython
print(my_star)
```

Det var ju inte särskilt hjälpsamt. Detta beror på att vi inte har berättat för Pythontolken hur man kan representera en `Star` som text. Vår metod `Star.print_summary()` är dock en utmärkt metod för att göra detta! Det enda som saknas är att tolken ska veta om att den finns. I Python används den specialbenämna metoden `obj.__str__()` för att returnera en textuell representation av ett objekt. Den metoden skall returnera en `str` som blir det som printas när man kallar `print()` på objektet. Låt oss nu skriva om vår sammanfattning så att det heter rätt namn, och returnerar en sträng i stället för att printa själv.

```{code} python
class Star:
    ...

    def __str__(self):
        lines = [
            "Vår stjärnas egenskaper:",
            f"Spektralklass: {self.spectral_class}",
            f"Luminositet: {self.luminosity} W",
            f"Yttemperatur: {self.surface_temp_K} K",
            f"Diameter: {self.diameter} m",
            f"Massa: {self.mass} kg"
        ]
        return "\n".join(lines)

```

```{code-cell} ipython
:tags: [remove-input]
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

    def __str__(self):
        lines = [
            "Vår stjärnas egenskaper:",
            f"Spektralklass: {self.spectral_class}",
            f"Luminositet: {self.luminosity} W",
            f"Yttemperatur: {self.surface_temp_K} K",
            f"Diameter: {self.diameter} m",
            f"Massa: {self.mass} kg"
        ]
        return "\n".join(lines)
```

```{code-cell} ipython
my_star = Star("B", 3e12, 3125, 5e6, 6e12)
print(my_star)
```

Titta så smidigt!
