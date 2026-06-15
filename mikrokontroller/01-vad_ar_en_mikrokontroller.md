# Vad är en mikrokontroller

En mikrokontroller, också känt som {abbr}`MCU (Micro Controller Unit)`, är i grund och botten en liten dator. Därav "mikro-". I regel används mikrokontroller för att styra robotar, samla sensordata eller annars agera "hjärnan" för någon slags integrerad lösning som kräver beräkningsförmåga.

På RFS använder vi en [RP2040](https://en.wikipedia.org/wiki/RP2040) integrerat i en [Adafruit Feather RP2040](https://en.wikipedia.org/wiki/Raspberry_Pi#Raspberry_Pi_Pico). Notera alltså att själva mikrokontrollern är det lilla chippet i mitten. Hela kretskortet är alltså en Feather. Dock används ordet mikrokontroller även för hela kretskortet, om något felaktigt.

```{figure} https://cdn-shop.adafruit.com/970x728/4884-04.jpg

En Adafruit Feather RP2040.
```

````{sidebar} Mikrokontrollerchippet
```{figure} https://upload.wikimedia.org/wikipedia/commons/thumb/1/16/RP2040.jpg/1280px-RP2040.jpg

En RP2040 MCU.
```
````

## Angående elektronik

Som ni säkert vet krävs det en del elektronik för att få ett mikrokontrollerprojekt att gå runt. Kursen i Rymdteknik på RFS, som den ser ut idag, är inte tänkt att vara en kurs i elektroteknik. Kursen fokuserar i stället på programmeringen och genomförandet. Däremot är elektrotekniken en minst lika viktig del av det hela. Därför kommer vi att gå igenom grundläggande koncept inom elläran, men inte gå för djupt.

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
