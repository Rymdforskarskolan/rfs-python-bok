# Att be användaren om info
Ibland när man skriver kod behöver man be användaren om någon information under programmets gång. Då använder vi oss av funktionen `input()`. Den tar ett argument, som är frågan och ger till baka en `str` (oavsett om vad användaren skriver) när användaren har matat in något i terminalen där frågan dyker upp, och sedan tryckt på enter.

Detta är fiffigt om man vill fråga efter indata till en matematisk funktion vid varje körning, i stället för att behöva ändra i koden hela tiden till exempel. För att demonstrera, skriver vi en kort hälsningskod.

```python
name = input("Vad heter du? ")

print(f"Hej {name}!")
```

Testa kopiera denna kod, och kör den själv för att se vad resultatet blir. När du får frågan om vad du heter, skriv ditt namn i terminalen sedan tryck på enter. Notera att jag lämnat ett extra mellanslag efter frågetecknet. Det har jag gjort för att inmatningen börjar direkt efter frågan. Det ser lite snyggare ut om det är utrymme mellan frågan och inmatningen. Glöm heller inte `f`-et innan strängen för att kunna substituera in namnet!

## Inmatning av annat än strängar
Ibland vill du inte ha en `str`, utan kanske en `int` eller `float`. Då kan vi använda oss av våra kunskaper från förra kapitlet och konvertera den `str` som vi får från `input()` till den önskade typen. Ta som exempel en kod som tar in två decimaltal, adderar dem och skriver ut resultatet.

```python
num1 = float(input("Ange tal 1: "))
num2 = float(input("Ange tal 2: "))
print(f"Summa: {num1 + num2}")
```

Testa kör detta också! Vad händer om du gör om din input till `int` i stället? Vad händer om du anger bokstäver? Det finns ett antal gränsfall som måste hanteras här, och då behöver vi fler verktyg. Det kommer i kapitlet om [`while`-slingan](../06-slingor.md#while-slingan).