#import "@preview/zap:0.5.0"
#set page(height: auto, width: auto, margin: 5pt)

#let pins = (
  (content: "RESET", side: "west"),
  (content: "3.3V", side: "west"),
  (content: "3.3V", side: "west"),
  (content: "GND", side: "west"),
  (content: "A0", side: "west"),
  (content: "A1", side: "west"),
  (content: "A2", side: "west"),
  (content: "A3", side: "west"),
  (content: "D24", side: "west"),
  (content: "D25", side: "west"),
  (content: "SCK", side: "west"),
  (content: "MOSI", side: "west"),
  (content: "MISO", side: "west"),
  (content: "RX", side: "west"),
  (content: "TX", side: "west"),
  (content: "D4", side: "west"),
  (content: "VBAT", side: "east"),
  (content: "EN", side: "east"),
  (content: "VBUS", side: "east"),
  (content: "D13", side: "east"),
  (content: "D12", side: "east"),
  (content: "D11", side: "east"),
  (content: "D10", side: "east"),
  (content: "D9", side: "east"),
  (content: "D6", side: "east"),
  (content: "D5", side: "east"),
  (content: "SCL", side: "east"),
  (content: "SDA", side: "east"),
)

#zap.circuit({
  import zap: *

  vsource("v1", (0, -2.5), (0, 2.5), variant: "ieee", label: $U_"in"$)
  wire("v1.out", (rel: (3, 0)), name: "w1")
  resistor("r1", "w1.out", (rel: (0, -2)), label: (content: $R_1$, anchor: "south"), u: $U_1$)
  wire("r1.out", (rel: (0, -1)), name: "w2")
  wire("w2.center", (rel: (2, 0)), name: "w3")
  node("n1", "w3.out", label: $V_"ut"$)
  resistor("r2", "w2.out", (rel: (0, -2)), label: (content: $R_2$, anchor: "south"), u: $U_2$)
  wire("r2.out", "v1.in")
})
