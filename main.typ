#set page(paper: "a4", margin: 3em)
#import "@preview/dvdtyp:1.0.1"
#import "@preview/numbly:0.1.0": numbly
#import "@preview/thmbox:0.3.0": *
#import "@preview/cuti:0.2.1": show-cn-fakebold

#show: show-cn-fakebold
#import "@preview/mitex:0.2.5": *
#set text(font: "Songti SC")
//#show emph: text.with(font: "STKaiti")
//#show smartquote: set text(font: "Libertinus Serif")
#import "@preview/dvdtyp:1.0.1": *
#show math.equation: set text(purple, size: 1em)
#set line(length: 100%, stroke: 0.1pt)
#show: dvdtyp.with(
  title: "计算理论导引笔记",
  subtitle: "2025",
  author: "kiwiizzz,xhkzdepartedream",
)

#outline()
//TODO:吧所有解读换成#denote[]
#show math.equation: it => {
  if it.body.fields().at("size", default: none) != "display" {
    return math.display(it)
  }
  it
}

#set math.equation(numbering: "(1)", supplement: [公式])

#include "计算理论导引-typst/chap1.typ"
#include "计算理论导引-typst/chap2.typ"
#include "计算理论导引-typst/chap3.typ"
