# Pythonboken för RFS 2026
© Marcell Ziegler (2026)
***
Detta är källkoden för Pythonboken vi kommer att använda oss av under RFS 2026. Den nuvarande publicerade sidan återfinns på: [rymdforskarskolan.github.io/rfs-python-bok](https://rymdforskarskolan.github.io/rfs-python-bok/).

## Att bidra till boken
Nödvändigt i din utvecklingsmiljö:
- `python` >= 3.9
- `jupyter-book` >= 2.1.2
- `ipykernel` (lämplig version)

Boken använder [Jupyter Book](https://jupyterbook.org) som i sin tur bygger på [MyST Markdowd](https://mystmd.org). Alla sidor är skrivna i MyST som är en supramängd av CommonMark. Instruktioner för hur man författar MyST finns i de föregående länkarna.

Vill du lägga till kapitel, följ den filstruktur som redan finns. Du behöver redigera [myst.yml](./myst.yml) för att dina ändringar skall synas på sidan. Du skall ändra under `toc` fältet.

### Hur du får igång allt
Först behöver du klona detta repo med git, och göra en egen branch så att du kan göra redigeringar.
```bash
git clone https://github.com/Rymdforskarskolan/rfs-python-bok.git
cd rfs-python-bok
git checkout -b <ditt-namn-på-din-branch> main
```

Sedan kan du redigera fritt. Näst behöver du installare de paket du behöver. Här kommer en liten instruktion som antar att du använder [`uv`](https://github.com/astral-sh/uv) för att hantera din pythonmiljö, men även `anaconda` m.m. funkar. Om du vill använda `pip` som "vanligt" är det bara `pip install jupyter-book ipykernel`. Men det är rekommenderat att använda en venv. Såhär går det till (på Linux och Mac, inte nödvändigtvis Windows):
```bash
uv venv
source .venv/bin/activate
uv pip install jupyter-book ipykernel
jupyter book start --execute
```

Nu kan du i din webbläsare navigera till `http://localhost:3000` där du hittar sidan. Ändringar du gör lokalt kommer automatiskt att synas på den lokala hemsidan. Vid funderingar hör av er till mig, @Marcell Ziegler, på RFS slack eller här i GitHub.

### Hur du publicerar dina ändringar
Förhoppningsvis har du gjort commits som man ska under redigeringens gång. Du behöver oavsett minst en sista commit. Skapa den, och sedan pusha dina ändringar till GitHub. Är du med i vår org så har du skrivtillstånd.

Öppna därefter en Pull Request till `main` med dina ändringar från din branch.

Om du undrar hur du pushar dina ändringar, eller gör commits för den delen, tipsar jag att läsa på om det själv. Jag kan hjälpa också, i andra hand.

### Lincenser
All prosa är publicerad under [CC-BY-NC-SA-4.0](./LICENSE).

All kod som hör till är publicerad under [MIT Lincensen](./CODE_LICENSE)
