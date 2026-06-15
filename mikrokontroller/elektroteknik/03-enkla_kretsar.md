---
kernelspec:
  name: python3
  display_name: Python 3
---

# Enkla kretsar

```{code-cell} ipython
:tags: [remove-input]

import schemdraw
import schemdraw.elements as elm
# schemdraw.use("svg")
elm.style(elm.STYLE_IEC)
```

I detta kapitel går vi igenom vissa av de mest grundläggande kretsar vi kan bygga. Detta innefattar även hur man reducerar en mer komplex krets till en enklare sådan.

För och främst kommer vi dock att gå igenom viktiga lagar som gäller alla kretsar. Utifrån dessa lagar kan vi sedan beräkna det elektriska tillståndet i alla punkter i kretsen. Och när ni kan det, då har ni grejat (nästan) all ellära ni behöver för RFS!

## Lagen om spänningsdelning

Att _seriekoppla_ två komponenter innebär att man kopplar de efter varandra längs samma ledare. För en krets med seriekopplade resistorer som nedan

```{code-cell} ipython
:tags: [remove-input]

with schemdraw.Drawing():
    elm.Line().dot(open=True).left()
    elm.Gap().up().label(("-", "", "", r"$U_\mathrm{tot}$"))
    elm.Gap().up().label(("Spänning", "", "+"))
    line = elm.Line().idot(open=True).right()
    R1 = elm.Resistor().down().label("$R_1$")
    R2 = elm.Resistor().down().label("$R_2$")
    elm.VoltageLabelArc().at(R1).label("$U_1$")
    elm.VoltageLabelArc().at(R2).label("$U_2$")
    elm.CurrentLabelInline("out", start=False).at(line).label("$I$")
```

gäller att $U_\mathrm{tot} = U_1 + U_2$. Det framgår av [Kirchhoffs spänningslag](#kirchhoff-2). Enligt [Ohms lag](./02-enkla_komponenter.md#resistorer) gäller även att

$$
U_1 = R_1 I, \quad U_2 = R_2 I \quad \Longleftrightarrow \quad U_\mathrm{tot} = I (R_1 + R_2)
$$

Från detta följer att

```{math}
U_1 = U_\mathrm{tot} \cdot \frac{R_1}{R_1 + R_2}
```

samt att

$$
U_2 = U \cdot \frac{R_2}{R_1 + R_2}.
$$

(stromdelning)=

## Lagen om strömförgrening

När man _parallellkopplar_ två komponenter har man kopplat de längs två olika ledare som: börjar från en punkt, förgrenar sig sedan återförenas efter komponenterna. Om du parallellkopplar två resistorer såhär:

```{code-cell} ipython
:tags: [remove-input]

with schemdraw.Drawing() as d:
    line = elm.Line().dot(open=True).left()
    elm.Gap().up().label(("-", r"$U_\mathrm{tot}$","+"))
    elm.Line().idot(open=True).right().dot()
    with d.hold():
      R1 = elm.Resistor().down().label("$R_1$")
    elm.Line().right()
    R2 = elm.Resistor().down().label("$R_2$")
    elm.Line().left().dot()
    elm.VoltageLabelArc().at(R1).label("$U_1$")
    elm.VoltageLabelArc().at(R2).label("$U_2$")
    elm.CurrentLabelInline().at(line).label("$I$")
    elm.CurrentLabelInline().at(R1).label("$I_1$")
    elm.CurrentLabelInline().at(R2).label("$I_2$")
```

kommer följande saker att gälla. Först, så gäller det att

$$
I = I_1 + I_2
$$

enligt [Kirchhoffs lag om strömdelning](#kirchhoff-1). Summan av strömmen in/ut ur den parallelkopplade delen måste vara lika med strömmarna i varje ledning i den parallellkopplade delen. Det gäller därefter även att

$$
U_\mathrm{tot} = U_1 = U_2
$$

enligt Kirchhoffs spänningslag. Eftersom potentialen är samma på plussidan av bägge resistorer och fäst till $+U_\mathrm{tot}$, samt att potentialen vid minussidan är 0 V eftersom strömkällans minuspol är alltid 0 V, gäller det att spänningsfallet över resistorerna måste vara samma. Från detta går det att härleda strömdelningsekvationerna

$$
I_1 = I \cdot \frac{R_2}{R_1 + R_2}
$$

och

$$
I_2 = I \cdot \frac{R_1}{R_1 + R_2}.
$$

## Kirchhoffs lagar

Matematikern [Gustav Kirchhoff](https://en.wikipedia.org/wiki/Gustav_Kirchhoff) formulera två ekvivalenser inom kretsläran som är ytterst användbara. De har att göra med hur ström och spänning delar sig i en sammansatt krets. Dessa samband kallar vi Kirchhoffs lagar.

(kirchhoff-1)=

### Kirchhoffs strömdelningslag (Kirchhoff I)

Denna lag lyder: "Summan av alla strömmar in i en punkt är lika med summan av alla strömmar ut ur samma punkt." Detta är en omformulering av originalet, men betydelsen är densamma. Ursprungligen säger lagen att "Den algebraiska summan av alla strömmar som möts i en punkt är 0". Detta är likvärdigt eftersom strömmar in i punkten blir positiva och strömmar ut är negativa, men den senare formuleringen är inte lika intuitiv.

Vi betraktar ett exempel:

```{code-cell} ipython
:tags: [remove-input]

with schemdraw.Drawing() as d:
  line1 = elm.Line().right().dot()
  with d.hold():
    line2 = elm.Line().up()
  with d.hold():
    line3 = elm.Line().right()
  line4 = elm.Line().down()
  elm.CurrentLabelInline("out", start=False).at(line1).label("$I_1$",loc="bottom")
  elm.CurrentLabelInline("out").at(line2).label("$I_2$",loc="bottom")
  elm.CurrentLabelInline("out", start=False).at(line3).label("$I_3$")
  elm.CurrentLabelInline("out", start=False).at(line4).label("$I_4$")
```

Här har vi fyra strömmar som alla går in eller ut ur samma punkt. Vi vet då enligt lagen att

$$
I_1 + I_2 = I_3 + I_4.
$$

säg som exempel att $I_1$ = 4 A, $I_2$ = 3 A och $I_3$ = 2 A. Om vi sedan vill bestämma $I_4$ nyttjar vi Kirchhoff II:

$$
I_1 + I_2 = I_3 + I_4 \implies I_4 = I_1 + I_2 - I_3 = 4 + 3 - 2 = 5\,\mathrm{A}.
$$

Detta tillämpas främst vid parallelkopplingar som ovan med [strömdelning över parallella resistaner](#stromdelning).

(kirchhoff-2)=

### Kirchhoffs spänningslag (Kirchhoff II)

Lagen lyder: "Summan av potentialskillnader genom en sluten krets är alltid 0". Denna lag innebär att om du går komponent för komponent i strömmens riktning genom en krets och summerar spänningarna kommer du till slut att få 0. Spänningskällor ökar potentialen och spänningsförbrukande komponenter (de flesta) sänker potentialen. Det är darför vi säger att det finns en viss spänning som _faller_ över en viss komponent.

Vi betraktar ett exempel:

```{code-cell} python
:tags: [remove-input]

with schemdraw.Drawing():
  elm.SourceV().up().label("12 V")
  R1 = elm.Resistor().right().label(r"120 $\Omega$", loc="bottom")
  elm.Line().down()
  R2 = elm.Resistor().left().label(r"720 $\Omega$")
  elm.VoltageLabelArc().at(R1).label(r"$U_1$")
  elm.VoltageLabelArc().at(R2).label("$U_2$")
```

Vi börjar då från spänningskällans pluspol. Där är potentialen 12 V, källans angivna _polspänning_. Därefter rör vi oss genom kretsen. Vi vet dock inte spänningen över någon av resistorerna. För att nytta Ohms lag ($U = R I$) krävs strömmen, som vi inte har. Därför kan vi i stället nytta spänningsledningslagen ovan för att få

$$
U_1 = 12\,\mathrm{V} \cdot \frac{120\,\Omega}{120\,\Omega + 720\,\Omega} = 12 \cdot \frac{120}{840} \approx 1.71\,\mathrm{V}
$$

och

$$
U_2 = 12\,\mathrm{V} \cdot \frac{720\,\Omega}{120\,\Omega + 720\,\Omega} = 12 \cdot \frac{720}{840} \approx 10.29\,\mathrm{V}.
$$

Med ord blir detta att spänningen över resistans 1, med värdet 120 $\Omega$, är 1,71 V och spänningen över resistans 2, med värdet 720 $\Omega$, är 10.29 V.

Med denna information kan vi genomföra en s.k. _potentialvandring_ genom kretsen. Vi börjar återigen vid källas + med potentialen 12 V. Vi passerar därefter resistansen 120 $\Omega$. Där faller spänningen 1,71 V som vi beräknade. Efter resistorn är alltså potentialen 12 - 1.71 = 10.29 V. Efter resistorn kommer en ledning, som vi vet har ett spänningsfall på 0 V, så 10.29 - 0 = 10.29 V potential efter. Slutligen passerar vi den andra resistorn som vi beräknade har en spänning på 10.29 V. 10.29 - 10.29 = 0 V, vilket uppfyller Kirchhoff II enligt ovan. Därmed är vi också klara med potentialvandring eftersom vi har kommit tillbaka dit vi började: spänningskällan.

Man kan faktiskt börja var som helst i kretsen och få samma resultat. Kom bara ihåg att spänningskällan adderar sin spänning till den totala potentialen medan alla förbrukare subtraherar sin spänning från totalen!

## Att reducera kretsar

En elektrisk krets kan ofta bli väldigt förvirrande när den är stor. Därför har vi uppfunnit metoder för att reducera en invecklad krets till mindre delar. Reduktionen leder ofta i slutändan till någonting som heter en _tvåpolsekvivalent_[^tvapol]. Det är en liten krets med två fria poler vars potentialer och ström motsvarar exakt den krets som tvåpolsekvivalenten representerar. Man kan även tillämpa reduktionsmetoder på samlingar av resistorer för att göra komplexa resistorkedjor eller parallellkopplingar till endast en ekvivalent resistor.

### Ekvivalens med resistorer i serie

Om du har ett antal resistorer kopplade i serie efter varandra:

```{code-cell} ipython
:tags: [remove-input]

with schemdraw.Drawing():
  elm.Resistor().right().label("$R_1$")
  elm.Resistor().right().label("$R_2$")
  elm.Gap().right().label(("","...",""))
  elm.Resistor().right().label("$R_n$")
```

så kommer deras resistanser att vara summan av alla resistanser i kedjan. Det vill säga att

$$
R_\mathrm{ekv} = R_1 + R_2 + \cdots + R_n = \sum_{i = 1}^n R_i.
$$

Det följer även naturligt att

$$
U_\mathrm{ekv} = U_1 + U_2 + \cdots + R_n = \sum_{i = 1}^n U_i.
$$

### Ekvivalens med parallellkopplade resistorer

Om ett antal resistorer kopplas parallellt med varandra såhär

```{code-cell} ipython
:tags: [remove-input]

with schemdraw.Drawing() as d:
  elm.Line().idot(open=True).label("A",loc="left").right().dot()
  with d.hold():
    elm.Resistor().down().label("$R_1$").dot()
  elm.Line().right(0.5*d.unit)
  with d.hold():
    elm.Resistor().down().label("$R_2$").dot()
  elm.Line().right(d.unit * 0.5)
  with d.hold():
    elm.Line().down((1/3)*d.unit)
    elm.Gap().down((1/3) * d.unit).label(("","...",""))
    elm.Line().down((1/3)*d.unit)
  elm.Line().right(d.unit * 0.5)

  elm.Resistor().down().label("$R_n$")

  elm.Line().left(d.unit * 0.5)
  elm.Line().left(d.unit * 0.5)
  elm.Line().left(d.unit * 0.5)
  elm.Line().left().dot(open=True).label("B", loc="left")
```

gäller att deras resistanser adderas reciprokalt. Det vill säga

$$
\frac{1}{R_\mathrm{ekv}} = \frac{1}{R_1} + \frac{1}{R_2} + \cdots + \frac{1}{R_n} = \sum_{i = 1}^n \frac{1}{R_i}.
$$

eller omskrivet att

$$
R_\mathrm{ekv} = \left(\frac{1}{R_1} + \frac{1}{R_2} + \cdots + \frac{1}{R_n}\right)^{-1} = \left( \sum_{i = 1}^n R_i^{-1} \right)^{-1}
$$

För spänningarna gäller återigen enligt [Kirchhoffs spänningslag](#kirchhoff-1) att

$$
U_{AB} = U_\mathrm{ekv} = U_1 = U_2 = \cdots = U_n.
$$

Detta innebär med ord att spänningen över alla resistorer är densamma, oavsett vilken resistans de har.

### Reduktion till tvåpolsekvivalent

De ekvivalenter vi bygger i denna kurs kommer alltid att se ut såhär:

```{code-cell} ipython
:tags: [remove-input]

with schemdraw.Drawing():
  elm.Line().left().idot(open=True).label("B",loc="right")
  elm.SourceV().up().label(r"$E$")
  elm.Resistor().right().dot(open=True).label("A",loc="right").label(r"$R_\mathrm{ekv}$")
  elm.Gap().down().label(("+", r"$U_\mathrm{ekv}$", "-"))

```

En krets med enbart _resistiva_ komponenter, dvs. komponenter som är resistorer eller beter sig mer eller mindre som resistorer, går att reducera till en sådan här _tvåpolsekvivalent_. De två polerna är då $A$ och $B$. Spänningen mellan punkter $A$ och $B$ är densamma som där man valt att placera den krets man vill modellera.

Spänningen $E$ är den så kallade _elektromotoriska kraften_ hos den ekvivalenta strömkällan. Resistansen $R_\mathrm{ekv}$ kallas för _inre resistans_. Fördelen med en sådan här reduktion är att du kan representera en mycket komplex koppling och krets i sin helhet med bara två ekvivalenta komponenter. I alla fall om kretsen endast är resistiv. Det finns andra ekvivalenter för mer komplexa fall, men de kommer vi inte att behandla.

[^tvapol]: I detta fall behandlar vi mer specifikt en _spänningsekvivalent_ som är en typ av _tvåpolsekvivalent_. Den andra typen är _strömekvivalent_ och används mycket sällan.

### Ett invecklat exempel på reduktion

För att illustrera varför detta kan vara användbart kollar vi på följande exempel:

```{code-cell} ipython
:tags: [remove-input]

with schemdraw.Drawing(unit=2) as d:
  elm.SourceV().up(4 * d.unit).label("230 V")
  elm.Resistor().right(1.5 * d.unit).label(r"320 $\Omega$")
  elm.Line().down().dot()
  with d.hold():
    elm.Line().left(0.5* d.unit)
    elm.Resistor().down().label(r"1090 $\Omega$")
    elm.Resistor().down().label(r"420 $\Omega$")
    elm.Line().right(0.5* d.unit).dot()
  elm.Line().right(0.5* d.unit)
  elm.Resistor().down().label(r"512 $\Omega$")
  with d.hold():
    elm.Line().right(0.2 * d.unit).label("A",loc="right").idot()
  elm.Lamp2().down()
  with d.hold():
    elm.Line().right(0.2 * d.unit).label("B",loc="right").idot()
  elm.Line().left(0.5* d.unit)
  elm.Resistor().down().label(r"330 $\Omega$")
  elm.Line().left(1.5 * d.unit)
```

Detta är en krets med många olika resistorer och en glödlampa. Glödlampan är cirkeln med ett kryss i. En glödlampa är egentligen en resistiv tråd som lyser när den blir varm. Vi vill nu undersöka vilken ström och spänning lampan drivs med så vi skall konstruera en tvåpolsekvivalent mellan punkterna A och B.

Första stegen i denna process är att "klippa" kretsen mellan A och B sedan "vika upp" den. Det ser ut såhär:

```{code-cell} ipython
:tags: [remove-input]

with schemdraw.Drawing(unit=2) as d:
  elm.SourceV().up(2 * d.unit).label("230 V")
  elm.Resistor().right(1.5 * d.unit).label(r"320 $\Omega$").dot()
  with d.hold():
    elm.Resistor().right().label(r"512 $\Omega$")
    elm.Line().right(0.2 * d.unit).label("A",loc="right").dot(open=True)
  elm.Resistor().down().label(r"1090 $\Omega$")
  elm.Resistor().down().label(r"420 $\Omega$").dot()
  with d.hold():
    elm.Line().right(1.2 * d.unit).label("B",loc="right").dot(open=True)
  elm.Resistor().left(1.5 * d.unit).label(r"330 $\Omega$",loc="bottom")
```

Ta dig en stund nu och tänk igenom varför detta är ekvivalent. Försök hitta alla kopplingar där jag har roterat anslutning och där jag har "vikt" kretsen!

Vi skall sedan börja reducera. Kom ihåg målet, en tvåpolsekvivalent med en resistor och en spänningskälla:

```{code-cell} ipython
:tags: [remove-input]

with schemdraw.Drawing():
  elm.Line().left().idot(open=True).label("B",loc="right")
  elm.SourceV().up().label(r"$E$")
  elm.Resistor().right().dot(open=True).label("A",loc="right").label(r"$R_\mathrm{ekv}$")
  elm.Gap().down().label(("+", r"$U_\mathrm{ekv}$", "-"))

```

Vi letar alltså nu efter $E$ och $R_\mathrm{ekv}$.

#### Att hitta elektromotoriska kraften

I detta ekvivalenta kretsschema är ju kretsen öppen. Om kretsen inte är sluten finns det heller ingen ström. Då kommer spänningen $U_{ekv} = E$ eftersom $U_R = R I = R \cdot 0 = 0$. För att bestämma $E$ så måste vi se vad spänningen i den verkliga kretsen är när ingen ström flödar mellan A och B.

```{sidebar} Att tänka på med öppna poler
Tänk på att tvåpolsekvivalenten endast finns i teorin. Den är inte verkligheten. Bara för att strömmen _verkar_ så still från perspektivet av tvåpolen A och B så utesluter det inte strömmar inuti den verkliga kretsen som du snart får se.
```

Vi börjar med att göra den enklaste reduktionen: seriekopplade resistorer. Vi adderar alla resistorer tillsammans i serie. Då får vi:

```{code-cell} ipython
:tags: [remove-input]

with schemdraw.Drawing(unit=2) as d:
  elm.SourceV().up(2 * d.unit).label("230 V")
  R1 = elm.Resistor().right(1.5 * d.unit).label(r"320 $\Omega$").dot()
  with d.hold():
    elm.Resistor().right().label(r"512 $\Omega$")
    elm.Line().right(0.2 * d.unit).label("A",loc="right").dot(open=True)
  R2 = elm.Resistor().down(2 * d.unit).label(r"1510 $\Omega$")
  with d.hold():
    elm.Line().right(1.2 * d.unit).label("B",loc="right").dot(open=True)
  R3 = elm.Resistor().left(1.5 * d.unit).label(r"330 $\Omega$",loc="bottom")
  elm.CurrentLabelInline().at(R1).label("$I$")
  elm.CurrentLabelInline().at(R2).label("$I$")
  elm.CurrentLabelInline().at(R3).label("$I$")
```

Till en början har vi som sagt polerna A och B fria. Det betyder att ingen ström kommer flöda genom resistansen 512 $\Omega$ eftersom den inte skulle ha någonstans att ta vägen. Kretsen kring strömkällan är däremot sluten! Det flödar en ström $I$ längs pilarna i schemat. Om vi nu låter $R_1 = 320\,\Omega,R_2 = 1510\,\Omega, R_3 = 330\,\Omega$ kan vi tillämpa [Kirchhoff II](#kirchhoff-2) för att göra en potentialvandring. Lagen säger oss att

$$
U_\text{strömkälla} = U_1 + U_2 + U_3 = R_1 I + R_2 I + R_3 I = I (R_1 + R_2 + R_3).
$$

Vi vet att strömkällans spänning är $U_\text{strömkälla} = 230\,\mathrm{V}$ så vi får därmed att

$$
\frac{ U_\text{strömkälla} }{R_1 + R_2 + R_3}= \frac{230}{320 + 1510 + 330} = I \approx 0.106\,\mathrm{A}.
$$

Med hjälp av strömmen kan vi räkna ut spänningsfallet över varje resistor för att få polspänningen $U_{AB}$. Vi börjar att vandra från strömkällan, där potentialen är +230 V. Genom resistor $R_1$ flödar 0.106 A. Vi använder oss av [Ohms lag](./02-enkla_komponenter.md#resistorer) för att beräkna spänningsfallet:

$$
U_1 = R_1 I = 320 \cdot 0.106 = 33.92\,\mathrm{V}
$$

Potentialen efter resistorn är alltså 230 - 33.92 = 196.08 V. Vi vandrar vidare mot A, genom resistansen 512 $\Omega$ flödar ingen ström så spänningsfallet är 0 V. Därmed är _potentialen_ $V_A = 196.08\,\mathrm{V}$.

Om vi sedan följer ledningen nedåt kommer vi till $R_2$ där vi tillämpar Ohms lag igen:

$$
U_2 = R_2 I = 1510 \cdot 0.106 = 160.06\,\mathrm{V}
$$

och potentialen efter blir därmed 196.08 - 160.06 = 36.02 V. Vi vandrar sedan till B genom ledningen och inser att potentialen i B är $V_B = 36.02\,\mathrm{V}$. Nu har vi allt vi behöver för att beräkna spänningen mellan A och B. Spänning var ju potentialskillnad så vi får att spänningen mellan A och B är

$$
U_{AB} = V_A - V_B = 196.08 - 36.02 = 160.06\,\mathrm{V}.
$$

Titta hur detta är exakt samma sak som spänningsfallet över resistorn! Detta är för att A och B ligger på samma potentialer som resistorns plus- respektive minuspol

**Vi har alltså en slutsats:** "när ingen ström flödar mellan A och B är spänningen $U_{AB} = U_{\text{ekv}} = 160.06\,\mathrm{V}$"

Om vi påminner oss om vår tvåpolsekvivalent kom vi fram till att $E = U_\text{ekv}$ när strömmen genom A och B var 0. Alltså har vi nu

```{code-cell} ipython
:tags: [remove-input]

with schemdraw.Drawing():
  elm.Line().left().idot(open=True).label("B",loc="right")
  elm.SourceV().up().label(r"$E = 160.06\,\mathrm{V}$")
  elm.Resistor().right().dot(open=True).label("A",loc="right").label(r"$R_\mathrm{ekv}$")
  elm.Gap().down().label(("+", r"$U_\mathrm{ekv}$", "-"))
```

#### Att hitta ekvivalenta resistansen

För att nu kunna hitta $R_\text{ekv}$ mäter vi någonting som kallas _kortslutningsström_. Det är strömmen som flödar från A till B ifall vi kortsluter, förbinder med en resistansfri ledning, A och B.

Vi tar fram vår uppvikta krets igen, men kortsluter A och B:

```{code-cell} ipython
:tags: [remove-input]

with schemdraw.Drawing(unit=2) as d:
  elm.SourceV().up(2 * d.unit).label("230 V")
  R1 = elm.Resistor().right(1.5 * d.unit).label(r"320 $\Omega$").dot()
  with d.hold():
    elm.Resistor().right().label(r"512 $\Omega$")
    elm.Line().right(0.2 * d.unit).label("A",loc="right").dot(open=False)
    short = elm.Line().down(2 * d.unit)
  R2 = elm.Resistor().down(2 * d.unit).label(r"1510 $\Omega$")
  with d.hold():
    elm.Line().right(1.2 * d.unit).label("B",loc="right").dot(open=False)
  R3 = elm.Resistor().left(1.5 * d.unit).label(r"330 $\Omega$",loc="bottom")
  elm.CurrentLabelInline().at(R1).label("$I$")
  elm.CurrentLabelInline().at(R2).label(r"$0\,\mathrm{A}$")
  elm.CurrentLabelInline().at(R3).label("$I$")
  elm.CurrentLabelInline().at(short).label("$I_{AB}$")
```

Vi har nu en resistor parallelkopplad med en ledning. Resistansen i ledningen är 0 $\Omega$ och resistorns värde är ju 1510 $\Omega$. Enligt [strömförgreningslagen](#stromdelning), om vi sätter $R_1 = 1510\,\Omega, R_2 = 0\,\Omega$ får vi att

$$
I_1 = I \cdot \frac{R_2}{R_1 + R_2} = I * \cdot \frac{0}{0 + 1510} = 0\,\mathrm{A}.
$$

Vi har alltså att strömmen genom resistorn blir noll. Vi kan även härleda att

$$
I_2 = I \cdot \frac{R_1}{R_1 + R_2} = I * \cdot \frac{1510}{0 + 1510} = I.
$$

Dvs. att strömmen genom ledningen är samma ström som flödar in i parallellkopplingen. Detta ger oss att $I_{AB} = I$ enligt schemat.

Vi använder oss av att resistorerna vars ström är nollskild blivit seriekopplade, och reducerar dem till en resistor. Detta gör vi genom att addera dem.

```{code-cell} ipython
:tags: [remove-input]

with schemdraw.Drawing():
  elm.SourceV().up().label("230 V")
  line = elm.Line().right()
  elm.Resistor().down().label(r"1162 $\Omega$")
  elm.Line().left()
  elm.CurrentLabelInline().at(line).label("$I = I_{AB}$")
```

Vi kan tillämpa Ohms lag här för att få strömmen. Spänningen över resistorn måste ju enligt Kirchhoff II vara strömkällans spänning av 230 V. Vi får då

$$
U = RI_{AB} \implies \frac{230\,\mathrm{V}}{1162\,\Omega} \approx 0.198\,\mathrm{A} = I_{AB}.
$$

Denna ström kallas då kortslutningsström. Vi påminner oss en sista gång om våran tvåpolsekvivalent.

```{code-cell} ipython
:tags: [remove-input]

with schemdraw.Drawing():
  elm.Line().left(2 * d.unit).idot(open=False).label("B",loc="right")
  elm.SourceV().up().label(r"$E = 160.06\,\mathrm{V}$")
  elm.Resistor().right(2 * d.unit).dot(open=False).label("A",loc="right").label(r"$R_\mathrm{ekv}$")
  line = elm.Line().down()
  elm.CurrentLabelInline("out", start = False).at(line).label(r"$I_{AB} = 0.198\,\mathrm{A}$")
```

Nu har vi två av tre storheter kända för ekvivalenten, och Ohms lag ger oss den tredje. Vi får att

$$
E = R_\text{ekv} \cdot I_{AB} \implies R_\text{ekv} = \frac{E}{I_{AB}} = \frac{160.06\,\mathrm{V}}{0.198\,\mathrm{A}} = 808.38\,\Omega.
$$

#### Att sammanställa tvåpolsekvivalenten

Vi har nu allt vi behöver. Vår tvåpolsekvivalent blir:

```{code-cell} ipython
:tags: [remove-input]

with schemdraw.Drawing():
  elm.Line().left().idot(open=True).label("B",loc="right")
  elm.SourceV().up().label(r"160.06 V")
  elm.Resistor().right().dot(open=True).label("A",loc="right").label(r"808.38 $\Omega$")
  elm.Gap().down()
```

Denna krets är då ekvivalent, _med hänsyn till tvåpolen A-B_, med denna krets:

```{code-cell} ipython
:tags: [remove-input]

with schemdraw.Drawing(unit=2) as d:
  elm.SourceV().up(4 * d.unit).label("230 V")
  elm.Resistor().right(1.5 * d.unit).label(r"320 $\Omega$")
  elm.Line().down().dot()
  with d.hold():
    elm.Line().left(0.5* d.unit)
    elm.Resistor().down().label(r"1090 $\Omega$")
    elm.Resistor().down().label(r"420 $\Omega$")
    elm.Line().right(0.5* d.unit).dot()
  elm.Line().right(0.5* d.unit)
  elm.Resistor().down().label(r"512 $\Omega$")
  with d.hold():
    elm.Line().right(0.2 * d.unit).label("A",loc="right").idot()
  elm.Lamp2().down()
  with d.hold():
    elm.Line().right(0.2 * d.unit).label("B",loc="right").idot()
  elm.Line().left(0.5* d.unit)
  elm.Resistor().down().label(r"330 $\Omega$")
  elm.Line().left(1.5 * d.unit)
```

Detta innebär att vi hade kunnat skriva allt detta med dessa tre komponenter:

```{code-cell} ipython
:tags: [remove-input]

with schemdraw.Drawing():
  elm.Line().left().idot(open=False).label("B",loc="right")
  elm.SourceV().up().label(r"160.06 V")
  elm.Resistor().right().dot(open=False).label("A",loc="right").label(r"808.38 $\Omega$")
  elm.Lamp2().down()
```

Du ser alltså makten av en tvåpolsreduktion: denna nya ekvivalenta krets är mycket mer överskådlig, särskilt om vi vill byta ut komponenten mellan A och B.
