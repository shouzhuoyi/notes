#set page(paper: "a4", margin: 3em)
#import "@preview/dvdtyp:1.0.1"
#import "@preview/numbly:0.1.0": numbly
#import "@preview/thmbox:0.3.0": *
#import "@preview/cuti:0.2.1": show-cn-fakebold
#import "@preview/dvdtyp:1.0.1": *
#show: dvdtyp.with(
  title: "计算理论导引笔记",
  subtitle: "2025",
  author: "kiwiizzz&xhkzdepartedream",
)
#show: show-cn-fakebold
#import "@preview/mitex:0.2.5": *
#set text(font: ("New Computer Modern Sans", "FmlSong", "Family Song"))
#show emph: text.with(font: ("New Computer Modern Sans", "STKaiti"))
#show strong: text.with(font: ("New Computer Modern Sans", "STKaiti"))
#show smartquote: set text(font: "Libertinus Serif")

#show math.equation: set text(purple, size: 1em)
#set line(length: 100%, stroke: 0.1pt)


#outline()
#show math.equation: it => {
  if it.body.fields().at("size", default: none) != "display" {
    return math.display(it)
  }
  it
}
#let fake-italic(body) = box(text([#skew(ax: -12deg) [#body]]))
#set math.equation(numbering: "(1)", supplement: [公式])
#include "计算理论导引-typst/chap1.typ"
#include "计算理论导引-typst/chap2.typ"
#include "计算理论导引-typst/chap3.typ"
