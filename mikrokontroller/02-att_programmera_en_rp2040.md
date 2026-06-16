# Att programmera en RP2040

I detta kapitel går vi äntligen in på hur du tillämpar allting du har lärt dig hittills för att programmera en RP2040 MCU. Som nämnt i introduktionen använder vi oss av CircuitPython för att koda. CircuitPython är egentligen en uppgradering av MicroPython, som i sin tur är en minimal Pythontolk. Minns du hur vi pratade om att vanliga datorer använde CPython? MicroPython och CircuitPython är också Pythontolkar, men de är små nog att de får plats på en mikrokontroller. I detta kapitel kommer jag att gå igenom det allra mest väsentliga för att kunna programmera en RP2040. Det finns däremot långt för många komponenter för att lära ut varenda en. Vi kommer att gå igenom hur du skickar och läser analoga och digitala signaler, hur du printar till en konsoll och hur du läser från denna konsoll. Annars hänvisar jag till guider online för att lista ut resten.

```{warning} Skillnader i syntax för CircuiPython
För det mesta kan du använda allt du lärt dig i tidigare kapitel. Du kan däremot _inte_ använda `match`-satsen eller skapa en `set` då dessa inte finns implementerade. De flesta pythonmoduler är också annorlunda på CircuitPython.
```

```{note} Förkunskaper
Detta kapitel antar att du vet hur man redigerar och laddar kod på din RP2040. Det kommer gås igenom på föreläsning och handledare finns tillgängliga att hjälpa!
```

## CicuitPythons moduler

Du kanske minns vissa moduler vi tidagare använt: `math` för fler matematiska funktioner och `random` för slumptal. Vi kommer använda samma teknik för att komma åt olika delar av kretskorten.

En modul är på vissa likt en klass: den har metoder och attribut. Den däremot också ha funktioner, vilket en klass inte kan ha. Vi importerar moduler _alltid_ högst upp i filen med en `import`-sats:

```{code} python
:linenos:
import board
import digitalio
# Dessa är exempel, alla importer högst upp!
```

Du måste _alltid_ importera en modul ifall du vill kunna använda dess funktionalitet! De viktigaste modulerna att ha koll på är:

- `digitalio`
- `analogio`
- `pwmio`
- `time`
- `board`

Du kommer även i vissa fall använda moduler som hjälper dig interagera med en viss komponent.

## Vad är egentligen en pin?

Du har nog hört begreppen "pin" i tidigare kapitel och undrat vad det är. En pin, eller anslutningspinne, är en elektrisk kontakt på RP2040-kortet som låter mikrokontrollern kommunicera med omvärlden. Genom pinnarna kan kortet läsa in signaler från till exempel knappar och sensorer, eller skicka ut signaler för att exempelvis styra LED:er, motorer och andra komponenter.

Det finns olika sorters pinnar. Vissa kan användas som digitala in- och utgångar, vilket i detta sammanhang innebär binära signaler (_hög_ och _låg_). Andra pinnar kan läsa analoga signaler och har en inbyggd 12-bit ADC för att göra om värdet till siffror för din kod. Vissa pinnar har dessutom särskilda funktioner, till exempel för kommunikation via protokoll som I{sup}`2`C, SPI eller UART.

Varje pin är en instans, ett objekt, av klassen `digitalio.DigitalInOut` eller `analogio.AnalogInOut`. Klasserna `__init__()`-metoder tar ett pin-nummer som argument och det resulterande objektet representerar den fysiska in- och utgången på kortet. Du kan sedan använda metoder på ditt objekt för att ändra från läsläge till signalgivningsläge m.m.

## Mikrokontrollerns "Hello, World!"

Terminalmjukvara brukar hälsa "Hello, World!" som ett test för att allting funkar. På en mikrokontroller är det sedvanligt att blinka en LED för att testa sakers integritet.

Ett blinkprogram för RP2040 ser ut såhär:

```{code} python
:linenos:
import board
import digitalio
import time

led = digitalio.DigitalInOut(board.LED)
led.direction = digitalio.Direction.OUTPUT

while True:
    led.value = True
    time.sleep(0.5)
    led.value = False
    time.sleep(0.5)
```

Först importerar vi nödvändiga moduler. Sedan sparar ett `digitalio.DigitalInOut`-objekt i variabeln `led` som representerar vår LED pin. Numret för den inbyggda LED finns alltid i modulattributet `board.LED`. Därefter sätter vi led-pinnens signalriktning till `OUTPUT`. Mer specifikt till ett riktningsobjekt genom `digitalio.Direction.OUTPUT`, så se till att alltid använda denna notation!

Efter vi initierat alla variabler vi behöver startar vi kodens _huvudslinga_. Det är en, ofta oändlig, slinga som gör programmets huvudfunktion tills du bryter den eller kretskortet förlorar strömtillförseln. I detta fall så ställer vi värdet av `led.value` till `True` vilket motsvarar _hög_ eller "på". Då kommer det att ligga 3.3 V på pinnen.

Vi väntar sedan 0.5 sekunder genom att anropa `time.sleep()`-metoden. Denna tar ett argument med antal sekunder att pausa körningen. Sist sätter vi värdet av `led.value` till `False` vilket kommer återställa den fysiska pinnen till 0 V och därefter väntar vi en halv sekund igen. Detta upprepar vi för evigt eftersom `while True`-slingan aldrig slutar om man inte använder `break`.

## Digital IO

Först kommer vi att diskutera digitala signaler. Minns ni att det avlästa värdet [är slumpmässigt om en tvetydig signal läses](./elektroteknik/04-signaler.md#digital-signals)? Detta behöver vi nu åtgärda. Detta görs med en s.k. Pull-up eller Pull-down resistor. Dessa används för att hålla signalen "ren" när den inte _drivs_. Att driva en pin innebär att mata 3.3 V till den, eller koppla den till jord (0 V). Vår RP2040 har inbyggda pull-up och pull-down resistorer så du kommer inte behöva koppla kretsen själv, men vi går igenom hur man skulle kunna göra detta.

### Pull-up resistorer

En Pull-up resistor "drar" signalen _högt_ när du inte gör någonting med pinnen. Du måste alltså koppla signalen till jord, 0 V, för att göra signalen _låg_. Din RP2040 har en fiffigt pin: GND, som alltid är låst till 0 V som du kan använda för detta syfte. Du skapar då en krets mellan en digital pin och jord. Sedan har du en strömbrytare på den kretsen. När brytare är öppen så drar Pull-up resistorn signalen _högt_, och du kommer då läsa `pin.value == True` i kod. När du sluter din strömbrytare kommer du ha en ledning mellan jord och din pin. Vi vet ju att potentialen är konstant genom en ledning så även pinnen blir låst till 0 V. Då läser du `pin.value == False` i stället.

```{figure} ./pull-up.png
En strömbrytare med Pull-up resistor.
```

Titta hur pin D10 är förbunden med +3.3 V när strömbrytaren är öppen. Detta gör att vi läser av _hög_ på pin D10. När du sluter strömbrytare kommer vi tvinga hela den ledningen vara 0 V eftersom vägen till GND har lägre resistans än vägen till +3.3V. Det kommer då falla 3.3 V över resistorn, så vi förlorar lite ström med detta. Man ska då välja en ganska hög resistans, för låg ström.

### Pull-down resistorer

En Pull-down resistor är motsatsen. Den "drar" signalen _lågt_ när du inte gör någonting och du måste dra den _högt_ med ex. en strömbrytare (knapp) för att läsa av tillstånden. I denna konfiguration är värdet `pin.value == False` vanligt, och `pin.value == True` när du sedan förbinder den med +3.3 V.

```{figure} ./pull-down.png
En strömbrytare med Pull-down resistor.
```

Se hur du har bundit pinnen till GND, 0 V, när strömbrytaren är öppen. Då läser vi av _låg_ signal. När vi sedan sluter brytaren kommer vi låsa hela ledningen och mäta _hög_ (3.3 V) på pin D10. Det faller sedan 3.3 V över resistorn mot GND för att sluta kretsen. Detta innebär en liten energiförlust, även här skall man välja en stor resistans.

### Digital avläsning på RP2040

Din RP2040 har ett antal digitala pinnar, alla märkta ex. D10 på kretskortet. Varje pin kommer du åt via `board`-modulen som ex. `board.D10`. Vi kan använda modulen `digitalio` för att skapa referenser till dessa pinnar och manövrera dem från kod. För att läsa måste `pin.direction` vara inställt till `digitalio.Direction.OUTPUT`. Du kan också välja vilken pull du vill ha genom att sätta `pin.pull` till `digitalio.Pull.UP` eller `digitalio.Pull.DOWN`. Mer kompakt kan du använda `pin.switch_to_input()`.

```{code} python
:linenos:
import board
import digitalio

# Ponera att en knapp är ansluten på D12 och vi vill ha Pull-up verkan
switch = digitalio.DigitalInOut(board.D12)
switch.switch_to_input(pull=digitalio.Pull.UP)

# Vi ser sedan värdet genom att läsa .value attributet
# Denna är alltid True eller False för digital IO.
switch.value

# Du kan även göra mer långdraget
switch = digitalio.DigitalInOut(board.D12)
switch.direction = digitalio.Direction.INPUT
switch.pull = digitalio.Pull.UP
```

Vilken pull du väljer bestämmer hur du skall läsa av pinnen. Om du väljer `Pull.UP` gäller ju att pinnen är `True` om du inte sluter knappen. Dvs. att om en if-sats skall kolla om en knapp med pull-up är intryckt kollar du `if not switch.value`. Väljer du `Pull.DOWN` kommer pinnen läsa `False` vanligtvis och `True` när knappen är sluten. Då läser du av `if switch.value` i stället.

### Digital signalgivning på RP2040

Denna process är lik den för avläsning. Skillnaden är att du inte behöver varken pull-up eller pull-down resistorer. När pinnen agerar output, signalgivare, kommer den att ha antingen 0 V på sig (samma som GND) eller +3.3 V. När du ställer pinnens värde till `False` skickas 0 V och om du ställer den till `True` skickas 3.3 V.

Titta åter på LED-exemplet ovan:

```{code} python
:linenos:
import board
import digitalio
import time

led = digitalio.DigitalInOut(board.LED)
led.direction = digitalio.Direction.OUTPUT

while True:
    led.value = True
    time.sleep(0.5)
    led.value = False
    time.sleep(0.5)
```

Vi plockar specialpinnen `board.LED` men vi hade lika gärna kunnat välja `board.D4` till exempel. Därefter ställer vi dess `pin.direction` till `digitalio.Direction.OUTPUT` för att markera att denna pinne skall ge signaler. Därefter så kan vi, men helt vanlig variabeltillsättning, ställa värdet som pinnen ger till `True` för 3.3 V och `False` för 0 V (ingen ström). Du kan även använda `pin.switch_to_output()` för att göra detta mer läsligt. Däremot har det ingen skillnad i funktionalitet.

## Analog IO

Att ta emot och ge analoga signaler på digitala enheter är inte helt självklart. Din RP2040 kommer dock med ett antal analoga pins: A0-A3 som alla har en inbyggd ADC för att avläsa analoga signaler. Den ADC:n har en upplösning av 12 bitar som nämnt innan. För att skicka analoga signaler krävs en DAC, vilket en RP2040 inte har. Däremot har RP2040:n PWM-förmåga på alla pins (dock inte alla samtidigt). Dessa kan "låtsas" vara analoga m.h.a. pulsviddsmodulering som nämnt innan.

### Analog avläsning på RP2040

Du använder modulen `analogio` och skapar ett `analogio.analogIn`-objekt. Detta objekt kan inte funka som både in och ut, till skillnad från dess mostvarighet för den digitala världen. Detta beror på att vi endast kan läsa analogt. Säg till exempel att vi vill läsa spänningen på pin A2 och sedan skriva värdet varje sekund till serialkonsollen. Då ser koden ut såhär:

```{code} python
:linenos:
import board
import analogio
import time

pin_to_read = analogio.AnalogIn(board.A2)

def get_voltage(pin):
    """Return the voltage at given analog pin in Volts."""
    # Vi använder formeln från tidigare kapitel: Umin = 0 V, Umax = 3.3 V, 2^16-1=65535
    return pin.value * ( 3.3 / 65535 )

while True:
    # Skriv ut returvärdet
    print(get_voltage(pin_to_read))

    # Vänta 1 sek
    time.sleep(1)
```

Vi skapar alltså ett `analogio.AnalogIn`-objekt som vi lagrar i variabeln `pin_to_read`. Vi skapar sedan en funktion `get_voltage()` som räknar om ADC-värdet till en spänning från 0.0-3.3V. Därefter definierar vi huvudslingan med en print till serial och en väntan på 1 sek.

### Analog signalgivning på RP2040

Som tidigare nämnt är sann analog signalgivning ej möjlgit med en RP2040 ensamt eftersom den saknar DAC. Däremot går det att göra PWM-signaler som trots deras digitala egenskaper ändå kan styra vissa komponenter. Vi använder modulen `pwmio` för att göra detta. Du kommer instansiera ett `pwmio.PWMOut` för en given pin, frekvens och duty cyle. Frekvensen anger hyr många PWM-cykler på 1 sekund som förekommer. Duty cycle anger hur stor andel av den tiden som signalen är _hög_. Precis som ADC:n är detta ett 16-bit heltal. 65535 är 100%, 0 är 0%. En duty cycle av 0 innebär alltså att signalen är _låg_, 65535 innebär att signalen är _hög_ och exempelvis 21845 innebär att signalen är _hög_ ca. 1/3 av tiden och _låg_ 2/3 av tiden. Detta medför också att medelspänningen är `Umax * (duty_cycle / 65535)` där `Umax` som känt är 3.3V.

Ett användingsområde för PWM är att dimmra en LED. Om LED:n bara lyser hälften av tiden, kommer den uppfatta det som att den lyser hälften så start. Detta antar att du väljer en så pass hög frekvens att blinkandet inte märks. Vi kollar på ett exempel:

```{code} python
:linenos:

import time
import board
import pwmio

# Vi skapar ett pin-objekt för LED:n,
# med en frekvens på 5000 Hz (5000 ggr per sek)
# samt en duty cycle som från början är 0 (av).
led = pwmio.PWMOut(board.LED, frequency=5000, duty_cycle=0)

while True:
    # Vi återställer duty_cycle varje loop
    led.duty_cycle = 0


    for i in range(50):
        # Vi ställer duty cycle till i / 50-delar av maxvärdet.
        # i ökar för varje loop, så LED:n dimras upp
        # Vi avrundar ned värdet till en int
        led.duty_cycle = int((i / 50) * 65535)

        # Vänta sedan 10 ms till nästa loop
        time.sleep(10e-3)

    # Efter loopen är led.duty_cycle = (49 / 50) * 65535

    for i in range(50):
        # Vi ställer duty cycle till (50 - i) / 50-delar av max.
        # Vi börjar alltså med i = 0 och duty_cycle = 65535
        # Därefter klättar vi ned till duty_cycle = 65535 - (49 / 50) * 65535
        led.duty_cycle = 65535 - int((i / 50) * 65535)

        # Vänta sedan 10 ms till nästa loop
        time.sleep(10e-3)
```

Denna kod kommer att pulsera en LED. Vi har valt frekvensen 5kHz eftersom det är lagom snabbt för det mesta. Det kommer ta en halv sekund att dimra upp och en halv sekund att dimra ned. Testa på ditt eget kretskort och se!

## Att ge information via serieporten

Din RP2040, och de flesta MCU:n, har vad som kallas ett _seriellt interface_. Nurförtiden är den över USB, så den sladd du kopplar till din dator. Detta protokoll låter dig skicka och ta emot text från datorn du är trådbunden till. Det är ovärderligt för att kunna avgöra varför en kod går fel. Du kan använda `print()` och `input()` precis som du skulle i vanlig Python. Kom dock ihåg att du måste vara ansluten till en dator med en seriellmonitor för att detta skall fungera. Det finns en seriellmonitor i VSCode du kan använda.

## Att spara data i filer

Återigen, precis som vanlig Python, kan även CircuitPython använda sig av filer för att lagra och spara data. Ombord på din RP2040 har du ca 7 MB av lagring som skall delas mellan din källkod och eventuella filer den skriver.

Till skillnad från vanligt Python, så är filsystemet på en mikrokontroller mer skör. Det innebär att du inte kan ha att både datorn och CircuitPython-programmet kan skriva till minnet samtidigt. Vi löser detta problem genom att filsystemet kan läsas av båda, men bara skrivas av ena. Från början kan datorn skriva på filsystemet. Om du vill lagra data under körning av din kod behöver du ändra detta.

För att genomföra ändringen använder vi oss av en ny typ av fil `boot.py`. Tidigare har du ju skrivit i `code.py`. `boot.py` körs en gång varje start av mikrokontrollern. I `boot.py` kan vi sedan använda `storage`-modulen för att ändra vilket av enheterna får skriva till minnet.

```{danger} *OBS!* Du kan låsa minnet permanent i ett ej skrivbart läge!
Om du skriver en `boot.py` som alltid låser minnet för datorn, kommer du aldrig kunna ändra innehållet i filen. Du kommer heller inte kunna ändra i `code.py`. Om du har råkat göra detta, prata med en handledare. De kan hjälpa dig att återställa din mikrokontroller. Du kommer sannolikt inte paja hela enheten såhär, men försök undvika det ändå.
```

När vi nu skall författa vår `boot.py` är det viktigt att det finns en mekanism för att ställa om vilken enhet som får skriva. Enklaste sättet att göra detta är att nyttja en av våra digitala pins. Vi definierar att filsystemet är skrivbart för RP2040:n om pinnen är _låg_, annars när den är _hög_ kan datorn skriva. Vi ställer då in pinnen i digital-in-läge med pull-up. Det betyder att den kommer läsa _hög_ när pinnen lämnas fri. Vi kan sedan, när vi önskar, ansluta pinnen till GND för att sänka den till _låg_ och därmed tillåta filoperationer för RP2040:n.

En sådan `boot.py`-fil ser ut såhär:

```{code} python
:linenos:
import board
import digitalio
import storage

# Du får välja vilken digital pin som helst
readonly_switch = digitalio.DigitalInOut(board.D4)
# Vi ställer sen till INPUT med pull-up.
readonly_switch.switch_to_input(pull=digitalio.Pull.UP)

# Vi läser av pinnen, om den är hög (True) så är filsystemet
# ej skrivbar för RP2040:n. Detta sker om pinnen är fri.
# Om värdet är lågt (False) har du kopplat till GND
# och vi får skriva från RP2040:n.
storage.remount("/", readonly=readonly_switch.value)
```

````{warning} Angående fel som kan uppstå
Alla filoperationer som innebär skrivande kommer att krascha ditt program medan filsystemet inte är skrivbart för RP2040:n. Du måste alltså koppla din switch-pin till GND för att kunna köra din kod. Det är helt okej att datorn är ansluten medan du kopplar så. Då kan du både skriva till minnet och läsa serial samtidigt. Men kom ihåg att koppla loss och start om RP2040:n om du skall ändra din kod.

```{hint} Om mer avancerad hantering av skrivfel
:class: dropdown
Du kan också använda en `try` sats och fånga `OSError` för att hantera det fel som uppstår. Den typen av felhantering ingår inte i kursen. Du kan läsa på själv om du vill.
```

````

När du väl har fixat din `boot.py` är proceduren för att skriva och läsa filer exakt samma som vanlig python. Det kan du läsa om kapitlet [Filhantering](../grunder/07-filhantering.md).

## Att använda mer avancerade komponenter

Många komponenter är mer invecklade än bara _hög_ eller _låg_ eller ens ett enstaka analogt värde. Då använder vi de bussar som nämndes tidigare. Vanligast för vår utrustning är I{sup}`2`C. Om ditt projekt använder sådana komponenter kan du fråga din handledare.
