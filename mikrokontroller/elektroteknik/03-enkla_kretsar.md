---
kernelspec:
  name: python3
  display_name: Python 3
---

# Enkla kretsar

```{code-cell} ipython
:tags: [remove-input]

import schemdraw
import schemdraw.elements as elm
elm.style(elm.STYLE_IEC)
```

I detta kapitel går vi igenom vissa av de mest grundläggande kretsar vi kan bygga. Detta innefattar även hur man reducerar en mer komplex krets till en enklare sådan.

För och främst kommer vi dock att gå igenom viktiga lagar som gäller alla kretsar. Utifrån dessa lagar kan vi sedan beräkna det elektriska tillståndet i alla punkter i kretsen. Och när ni kan det, då har ni grejat (nästan) all ellära ni behöver för RFS!

## Lagen om spänningsdelning

För en krets med seriekopplade resistorer som nedan

```{code-cell} ipython
:tags: [remove-input]

with schemdraw.Drawing():
    elm.Line().dot(open=True).left()
    elm.Gap().up().label(("-", "", "", r"$U_\mathrm{tot}$"))
    elm.Gap().up().label(("Spänning", "", "+"))
    line = elm.Line().idot(open=True).right()
    R1 = elm.Resistor().down().label("$R_1$")
    R2 = elm.Resistor().down().label("$R_2$")
    elm.VoltageLabelArc().at(R1).label("$U_1$")
    elm.VoltageLabelArc().at(R2).label("$U_2$")
    elm.CurrentLabelInline("out", start=False).at(line).label("$I$")
```

gäller att $U_\mathrm{tot} = U_1 + U_2$. Det framgår av Kirschoffs spänningslag. Enligt [Ohms lag](./02-enkla_komponenter.md#resistorer) gäller även att

$$
U_1 = R_1 I, \quad U_2 = R_2 I \quad \Longleftrightarrow \quad U_\mathrm{tot} = I (R_1 + R_2)
$$

Från detta följer att
$$
U_1 = U_\mathrm{tot} \cdot \frac{R_1}{R_1 + R_2}
$$
