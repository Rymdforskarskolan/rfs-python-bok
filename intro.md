---
kernelspec:
    name: python3
    display_name: Python 3
---
# Introduktion

Välkommen till introkursen i [Python](https://www.python.org)! Här kommer du att få lära dig grunderna i språket, och mer specifikt hur det kan tillämpas under Rymdforskarskolan för att programmera en [RP2040 mikrokontroller](https://en.wikipedia.org/wiki/RP2040) via [CircuitPython](https://www.circuitpython.org).

Detta material är nytt för i år, och framtaget av er handledare Marcell Ziegler. Vi vill alltid utveckla kvaliteten på vårt undervisningsmaterial, så om du har tankar om hur materialet kan förbättras: hör av er till Marcell på <marcell.ziegler@astronomiskungdom.se> eller på Discord!

Kursen är uppdelad i tre delar:

1. [Programmeringens grunder](./grunder/01-vad_ar_programmering.md):
    Där ni kommer att få lära er det mest grundläggande inom programmering och språket Python.
2. [Mikrokontrollerprogrammering](./mikrokontroller/01-vad_ar_en_mikrokontroller.md):
    Där jag kommer gå igenom hur ni tillämpar era grundkunskaper för att koda våra mikrokontrollers.
3. [Avancerade koncept](./avancerat/01-avancerade_koncept.md):
    Där jag går igenom mer avancerade koncept, datastrukturer och metoder för programmering. **OBS!** Detta kapitel är frivillig extraläsning.

```{note} Att göra inför sommaren
Notera att **Kapitel 1** är obligatorisk läsning inför RFS!
```

## Hur du använder den här boken

Detta är en interaktiv lärobok. Det betyder att jag ibland kommer att körbara bitar kod som detta:

```{code-cell} ipython
print("Hello, World!")
```

Dessa kommer alltid att vara "för-körda" för er, och resultatet visas i grått under. Om ni vill experimentera med koden själv[^run-in-page], kopiera in koden i en fil på er dator och kör den med ert lokala Python. Hur ni gör det beskrivs i Kapitel 1.

Ibland kommer det också finnas lite mer info om ett visst ämne, som inte är strikt nödvändigt för att förstå allt, men som kan vara kul att vet ändå. Då kommer det finnas en dropdown som nedan, som ni kan klicka på och läsa:

```{hint} Bonus
:class: dropdown
Programmering är riktigt kul :)
```

[^run-in-page]: Det system som denna bok är baserad på stödjer inte att exekvera kod i webbläsaren på ett bra sätt just nu, men om det ändras så kommer ni till och med slippa köra koden på er egna dator!
