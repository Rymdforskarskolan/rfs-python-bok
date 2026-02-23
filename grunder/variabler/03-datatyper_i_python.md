# Datatyper i Python

Python är ett språk med s.k. *dynamiska typer*. Det betyder att en variabels typ är inte spikad när den skapas, utan den kan ändras över tid. Däremot så har vid varje givet ögonblick varje variabel en typ. Det kan vara ett heltal, ett flyttal eller något helt annat. Python listar själv ut vad för typ en variabel ska ha, så det behöver du oftast inte skriva ned själv.

## Heltal

Ett heltalt i Python kallas en `int` som står för integer. Den kan ha godtycklig storlek och antalet bits anpassas dynamiskt till det du sätter in.

## Flyttal (decimaltal)

Tal med decimaler lagras i typen `float`. Det är ett 64-bit IEE-754 flyttal som vi diskuterade några kapitel sedan. Du kan lagra decimaltal med ca. 16 decimalers precision i det.

Du kan specificera ett flyttal som ett vanligt decimaltal med decimalpunkt alltså `1.35` till exempel. Du kan också skriva de i grundpotensform som en miniräknare hade gjort. Några exempel: `100e2` är ekvivalent med $100 \cdot 10^2$, `1.52e-3` är ekvivalent med $1.52\cdot 10^{-3}$.

## Sant-falsk värden

Ett värde som kan vara sant eller falsk kallas ett *boolskt* värde eller en *boolean*. Den lagras i typen `bool`. Python använder nyckelorden `True` och `False` (notera stor bokstav i början) för att representera dessa värden. I bakgrunden är de bara en 1:a och en 0:a i minnet. Det däremot är *inte* ekvivalent att skriva 1 / 0 i stället för `True` / `False`!

## Text och typografi

En bit text lagras i en *sträng* eller *string*. Datatypen heter `str`. Texten lagras i UTF-8 (Unicode) vilket innebär att alla symboler, emoji och bokstäver är okej att lagra där. En sträng är egentligen en lista med karaktärer, där varje karaktär är en bokstav, symbol etc.
