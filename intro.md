---
kernelspec:
  name: python3
  display_name: Python 3
---

# Introduktion

Välkommen till introkursen i [Python](https://www.python.org)! Här kommer du att få lära dig grunderna i språket, och mer specifikt hur det kan tillämpas under Rymdforskarskolan för att programmera en [RP2040 mikrokontroller](https://en.wikipedia.org/wiki/RP2040) via [CircuitPython](https://www.circuitpython.org) och för att göra astrofysiska beräkningar med [Astropy](https://www.astropy.org).

Detta material är nytt för i år och framtaget av er handledare Marcell Ziegler. Boken är också fortfarande under uppbygnad och kommer att vara det ända fram till RFS Uppsala sätter igång. Det kommer alltså tillkomma kapitel löpande, så om du är nyfiken kolla tillbaka hit då och då. Vi vill alltid utveckla kvaliteten på vårt undervisningsmaterial, så om du har tankar om hur materialet kan förbättras: hör av dig till Marcell på <marcell.ziegler@astronomiskungdom.se> eller på Discord!

Kursen är uppdelad i tre delar:

1. [Programmeringens grunder](./grunder/01-vad_ar_programmering.md):
   Där ni kommer att få lära er det mest grundläggande inom programmering och språket Python.
2. [Mikrokontrollerprogrammering (under uppbyggnad)](./mikrokontroller/01-vad_ar_en_mikrokontroller.md):
   Där jag kommer gå igenom hur ni tillämpar era grundkunskaper för att koda våra mikrokontrollers.
3. [Astrofysik med Python (under uppbygnad)](#):
   Där vi går igenom hur ni använder er av bland annat Astropy för att göra astrofysiska beräkningar.
4. [Avancerade koncept (under uppbyggnad)](./avancerat/01-avancerade_koncept.md):
   Där jag går igenom mer avancerade koncept, datastrukturer och metoder för programmering. **OBS!** Detta kapitel är frivillig extraläsning.

```{note} Att göra inför sommaren
Under RFS kommer du att ha väldigt mycket att lära er på väldigt kort tid. Det betyder att det är **obligatoriskt att läsa Kapitel 1. fram till och med rubriken [Kollektioner](./grunder/variabler/08-kollektioner.md#collections)**. Till detta kapitel, och resten av Kapitel 1. finns det frivilliga [övningsquiz på elevportalen](https://www.astronomicentrum.se/quiz) där du kan testa dina kunskaper.

**Notera:** Denna "hemläxa" är för din skull, så att du får en smidig upplevelse med att komma igång med programmeringen. Jag kommer inte att testa er på om ni har läst, och föreläsningarna kommer att innehålla allt som ni läser som läxa. Däremot kommer **föreläsningarna som behandlar materialet i Kapitel 1. fram till Kollektioner ha ett extra högt tempo** eftersom du antas ha en hum för det vi snackar om via boken.
```

## Hur du använder den här boken

Detta är en interaktiv lärobok. Det betyder att vi exempelvis kan ha länkar till [gulliga katter](https://en.wikipedia.org/wiki/Cat), eller beskriva förkortningar som {abbr}`AU (Astronomisk Ungdom)`, så att ni kan musa över dem och se vad länkarna och beskrivningarna innehåller. Allting med en streckad underkant går att musa över, allt med solid underkant är ändå en länk men måste följas för att läsas. Jag kommer även ibland att visa kod för er. Ibland kommer den koden vara menad att köras. Det ser ut såhär:

```{code-cell} ipython
print("Hello, World!")
```

Dessa kommer alltid att vara "för-körda" för er, och resultatet visas i den ljusblåa rutan under. Resultatet i denna kontext är det som ev. skrivs ut till terminalen av programmet. Om ni vill experimentera med koden själv[^run-in-page], kopiera in koden i en fil på er dator och kör den med ert lokala Python. Ibland kommer jag till och med uppmana er att göra detta. Hur ni gör det beskrivs i [Kapitel 1](./grunder/01-vad_ar_programmering.md). Om koden inte var tänkt att köras, kommer inget resultat att visas.

Ibland kommer det också finnas lite mer info om ett visst ämne, som inte är strikt nödvändigt för att förstå allt, men som kan vara kul att vet ändå. Då kommer det finnas en dropdown som nedan, som ni kan klicka på och läsa:

```{hint} Bonus
:class: dropdown
Programmering är riktigt kul :)
```

[^run-in-page]: Det system som denna bok är baserad på stödjer inte att exekvera kod i webbläsaren på ett bra sätt just nu, men om det ändras så kommer ni till och med slippa köra koden på er egna dator!

Lycka till med läsningen, jag ser fram emot att träffa dig i sommar!
