---
kernelspec:
  name: python3
  display_name: Python 3
---

# Signaler

När du vill samla data från dina sensorer, styra en motor eller annars mäta eller styra någonting elektriskt så använder vi _signaler_. Det finns huvudsakligen två kategorier: _analoga-_ och _digitala_ signaler.

En analog signal är en sådan som kan ändras _kontinuerligt_, det vill säga att den har en oändlig upplösning sett till signalstyrka. En digital signal är en sådan som har en begränsad upplösning. Ofta är en digital signal binär, det vill säga att det "på" eller "av", inga mellanvärden existerar då.

Datorer, och därmed även mikrokontroller, är av natur digitala apparater. Sensorer å andra sidan tenderar att vara analoga i många fall. Några analoga sensorer kan vara:

- Termistor (värmesensor)
- Fotoresistor (ljussensor)
- Kompass (beror på)

medan några digitala sensorer kan vara

- Accelerometer
- Digital vinkelgivare (rotationssensor)
- GPS-modul.

Digitala sensorer har olika sätt att kommunicera med en dator eller annan avläsningsenhet. En digital vinkelgivare skickar exempelvis en puls, en kort signal, för varje gång dess mätobjekt roterar en viss vinkel. Mer invecklade sensorer som GPS-moduler kommunicerar över en s.k. _bus_ vilket du kan tänka på som en kanal för data.

Vi använder bussar för att dessa tillåter flera sensorer att dela på samma sladdar som leder till din avläsare. Vanligast för hobbybruk är I{sup}`2`C-bussen. Namnet står för _Inter Integrated Circuit_, alltså ett protokoll för att kommunicera mellan integrerade kretsar såsom sensorer, mikrodatorer m.m.

## Hur vi mäter signaler

Det allra vanligaste sättet att avläsa signaler är genom att mäta spänningar. Det går såklart att mäta andra egenskaper, men spänning är med marginal det enklaste. Det går även att avläsa resistans ganska lätt, för det kräver endast ett spänningsmått.

(digital-signals)=

### Att avläsa digitala signaler

Hur man läser av digitala signaler är ganska enkelt: du definierar ett värde som anses "på" och ett som definieras som "av". Alla värden som är över "på"-värdet tolkas som "på", eller som en _hög_ signal. Alla värden under "av"-värdet tolkas som "av", eller som en _låg_ signal.

I fallet av en mikrokontroller, exempelvis för vår RP2040, kan _högt_ anses vara allt $\geq$2 V och allt $\leq$0.5 V är _lågt_. Just på RP2040 är maxvärdet 3.3 V och minsta tillåtna är 0 V. Alla spänningar är relativt mikrokontrollerns referenspotential, dvs. jordpin, som låses vid 0 V.

I varje mätpin på en RP2040 finns en inkopplad spänningsmätare. Om spänningen på pinnen är mer än 2 V kommer den rapportera _hög_ vid avläsning och om den är under 0.5 V rapporterar den _låg_. Ifall värdet är mellan 0.5-2 V så är resultatet slumpmässigt. Detta är någonting man måste vara medveten om ifall man läser av digitala signaler.

Ett exempel på tillämpning vara för just pulsgivande sensorer, som den digitala vinkelgivaren. Dess ut-pin är vid 0 V som vanligt och hoppar under kort tid till 3.3 V när en mätpuls inträffar. Den pulsen kan vi läsa av digitalt med vår mikrokontroller och på så sätt räkna vinkel.

### Att avläsa analoga signaler.

Betrakta en _termistor_. Det är en komponent vars resistans varierar med temperaturen. Alltså att $R_{th} = f(T)$ där $f(T)$ är en känd funktion av omgivningens temperatur. Ofta anges ett kalibreringsvärde, till exempel att resistansen är 100 $\Omega$ vid 20$^\circ$C och ändras med $\pm$20$\Omega$ för varje $\pm$1$^\circ$C som temperaturen ändras därifrån. Resistansen är då exempelvis 120 $\Omega$ vid 21$^\circ$C.

Vi kan sedan bygga en krets som heter _spänningsdelare_ där vi kan mäta resistansen av vår termistor i ett givet ögonblick. Sen kan vi använda att vi vet hur resistansen ändras med temperaturen och härleda omgivningens temperatur.

Värdet som vi läser av kommer variera kontinuerligt utan några hopp med omgivningens temperatur. Detta beror på att vi läser av en _materialegenskap_, termistorns resistans. I princip alla förlopp i "verkligheten" är kontinuerliga och därför är deras signaler också analoga. Nästan alla "skapade" förlopp, som pulserna från en vinkelgivare eller I{sup}`2`C-kommunikation, är digitala.

### Att avläsa analoga signaler med digitala system

Datorer, till skillnad från naturen, har inte oändlig upplösning. Detta skapar ett dilemma: vi måste på något sätt konvertera ett värde med oändlig precision till ett värde med ändlig precision. Detta gör vår mikrokontroller åt oss i dess spänningsmätarkrets genom en komponent som kallas för en ADC, en Analog to Digital Converter.

ADC:n har ett referensintervall, i RP2040:ns fall är det 0-3.3 V. 0 V i detta sammanhang innebär att signalen har samma potentials som MCU:ns jordpin, GND. Mer om jord kommer senare. Detta referensintervall delas sedan in i ett antal lika stora delintervall. Varje ADC har, förutom referensintervall, även en upplösning mätt i antal bits. Kom ihåg [hur datorer sparar heltal](../../grunder/variabler/01-hur_datorer_hanterar_data.md#heltal)! På exempelvis en RP2040 finns en 16-bit ADC. Alltså kan ADC:n ge oss ett binärt heltal mellan 000000000000{sub}`2` och 111111111111{sub}`2` vilket motsvarar 0-4095 i bas 10. 3.3 V ger värdet 4095 och 0 V ger värdet 0.

Vi har delat in vårt referensintervall i $2^\text{antal bits}-1$ lika stora bitar. Varje bit omfattar då en spänningsskillnad

$$
\mathrm{d}U = \frac{U_\text{max} - U_\text{min}}{2^\text{antal bits}-1}.
$$

För vårt fall är $U_\text{max} = 3.3\,\mathrm{V}$ och $U_\text{min} = 0\,\mathrm{V}$. Antal bits är 12, så vi får att

$$
\mathrm{d}U = \frac{3.3 - 0}{2^12 - 1} = \frac{3.3}{4095} \approx 0.000806\,\mathrm{V} = 0.806\,\mathrm{mV}.
$$

Det vi har då är att ett mätvärde på 0 motsvarar 0 V, ett värde på 1 motsvarar 0.805 mV, 2 blir 1.61 mV osv tills att värdet 4095 är 3.3 V. En funktion för att beräkna spänningen för ett givet värde är

$$
U(n) = n \cdot \mathrm{d U} = n \cdot \frac{U_\text{max} - U_\text{min}}{2^\text{antal bits}-1}
$$

där $U(n)$ är spänningen för ett mätvärde $n$.

## Hur vi skickar signaler

Signaler är ju inte bara för att avläsas, ibland vill man skicka signaler också. Detta kan vara för att styra en komponent, som en lampa eller motor, eller för att kommunicera med vissa mer invecklade komponenter eller andra datorer. Vår, mikrokontroller kan huvudsakligen skicka digitala signaler.

Mer specifikt kan den skicka binära digitala signaler. I fallet av en RP2040 så gäller 3.3 V för _hög_ och 0 V för _låg_ vid signalgivning. Dessa är de ända två signalnivåer som en RP2040 klarar av att skicka. Som vidare exempel är en Arduino, ett annat märke på MCU, ett 5-volt-system så dess signalnivåer är 5 V för _hög_ och 0 V för _låg_.

Man kan, i programmet man laddar på en MCU, specificera vilka pins man vill använda för att skicka signaler och vilket signalläge dessa pins skall vara på vid ett givet ögonblick.

### Att skicka analoga signaler

Det finns huvudsakligen två sätt att skicka analoga signaler från digitala system: PWM och via en DAC. En DAC, Digital to Analog Converter, är en enhet som tar in ett digitalt värde och gör om det till spänning inom ett visst referensintervall. Alltså raka motsatsen till en ADC. Våra mikrokontrollers har ingen inbyggd DAC och därför kommer vi inte att använda denna teknik.

Den andra vägen är PWM, Pulse-Width Modulation eller pulsviddsmodulering. En PWM signal är en binär digitalsignar som skickas i extremt korta pulser. I stället för att signalen är _hög_ hela tiden, är det t.ex. _hög_ 50% av tiden och _låg_ annars. Över tid är detta i genomsnitt väldigt likt en analog signal med 50% av maxspänningen. Om du gör på- och avslagningen ofta nog så märker man knappt att signalen pulserar. Detta är ett väldigt användbart sätt att låtsas ha en DAC. Nackdelen är att signalen inte är kontinuerlig utan diskret. Kolla på spänning över tid i grafen nedan.

```{code-cell} ipython
:tags: [remove-input]

import numpy as np
import matplotlib.pyplot as plt

v_max = 3.3
cycles = 1
samples_per_pwm_cycle = 200
carrier_cycles = 30

t = np.linspace(0, cycles, cycles * carrier_cycles * samples_per_pwm_cycle, endpoint=False)
signal = 1.65 + 1.65 * np.sin(2 * np.pi * cycles * t / cycles)

carrier = (t * carrier_cycles / cycles) % 1.0
modulation = signal / v_max
pwm = np.where(carrier < modulation, v_max, 0.0)

fig, ax = plt.subplots(figsize=(10, 3))
ax.plot(t, signal, color="black", linewidth=2, label="Sinusvåg")
ax.step(t, pwm, where="post", color="tab:orange", linewidth=1, label="PWM")

ax.set_xlim(0, cycles)
ax.set_ylim(-.5, v_max+.5)
ax.set_yticks(np.arange(0, v_max + 0.001, .3))
ax.set_ylabel("Spänning [V]")

ax.set_xlabel("Tid")

for spine in ax.spines.values():
  spine.set_visible(False)

ax.spines["bottom"].set_visible(True)
ax.spines["bottom"].set_position(("data", 0))

ax.tick_params(axis="both", which="both", length=0)
ax.set_xticks([])
for i in range(1, cycles):
    ax.axvline(x=i, color='gray', linestyle='--', linewidth=0.8)

ax.annotate(
  "",
  xy=(1.02, 0),
  xytext=(0, 0),
  xycoords=("axes fraction", "data"),
  textcoords=("axes fraction", "data"),
  arrowprops=dict(arrowstyle="->", linewidth=1.2, color="black"),
)
ax.annotate(
  "",
  xy=(0, 1.02),
  xytext=(0, 0),
  xycoords=("data", "axes fraction"),
  textcoords=("data", "axes fraction"),
  arrowprops=dict(arrowstyle="->", linewidth=1.2, color="black"),
)

ax.legend(loc="upper right", frameon=True)

plt.show()

```

Titta hur andel tid som signalen är _hög_ ökar när du vill ha hög medelspänning och minskar när du vill ha låg spänning.
