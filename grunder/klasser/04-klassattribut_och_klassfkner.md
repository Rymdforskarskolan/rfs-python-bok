---
kernelspec:
  name: python3
  display_name: Python 3
---

# Klassattribut, klass- och statiska metoder

Slutligen för grundkapitlet vill jag behandla _klassattribut_, _klassmetoder_ och _statiska metoder_. Dessa urskiljer sig från deras _instans-_ kompisar genom att endast behandla data som _klassen_ har gemensamt för alla objekt. Detta är användbart för att definiera konstanta attribut som gäller klassen i allmänhet och inte ett individuellt objekt, alternativt metoder som t.ex. skapar objekt på andra vis än via konstruktorn direkt.

## Klassen `Star` relativt solen

Inom astronomin är det vanligt att vi använder solen som referenspunkt. Därifrån härstammar enheterna solmassa [$\mathrm{M}_\odot$] bland annat. Vi ska nu utvidga klassen `Star` från tidigare exempel så att vi kan skapa instanser med hjälp av "solenheter" också. För detta så är det fiffigt att definiera tre gemensamma _klassattribut_: solmassan, soldiametern och solluminositeten. Dessa är ju konstanter, och gemensamma för alla stjärnor. Därför är det lämpligt att göra de till _klassattribut_. Vi definierar klassattribut ovanför `__init__(self)` metoden.

```{code-cell} ipython
class Star:
    SOLAR_MASS = 1.989e30 # kg
    SOLAR_LUMINOSITY = 3.828e26 # W
    SOLAR_DIAMETER = 1.3927e9 # m


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

Se hur dessa är indenterade lika mycket som metoderna, alltså tillhör de klassens block. Notera även att de är `UPPER_SNAKE_CASE` eftersom de är konstanter. Vi kommer åt dessa attribut på _både_ klassen och dess alla objekt med punktnotation:

```{code-cell} ipython
:tags: []

print(f"Solar mass: {Star.SOLAR_MASS}")

my_star = Star("K", 12e12, 5800, 5e6, 7e12)
print(f"Solar luminosity: {my_star.SOLAR_LUMINOSITY}")
```

Se hur värdena funkar på både klass och objekt.

## Klassmetoder

Nu vill vi ha en metod som låter oss skapa en `Star`-instans med mätvärden i solenheter. Då definierar vi i stället för en _instansmetod_, en _klassmetod_ som alltid tar den speciella parametern `cls` som är blir en referens till _klassen_ som metoden anropas på. Klassmetoder måste även _dekoreras_ med dekoratorn `@classmethod`. Detta är en formalia så att din editor och tolk förstår sig på vad som händer. Kolla hur det ser ut:

```{code-cell} ipython
class Star:
    SOLAR_MASS = 1.989e30 # kg
    SOLAR_LUMINOSITY = 3.828e26 # W
    SOLAR_DIAMETER = 1.3927e9 # m


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

    @classmethod
    def from_solar_units(cls, spectral_class, luminosity, surface_temp_K, diameter, mass):
        """
        Instantiate Star based on solar units.

        Parameters:
            spectral_class (str): Spectral class of star, e.g. "O","B","A","F","G","K","M".
            luminosity (float): Luminosity in solar luminosity
            surface_temp_K (float): Surface temp in Kelvin
            diameter (float): Diameter in solar diameters
            mass (float): Mass in solar masses

        Returns:
            Star: a new Star object with the provided values converted to SI units.
        """

        mass *= cls.SOLAR_MASS
        luminosity *= cls.SOLAR_LUMINOSITY
        diameter *= cls.SOLAR_DIAMETER

        return Star(spectral_class, luminosity, surface_temp_K, diameter, mass)

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

Titta nu nog på det vi har gjort. Först tar vi och multiplicerar (och ändrar) alla erhållna parametrar med _klassens_ värden på solenheterna:

```{code} python
:linenos:
:emphasize-lines: 7-9
class Star:
    ...

    @classmethod
    def from_solar_units(cls, ...):
        ...
        mass *= cls.SOLAR_MASS
        luminosity *= cls.SOLAR_LUMINOSITY
        diameter *= cls.SOLAR_DIAMETER
        ...
```

Sedan, på slutet, tar vi och returnerar resultatet av att anropa konstruktorn. Vi skapar alltså bara ett nytt objekt med rätt värden som vi sen returnerar ut.

Kolla nu på hur vi kan tillämpa detta:

```{code-cell} ipython
# En Star som har samma egenskaper som solen
our_sun = Star.from_solar_units("F", 1, 5772, 1, 1)
print(our_sun)
```

Ser du hur vår metod räknade om åt oss? Detta är riktigt användbart ifall man har mer än ett sätt att konstruera ett objekt.

## Statiska metoder

Ibland är det fiffigt att låta en funktion som egentligen inte behöver varken klassattribut eller instansattribut ligga under en klass för organisationens skull. Säg i vårt stjärnexempel att vi vill kunna lätt verifiera att en spektralklass är giltig för en huvudsekvensstjärna. I detta fall måste värdet vara ett av `"O", "B", "A", "F", "G", "K", "M"`.

Denna verifiering kräver ingen data från varken klassen ellen en instans. Därför definierar vi den som _statisk_. Statiska metoder tar inga särskilda parametrar och behöver dekoreras med `@staticmethod`. Såhär kan detta se ut:

```{code-cell} ipython
:tags: [remove-input]
class Star:
    SOLAR_MASS = 1.989e30 # kg
    SOLAR_LUMINOSITY = 3.828e26 # W
    SOLAR_DIAMETER = 1.3927e9 # m


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

    @classmethod
    def from_solar_units(cls, spectral_class, luminosity, surface_temp_K, diameter, mass):
        """
        Instantiate Star based on solar units.

        Parameters:
            spectral_class (str): Spectral class of star, e.g. "O","B","A","F","G","K","M".
            luminosity (float): Luminosity in solar luminosity
            surface_temp_K (float): Surface temp in Kelvin
            diameter (float): Diameter in solar diameters
            mass (float): Mass in solar masses

        Returns:
            Star: a new Star object with the provided values converted to SI units.
        """

        mass *= cls.SOLAR_MASS
        luminosity *= cls.SOLAR_LUMINOSITY
        diameter *= cls.SOLAR_DIAMETER

        return Star(spectral_class, luminosity, surface_temp_K, diameter, mass)

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

    @staticmethod
    def is_valid_main_sequence_spectral_class(spectral_class):
        if spectral_class in ("O", "B", "A", "F", "G", "K", "M"):
            return True
        else:
            return False
```

```{code} python
:linenos:
:emphasize-lines: 4-9
class Star:
    ...

    @staticmethod
    def is_valid_main_sequence_spectral_class(spectral_class):
        if spectral_class in ("O", "B", "A", "F", "G", "K", "M"):
            return True
        else:
            return False
```

Vi testar nu och ser:

```{code-cell} ipython
:tags: []

print(f"F är giltig: {Star.is_valid_main_sequence_spectral_class('F')}")
print(f"Z är giltig: {Star.is_valid_main_sequence_spectral_class('Z')}")
```

Se hur vi inte behövde ett objekt för detta. Vi anropar statiska metoder på klassen i första hand. Dock kommer alla instanser också ha en kopia av metoden.
