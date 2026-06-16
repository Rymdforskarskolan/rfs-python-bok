---
kernelspec:
  name: python3
  display_name: Python 3
---

# Filhantering

Filer har mer nytta än att bara lagra kod. Vi kan både läsa och skriva till dem för att läsa in eller spara stora mängder data. Detta är mest användbart för sådant som inte får plats i en terminal

Den inbyggda funktionen `open()` låter dig öppna filer. `open(path, mode)` tar två[^open-args] argument: en filsökväg (filepath) som en `str` och ett läge också som `str`. De vanligaste lägena är:

- `"w"`: Skriv (write) till filen.
  - Raderar allt innehåll i filen som öppnas.
  - Skapar filen om den inte existerar (kräver att alla mappar i sökvägen existerar)
  - Tillåter dig att skriva text (`str`) till filen
  - Antar att texten är UTF-8/ASCII kodat. (Det brukar den vara.)
- `"r"`: Läs (read) från filen.
  - Kräver att filen existerar.
  - Läser in innehåll som om det var text (`str`).
  - Antar att texten är UTF-8/ASCII kodat. (Det brukar den vara.)
- `"a"`: Lägg till innhåll (append) till filen.
  - Skapar filen om den inte finns.
  - Skriver ny data vid slutet av filen.
  - Kräver att alla mappar i sökvägen existerar.
- `"wb"`, `"rb"`, `"ab"`: Skriv, läs, respektive skjut till innehåll i binärt format.
  - Samma som dess icke binära ekvivalent, men innehåll behandlas in som bytes (8-bit heltal).

[^open-args]: Det finns ett antal fler argument som man inte nödvändigtvis behöver kunna. Slå upp detta i Pythondokumentationen ifall detta intresserar dig.

## Läsa filer

För att läsa en fil så måste vi skapa ett filobjekt i en `with`-sats. `with`-satsen är en s.k. _context manager_. Det den gör är att se till att filen _alltid_ stängs när du är klar med den. Om du inte använde `with`-satsen skulle du behöva komma ihåg att stänga filen manuellt. Gör du inte det riskerar du permanent dataförlust. För att öppna en fil för läsning skriver du såhär:

```{code} python
:linenos:
with open("/path/to/file", "r") as f:
    ...
```

Vi har alltså nyckelordet `with`, följt av ett anrop till funktionen `open()` med sökvägen till din fil samt det läge du vill öppna den i, `"r"` för "read" i vårt fall. Efter anropet kommer `as f`. Nyckelordet `as` säger "spara resultatet av föregående uttryck som en variabel med namn som kommer efter". Den funkar bara i `import`- och `with`-satser. Vi sparar alltså resultatet, ett filobjekt, av `open()` i variabeln `f`. Namnet `f` kan vara precis vad du vill, men det är sedvanligt att den heter `f` eller `file` för filer.

I blocket som tillhör `with`-satsen kan du göra de operationer du vill på filen sedan när du lämnar blocket stängs filen automatiskt. `with`-satsen är ett block, men _inte_ ett scope! Du kan alltså skapa variabler i satsen som lever kvar efter. Den enda variabeln som försvinner är `f`.

### Operationer på filer i läsläge

Ett filobjekt i läsläge har två användbara metoder: `f.read()` och `f.readlines()`. `f.read()` ger dig hela innehållet av filen som en stor `str`. Om du vill behandla filen rad för rad så kan du använda `f.readlines()` som ger dig en `list` av alla rader i filen. Detta är ju ekvivalent med `f.read().split("\n")`.

### Exempel på filinläsning

Ibland behöver man läsa in data som är för stort för att kunna matas in manuellt i terminalen. Då är det mycket fiffigt med att kunna läsa det från en textfil. Ett vanligt format på textfiler är CSV: Comma Separated Values. Formatet är som det låter, en massa värden separerade med komma (eller ibland annat skiljetecken). En CSV är en tabell med en rad för varje rad i textfilen och en kolumn för varje kommatecken.

En sådan fil kan exempelvis se ut såhär:

```{code} csv
Namn,Poäng,Betyg
Marcell Ziegler,20.0,A
Agnes Jonsson,17.5,B
Jonathan Bengtsson,10.0,E
Samuel Westerling,0.0,F
Emilia Bredmark,20.0,A
```

Notera de viktiga aspekterna:

- Kolumner finns separerade med kommatecken.
- Varje rad har lika många kolumner.
- Det finns inga mellanslag mellan kolumnerna.
- Tal använder punkt för decimaler.

Detta är inte ett särskilt snyggt format, men det är extremt lätt att läsa för en dator. Säg att vi vill skapa en `dict` med namn som nyckel och varje värde är en `tuple` i ordningen (Poäng, Betyg). Då skulle vi skriva såhär:

```{code-cell} ipython
:tags: []

scores = {}

# Detta är ett exempel på sökväg
# Den betyder scores.csv som ligger i din CWD.
with open("./scores.csv", "r") as f:
    lines = f.readlines()

    # Vi slice:ar bort första raden som har rubrikerna
    for line in lines[1:]:
        # Vi strippar bort eventuella radbrytningar på slutet
        # sedan splittar vid kommatecken
        columns = line.strip().split(",")

        # Vi lägger sedan till ett nyckel-värde-par i dicten
        # med columns[0] (namnet) som nyckel och en tuple med resterande värden
        # Kom ihåg att filen läses som str, så siffran måste konverteras!
        scores.update({
            columns[0]: (float(columns[1]), columns[2])
        })

print(scores)

```

## Skriva filer

Precis som vi läsning använder vi en `with`-sats och endast väljer ett annat läge. Tänk på att `"w"` kommer helt skriva över den fil du anger. `"a"` kommer inte skriva över utan i stället lägga till text. Välj noga vad du önskar. Tänk även på att filen inte längre måste existera, men mappen du vill lägga filen i måste existera innan du försöker skapa den.

En typisk använding för `"a"`-läget är att föra en sensorlogg med tidsstämplar. Du vill ju inte radera tidigare data vid varje ny mätning, så du skjuter bara till det.

### Operationer på filer i skrivläge

Vid skrivning har du metoderna `f.write()` för att skriva en `str` till filen och `f.writelines()` som tar en lista med `str`-värden och skriver skriver alla till filen efter varandra. Du måste dock fortfarande ange radbrytningar `"\n"` själv!

### Exempel på filinläsning

Vi tar föregående exempel, men i stället för att gå från CSV till `dict` går vi till en CSV från en `dict`.

```{code-cell} ipython
:tags: []

scores = {
    "Marcell Ziegler": (20.0, "A"),
    'Agnes Jonsson': (17.5, 'B'),
    'Jonathan Bengtsson': (10.0, 'E'),
    'Samuel Westerling': (0.0, 'F'),
    'Emilia Bredmark': (20.0, 'A')
}

with open("./scores_out.csv", "w") as f:
    # Vi skriver först rubrikraden
    f.write("Namn,Poäng,Betyg\n")

    for name, score_and_grade in scores.items():
        # Vi måste göra en sträng av vår siffra här
        columns = [name, str(score_and_grade[0]), score_and_grade[1]]

        # Kom ihåg hur vi kunde använda str.join()
        # för att sammafoga element i en kollektion
        # Vi måste även manuellt lägga till radbrytning!
        f.write(",".join(columns)+ "\n")
```

Innehållet i den resulterande `scores_out.csv` blir då

```{code} csv
:linenos:
Namn,Poäng,Betyg
Marcell Ziegler,20.0,A
Agnes Jonsson,17.5,B
Jonathan Bengtsson,10.0,E
Samuel Westerling,0.0,F
Emilia Bredmark,20.0,A
```

Att kunna skriva till filer är väldigt användbart för att kunna spara stora mängder data, såsom sensorvärden.
