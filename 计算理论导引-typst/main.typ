#set page(paper: "a4", margin: 3em)
#import "@preview/dvdtyp:1.0.1"
#import "@preview/numbly:0.1.0": numbly
#import "@preview/thmbox:0.3.0": *
#import "@preview/cuti:0.4.0": show-cn-fakebold
#import "@preview/dvdtyp:1.0.1": *
#show: dvdtyp.with(
  title: "计算理论导引笔记",
  subtitle: "2025",
  author: "kiwiizzz&xhkzdepartedream",
)
#show: show-cn-fakebold
#import "@preview/mitex:0.2.7": *
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
#include "chap1.typ"
#include "chap2.typ"
#include "chap3.typ"
= 后记
计算复杂性理论是一门有趣的学科.在这里,你不需太关心细节,而是要理解证明的思想.与从例子出发不同,这门课理论和形式化的思想对笔者的认识、理解问题的能力得到了很大的启发.

笔记利用Typst编写.Typst的便携性和专业性处于markdown和LaTeX中间,非常适合用来写笔记.

既然你已经在茫茫github找到了这个仓库,希望我的笔记对大家有所帮助.难免有疏漏之处,请不吝修正之,并继续维护这个笔记.
