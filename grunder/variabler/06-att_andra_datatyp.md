---
kernelspec:
    name: python3
    display_name: Python 3
---


# Att ändra datatyp
(convert-data)=
Vissa saker går bara att göra med värden av samma typ. Till exempel jämförelser eller aritmetik. Det hade väl varit konstigt att fråga om `"a" > 3`, eller hur? Ibland dyker det dock upp likartade värden som borde gå att jämföra, som `"5" > 3`. Detta verkar som att det borde vara `True`, men egentligen så kommer ni att få ett fel om ni testar.

```{code} ipython
print("5" > 3)
```
Koden ovan, om ni kör den, ger ett fel likt denna:
```
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
Cell In[1], line 1
----> 1 print("5" > 3)

TypeError: '>' not supported between instances of 'str' and 'int'
```

Det beror på att det inte finns en definierad procedur för hur `>` skall bedömas för en sträng och ett heltal. Och du förstår säker att det är omöjligt att skriva en sådan[^str].

[^str]: Om man nu inte tänker på bokstäver som UTF-8 kodpunkter, vilka är heltal... Men det skulle inte en vanlig användare göra, och strängar kan vara mer än en bokstav varefter denna likhet slutar.

I python kan vi använda våra inbyggda datatyper som funktioner för att konvertera från en datatyp till en annan. Vi kan till exempel göra om vår text-5:a till en `int`.
```{code-cell} ipython
:tags: []

print(int("5") > 3)
```

Vi kan såklart också göra om vår `int`-3:a till en `str`, men jämförelsen mellan två `str`-värden är heller inte definierad.

De andra datatyperna vi diskuterar i föregående kapitel fungerar på samma sätt: `typ(värde att konvertera)`. Se till att dina värden är av rätt typ när du använder dem, så att du inte får situationer som dessa:

```{code-cell} ipython
:tags: []

print("Två strängar:")
print("5" + "3")

print("") # tom rad

print("Två ints:")
print(5 + 3)

print("")

print("En av varje:")
print("5" + 3)
```
