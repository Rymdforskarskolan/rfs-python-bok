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

  mcu("rp2040", (0, 0), pins: pins, label: "RP2040")
  wire("rp2040.pin2", (rel: (-3, 0)), name: "w1")
  resistor("r1", "w1.out", (rel: (0, -2)), label: (content: $R_1$, anchor: "south"), u: $U_1$)
  wire("r1.out", (rel: (0, -1)), name: "w2")
  swire("w2.center", (rel: (-2, -3)), name: "w3")
  node("n1", "w2.center")
  wire("w3.out", (rel: (3.5, 0)), name: "w4")
  zwire("w4.out", "rp2040.pin6")
  resistor("r2", "w2.out", (rel: (0, -2)), label: (content: $R_2$, anchor: "south"), u: $U_2$)
  zwire("r2.out", "rp2040.pin4")
})
