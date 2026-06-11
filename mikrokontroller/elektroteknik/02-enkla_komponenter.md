---
kernelspec:
  name: python3
  display_name: Python 3
---

# Enkla komponenter

```{code-cell} ipython
:tags: [remove-input]
import schemdraw
import schemdraw.elements as elm
elm.style(elm.STYLE_IEC)
ohm = 'Ω'
```

Våra kretsar för mikrokontroller består oftast av några enkla komponenter:

- Ledningar (kablar)
- Resistorer
- LED:er
- Batterier
  - och andra likströmskällor
- Strömbrytare (knappar)

Kretsarna utökas sedan med mer komplexa komponenter:

- Potentiometrar
- Diverse IC:n (Integrated Circuits)
  - Sensorer
  - Klockor
  - m.m.
- Kondensatorer (mer sällan)

Vi börjar dock med de enkla komponenterna och arbetar oss upp till att kunna skapa fullstora kretsar.

## Ledningar

En ledning, också kallat kabel eller sladd, är en metalltråd menad att leda ström utan att hindra det. Vi säger då att kabeln är ideal och har 0 Ω resistans.

Detta innebär följaktligen att potentialen är konstans genom en ledning vilket motsvarar att spänningen _över_ en ledning alltid är 0. Tänk efter, om skillnaden i potential är 0 genom hela kabeln måste spänningen vara 0!

En ledning ser ut såhär i ett kretsschema:

```{code-cell} ipython
:tags: [remove-input]

with schemdraw.Drawing():
  elm.Line().right()
```

## Resistorer

En resistor, likt namnet antyder, är ett elektriskt motstånd. Tänkt dig att det metaforiska röret från innan (sladden) har krympt vid en plats. Vi mäter resistans i enheten Ohm (Ω). Sambandet mellan resistans, ström och spänning kallas Ohms lag och lyder

$$
U = R I.
$$

Ohms lag säger att spänningen $U$ över en resistans $R$ är lika med $R \cdot I$ där $I$ är strömmen genom resistorn. Denna lag låter oss alltid bestämma den 3:e storheten när vi vet 2 av storheterna.

En resistor ser ut såhär i ett kretsschema:

```{code-cell} ipython
:tags: [remove-input]

with schemdraw.Drawing():
  elm.Resistor().right()
```

## Lysdioder LED:er

En LED, som står för Light Emitting Diode, är en sådan komponent som avger ljus när du matar ström genom den. Den har egenskapen, likt en vanlig diod, att släppa igenom ström åt endast ett håll.

Om LED:n leder, dvs. strömmer flyter åt rätt håll, kommer den råda nästan konstant spänning över LED:n oavsett ström. Detta kallas LED:ns _framåtspänning_ och redovisas i tabellen till höger. Faktumet att LED:n är en riktigt bra ledare framåt betyder att man måste använda en resistor för att begränsa strömmen genom LED:n. Det går vi igenom längre ned. Om du försöker leda ström bakåt genom en LED kommer det inte att gå, den kan alltså anses ha oändlig resistans baklänges och nästan 0 resistans framåt. Trots denna analogi gäller _inte_ Ohms lag i sig på en LED!

```{sidebar} Tabell för framåtspänningar
| Färg   | Framåtspänning |
| ------ | -------------- |
| Röd    | 1.5-2.0 V      |
| Orange | 2.0-2.1 V      |
| Gul    | 2.1-2.2 V      |
| Grön   | 1.9-4.0 V      |
| Blå    | 2.5-3.7 V      |
```

En LED ser ut såhär i ett kretsschema: (ledningsriktningen är dit triangeln pekar.)

```{code-cell} ipython
:tags: [remove-input]

with schemdraw.Drawing():
  elm.LED().right()
```

## Batterier (och likströmskällor)

För våra ändamål är ett batteri en likströmskälla, dvs. en drivkraft som puttar elektroner genom en krets åt ett och samma håll. Likströmskällor har en pluspol och en minuspol. Strömmen flödar genom kretsen från plus till minus. Spänningen ett batteri alstrar står angivet på det. Likströmskällor kan vi välja vilken spänning vi vill få ur.

En likströmskälla ser exempelvis ut såhär:

```{code-cell} ipython
:tags: [remove-input]

with schemdraw.Drawing():
  elm.SourceV().up().label("5 V")
```

Om källan specifikt är ett batteri ser det ur såhär:

```{code-cell} ipython
:tags: [remove-input]

with schemdraw.Drawing():
  elm.BatteryCell().up().label("5 V")
```

## Strömbrytare

En strömbrytare, ofta kallat knapp eller spak, är en komponent som kan bryta en ledare. Likt en ledare har den ingen resistans och spänning 0 V. Det är som det låter, knappet eller dylik komponent bryter strömmen och ingen elektricitet kan flöda när den är öppen.

En strömbrytare ser ut såhär:

```{code-cell} ipython
:tags: [remove-input]

with schemdraw.Drawing():
  elm.Switch(contacts=False).right()
```

Den är öppen på schemat, men vare sig den är öppen eller stängd bestäms under körning.
