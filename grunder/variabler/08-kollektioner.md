---
kernelspec:
  name: python3
  display_name: Python 3
---

# Kollektioner

(collections)=
En kollektion är en datatyp som innehåller mer än ett värde. De kollektioner som finns inbyggda i Python är `list`, `tuple`, `set` och `dict`. De alla är i grunden sätt att samla relaterad data, men de uppnår det på lite olika sätt.

## `list` — En ordnad lista med föränderlig längd

I en `list`, en lista, kan du lagra ett godt. antal element av varierande typ och du kan ändra längen av en lista i efterhand.

Du kan skapa en tom lista:

```python
lista = []
```

```{note} **OBS!**
Namnen `list`, `tuple`, `set` och `dict` är reserverade i python, och du kan alltså inte ha variabler med de namnen utan att paja saker!
```

Man kan också skapa listor med element från början.

```python
lista = [1, 5.32, 7, "hej!"]
```

Typen av elementen behöver inte vara samma, och du kan definiera så många eller så få element som du vill. Du kan också lägga till element i efterhand med metoden `list.append()`.

```{code-cell} ipython
:tags: []

values = [1,2,3]

print(f"values är nu: {values}")

values.append(7)

print(f"efter tillägget är values: {values}")
```

På liknande vis kan du ta bort och plocka ut element med `list.pop()`.

```{code-cell} ipython
:tags: []

values = [1,2,3]

print(f"values är nu: {values}")

removed_value = values.pop()

print(f"efter pop:en är values: {values}")
print(f"det som togs ut: {removed_value}")
```

För att kolla på ett specifikt värde kan vi _indexera_ i listan med `lista[index]`. Listindex i Python börjar på 0. Så första elementet är 0, andra är 1 osv. Du kan indexera baklänges med negativa index. Plats -1 är sista, -2 är näst sista osv.

```{code-cell} ipython
:tags: []

values = [1,2,3]

print(f"Elementet på index 1 i values är: {values[1]}")

```

Om du vill ändra elementet på en given plats i listan kan du använda tillsättningsoperatorn tillsammans med indexering.

```{code-cell} ipython
:tags: []

values = [1,2,3]

# Här byter vi ut värdet på index 1
values[1] = 5

print(f"Elementet på index 1 i values är: {values[1]}")

```

## `tuple` — En ordnad, oföränderlig lista

En tuple funkar precis som en `list`, fast att den bara kan tillsättas en gång. När din `tuple` är tillsatt kan du inte längre byta ut dess element element, men elementen i sig får vara av föränderlig typ. Du gör en ny tuple såhär:

```python
my_tuple = (1,2,3)
```

Du använder alltså vanliga parenteser `()`. I övrigt gäller samma som listor, men `tuple.append()` och `tuple.pop()` existerar ju inte för en `tuple` är oföränderlig. Du kommer däremot åt elementen som vanligt med index: `min_tuple[i]`

## `set` — En oordnad mängd med unika värden

Denna datatyp kan langra flera värden, garanterar att inga dubletter finns med och bryr sig inte om ordningen i mängden. Du skapar en mängd med klamrar `{<värden>}`.

```{sidebar} Den tomma mängden
En tom `set` kand inte skapa med klamrar. Uttrycket "`{}`" utvärderas till en tom `dict`. Du kan i stället använda funktioner `set()`, utan argument, för att göra en ny tom `set`.
```

```python
my_set = {"apple", "banana", "orange"}
```

Värdena kan vara vad som helst, och behöver inte vara av samma typ. När du gör en ny set verifieras det automatiskt att inga dubletter uppstår.

```{code-cell} ipython
:tags: []

my_set = {"apple", "apple", "banana", "orange", "banana"}
my_number_set = {5, 3, 2, 1, 5, 6, 7, 8}

print(my_set)
print(my_number_set)
```

Du lägger till element med `set.add()`, och tar bort dem med `set.remove()`. Du kan plocka ut ett element med `set.pop()`, som med en lista, men eftersom mängden är oordnad kommer ett slumpmässigt element att plockas ut. Det går även att genomföra vissa grundläggande mängdoperationer

| Operation     | Notation            | Beskrivning                                                                                                                                       |
| ------------- | ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| Inklusion     | `x in s`            | `True` om `x` är i mängden `s`. Ekv. med $x \in s$                                                                                                |
| Exklusion     | `x not in s`        | `True` om `x` inte är i mängden `s`. Ekv. med $x \not\in s$.                                                                                      |
| Delmängd      | `s <= other`        | `True` om `s` är en delmängd av `other`. Dvs. att alla element i `s` finns också i `other`. Ekv. med $s \subseteq \text{other}$.                  |
| Äkta delmängd | `s < other`         | `True` om `s` är en äkta delmängd av `other`. Dvs. att alla element i `s` finns också i `other`, men `s != o`. Ekv. med $s \subset \text{other}$. |
| Union         | `s \| other \| ...` | Utvärderas till unionen, sammaslagningen, av alla element i alla mängder i uttrycket. Ekv. med $s \cup \text{other} \cup \dots$.                  |
| Snitt         | `s & other & ...`   | Utvärderas till snittet av alla mängder, dvs. de element som finns i alla mängder. Ekv. med $s \cap \text{other} \cap \dots$.                     |
| Differens     | `s - other - ...`   | Utvärderas till elementen i `s` som inte finns med i alla andra mängder. Ekv. med $s \backslash (\text{other} \cup \dots)$.                       |

Du kan också göra mängder av en `list` eller `tuple`. Detta är användbart för att ta bort dubletter.

```{code-cell} ipython
:tags: []

my_list = [1,3,4,2,6,7,6,6,6]
my_set = set(my_list)
print(my_set)
```

Notera hur det bara finns en 6:a. Slutligen är även en `str` en kollektion på ett sätt. Det är ju en lista av karaktärer, så du kan göra det till en mängd av karaktärer.

```{code-cell} ipython
:tags: []

my_str = "The quick brown fox jumped over the lazy dog"
my_set = set(my_str)
print(my_set)
```

Titta hur den resulterande mängden innehåller exakt ett av varje förekommande karaktär i strängen. T.o.m. mellanslaget och skillnaden mellan `"T"` och `"t"` bevaras.

## `dict` — En nyckel-värde kollektion

Pythons `dict` står för "dictionary". Motsvarande datatyp i andra språk heter ofta `HashMap`. En `dict` är en kollektion som parar ihop en _nyckel_ med ett _värde_. Det finns alltid exakt ett värde per nyckel och nycklar är unika i en given `dict`.

Fördelen med att använda en `dict` och inte en `list` är att i en `dict` så kan du komma åt datan med nycklar, i stället för numeriska index. De funkar precis som namnet låter: en ordbok. Varje ord är unikt och har en definition, eller ett värdet i detta fall. Säg exempelvis att du vill spara personnummer kopplat till personens namn. Du definierar då även `dict`:en i klamrar `{}`.

```python
personnummer = {"Bertil": "20050415-4638", "Jonas": "19720530-1298"}
```

Notera att jag har numret som text eftersom bindestrecket ju inte är ett tal och det hade python tolkat som talet `personnummer - sista-4` eller ex. `20050415-4638 -> 20045777`. Även fall som `050722-xxxx` hade tappat sin inledande 0:a om de tolkades som heltal och inte text.

Alltså skriver du en `dict` inom klamrar (`{}`) och varje nyckel-värdespar som `nyckel: värde`. Varje par är separerat av komma (`,`). Nyckel och värdet kan vara vad som helst, det måste inte ens vara strängar. Det är dock vanligast att använda en sträng som nyckel sedan godt. typ som värde, men andra varianter förekommer också.

För att komma åt dina värden sedan använder vi indexeringsnotation, men lägger nyckeln som index.

```{code-cell} ipython
:tags: []

personnummer = {"Bertil": "20050415-4638", "Jonas": "19720530-1298"}

print(personnummer["Bertil"])
```

Om du vill lägga till ett värde i en `dict` efter du har skapat den använder du `dict.update()` och matar en `dict` som har alla värden du vill lägga till. Denna `dict` kommer att läggas till i din ursprungliga och alla nycklar som är dubletter skrivs över.

```{code-cell} python

personnummer = {"Bertil": "20050415-4638", "Jonas": "19720530-1298"}

personnummer.update({"Alrik": "20031203-4687"})

print(personnummer)
```

För att ta bort element använder vi nyckelordet `del`, för _delete_, som så:

```{code-cell} python

personnummer = {"Bertil": "20050415-4638", "Jonas": "19720530-1298"}

personnummer.update({"Alrik": "20031203-4687"})

del personnummer["Bertil"]

print(personnummer)
```

### Att komma åt bara värden och nycklar separat och tillsammans

Ibland är det nödvändigt att kunna komma åt värden och nycklar var för sig, eller komma åt de alla i par. I detta syften finns tre hjälpmetoder:

- `dict.values()` ger dig alla värden i din `dict`.
- `dict.keys()` ger dig alla nycklar i din `dict`.
- `dict.items()` ger dig alla nyckel-värde par som tuples `(nyckel, värde)`.

## `str` som kollektion

Som jag snuddade på i rubriken om mängder är `str` egentligen bara en lista med karaktärer. En karaktär i detta sammanhang är en symbol som går att skriva till skärmen. Detta innebär att även mellanslag `" "` och radbrytningskaraktären `"\n"` är karaktärer.

Du kan indexera en sträng precis som en lista. Exempelvis får du `"hej"[1] -> "e"`. Detta är ju ytterst användbart ifall du vill kolla värdet av en viss bokstav eller position i din sträng.

## `in`-operatorn

Python har en mycket kraftfull operator som heter `in`, och dess invers heter `not in`. Denna operator kollar ifall elementet till vänster finns med i kollektionen till höger. Förs listor, tuples och mängder är detta självförklarligt. För en `dict` kollar `in` om värdet till höger existerar bland nycklarna och för en sträng kollas ifall strängen till vänster uppkommer någonstans i högerledet. Här följer ett antal exempel.

```python
my_list = [5, 6, 2, 15.3]

5 in my_list      # True
17 in my_list     # False
17 not in my_list # True

# Tuples har likadan funktion som list

my_set = {"äpple", "banan", "päron"}

"äpple" in my_set      # True
"banan" not in my_set  # False
"grapefrukt" in my_set # False

my_dict = {"Arne": 15, "John": "ej svarat", "Leja": 32, "Mårten": "ej svarat"}
# Detta är såklart exempelvärden och saknar betydelse

"Arne" in my_dict          # True
"Arne" in my_dict.keys()   # True, och ekvivalent med ovan
"Arne" in my_dict.values() # False

15 in my_dict                   # False
15 in my_dict.values()          # True
"ej svarat" in my_dict.values() # True

32 in my_dict.items()            # False
("Leja", 32) in my_dict.items()  # True
("Bertil", 2) in my_dict.items() # False

```

### `in` för strängar

Operatorn funkar lite kontraintuitivt för en `str`. Vi har ju nämnt att en sträng betraktas som en lista av karaktärer. `in`-operatorn beter sig som att strängen i högerled egentligen är mängden av alla sammanhängande delsträngar. En sammanhängande delsträng är 1 eller fler på varandra följande karaktärer i den ursprungliga strängen. Ett exempel för strängen `"Hej!"`, dess delsträngar är:

- `"H"`
- `"e"`
- `"j"`
- `"!"`
- `"He"`
- `"ej"`
- `"j!"`
- `"Hej"`
- `"ej!"`
- `"Hej!"`

Vi kollar alltså om vänsterledet är någon av de delsträngarna. Här kommer några exempel.

```python
"h" in "Hej!" # False
"H" in "Hej!" # True
"Hj" in "Hej!" # False
"j!" in "Hej!" # True

"c" in "abcdefghijklmnopqrstuvwxyzåäö" # True
"abc" in "abcefghijklmnopqrstuvwxyzåäö" # True
"df" in "abcdefghijklmnopqrstuvwxyzåäö" # False
```
