# Hur datorer hanterar data

Uttrycket "datorer snackar i 1:or och 0:or" har ni säkert hört innan. Det syftar till att alla information på datorer, från bilder till videor till text, lagras som binära tal. Det som skiljer olika typer av data åt är hur man tolkar talen och vilken ordning de sitter i.

```{hint} Crash-course i binära tal för den som inte hört det innan
:class: dropdown
Vi använder det så kallade decimala talsystemet. "deci" står för 10. Det kallas med andra ord bas 10. Detta innebär att varje siffra i ett tal kan vara mellan 0 och 9, dvs. 10 olika möjligheter och vart 10:e värde måste vi lägga till en extra siffra. En siffra kan visa 10 olika möjligheter: 0-9. Två siffror kan visa 10 * 10 = 10{sup}`2` = 100 möjligheter: 0-99. Detta kan ni då logiskt fortsätta till oändligt antal siffror.

Binära tal använder bas 2. "Bi" betyder två. Här kan varje siffra vara 1 eller 0, två möjligheter. Så du behöver många fler siffror för att visa samma mängd möjligheter som med bas 10. Decimala systemet har ju ental, tiotal, hundratal etc. Här har vi potenser av två i stället: ental, tvåtal, fyratal, åttatal, sextontal etc. Alltså 2{sup}`0` = 1, 2{sup}`1` = 2, 2{sup}`2` = 4 osv. För att skilja på ett tal skriver i olika baser, skriver vi talbasen nedsänkt efter talet. Och då får vi exempelvis 13{sub}`10` = 1101{sub}`2`. Matten här är alltså $$ 1 \cdot 10^1 + 3 \cdot 10^0 = 1 \cdot 2^3 + 1 \cdot 2^2 + 0 \cdot 2^1 + 1 \cdot 2^0. $$ Det funkar alltså likadant som vanliga tal, men varje platsvärde är två gånger större, inte 10 gånger, än föregående plats.

Man kan använda vilken talbas man vill. Ibland använder man sig av hexadecimala tal alltså bas 16. Detta är för att det är mer 4 gånger mer kompakt sätt att skriva binära tal. Då har vi siffrorna 0-f, dvs. 0123456789abcdef. I Exemplet ovan har vi då att 1101{sub}`2` = d{sub}`16`, kompakt va? 4 binära siffror kan visas med en hexadecimal siffra. Det går inte med bas 10 eftersom $\sqrt{10}$ inte är jämnt, medan $\sqrt{16} =4$.
```

## Text och annan typografi

Ta text som ett exempel. Allra vanligast idag är att vi lagrar text med en {abbr}`kodning (Strukturen som data lagras med)` som heter [UTF-8](https://en.wikipedia.org/wiki/UTF-8). Tänkt på det som ett riktigt avancerat chiffer. Du kan chiffrera texten till till grupper av 8 st 1:or och 0:or. Det blir alltså ett binärt tal mellan 0 och 255{sub}`10`. Varje grupp, varje *byte*, representerar en karaktär[^utf-8]. Denna standard följde efter något som hette ASCII: American Standard Code for Information Interchange. All giltig ASCII är giltig UTF-8, men inte vice versa.

Ordet "Hej" skulle då kodas, chiffreras, som `01001000 01100101 01101010` eller 72{sub}`10` 101{sub}`10` 106{sub}`10`. Ibland väljer man att skriva talen som *hexadecimala*, dvs. bas 16 i stället för bas 2 eller 10. Då får vi 48{sub}`16` 65{sub}`16` 6a{sub}`16`. När vi pratar datorer brukar vi skriva hexadecimala tal som `0xNNN...` där `0x` visar att följande tal är hexadicmalt. Alltså blir vårt kodade resultat `0x48 0x65 0x6a`.

## Heltal

Ett binärt tal är redan ett heltal, bara i en annan talbas. Så vi lagrar heltal som helt vanliga tal, bara binärt. Ett heltal på datorn kallas i regel en {abbr}`integer (engelska för heltal)` och har ofta en förutbestämd storlek. Oftast 32 bits. En *bit* är en binär siffra. Ordet bit kommer ifrån att det är den minsta möjliga informationsmängden som betyder något; sant eller falskt, 1 eller 0. Bits organiseras i grupper om 8, en *byte*. Ett 32 bit heltal är alltså 4 byte. Det finns också 8, 16 och 64 bit heltal. Det finns heller ingen teknisk begränsning på hur stort talen kan vara. Däremot får du plats med
4294967295{sub}`10` i 32 bit och 18446744073709551615{sub}`10` i 64 bit så du behöver inte mycket mer.

### Negativa tal

Ett minustecken är ju inte ett tal, hur lagrar vi det? Vi har kommit överens om att ifall tecknet på talet spelar roll, använder vi en bit för att visa om den är negativ eller inte. 1 för negativ, 0 för positiv. Detta minskar det största värde vi kan lägre, men gör det möjligt att lagra negativa värden.

När ett heltal bara kan vara positivt är det en *unsigned integer*, heltal utan tecken, och när den kan vara negativ är det en *signed integer*, heltal med tecken. I python är alla heltal signed, om inte du specifikt frågar efter ett unsigned. Våra signed integers kan lagra upp/ned till ±2147483647{sub}`10` i 32 bit och ±9223372036854775807{sub}`10` i 64 bit. Fortfarande definitivt tillräckligt.

## Decimaltal

Med decimaltal menas tal som inte är heltal, utan har en decimalkomponent. Dessa kan ju per definition inte lagras i ett vanligt heltal. Därför har man valt att representera dem i grundpotensform. Alltså $a \cdot 10^b$ där $0<a<10$. Här heter $a$ *mantissa* och $b$ för exponent. Såklart är allt binärt även här så $0<a<1_2$ egentligen[^floats].

Ett decimaltal på datorspråk heter ett *flyttal* eller ett *floating-point number*. Dessa kommer också i flera varianter, men de vanligaste är 32-bit, som kallas enkel precision, och 64-bit, som är dubbel precision. I enkel precision har du ett tecken som är 1 bit, exponent på 8 bits och en mantissa på 23 bits. Dubbel precision ger en exponent på 11 bit och en mantissa på 52 bits.

Ett flyttal har 3 specialvärden, `+inf` och `-inf` som är tal större/mindre än det är möjligt att representera, dvs. nästan oändligheten. Du har också `NaN` som står för "Not a Number". Detta representerar ett felaktigt värde. Om du vill veta mer om hur flyttal funkar kan du läsa om standarden [](https://en.wikipedia.org/wiki/IEEE_754) som definierar dem.

[^utf-8]: Det är lite mer komplicerat än så. Vissa UTF-8 karaktärer kan ta mer än en byte. I dessa fall så dela karaktären upp i delar, som att `ä` chiffreras som `¨` och `a`. Dock är de flesta symboler man använder till vardags en byte stora.
[^floats]: Det är lite mer invecklat i exakt hur talet lagras, men detta ger en bra nog bild för kursens ändamål.
