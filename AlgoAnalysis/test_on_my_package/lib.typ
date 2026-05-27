#import "@preview/numbly:0.1.0": numbly
#import "@preview/thmbox:0.3.0": *
#import "@preview/hydra:0.6.2": hydra
#import "@preview/i-figured:0.2.4"
#import "@preview/cetz:0.3.1"

// --- 定义模板函数 ---
#let conf(
  font: "Source Han Serif SC",
  margin: (top: 2.5cm, left: 1.5cm, right: 1.5cm, bottom: 1.5cm),
  font-size: 12pt,
  paper: "a4",
  heading-numbering: numbly(
    "第{1}章",
    "{1}.{2}节",
    "{1}.{2}.{3}",
    "{1}.{2}.{3}.{4}",
    "({5:a})",
  ),
  title: "标题",
  author: "作者",
  body,
) = [
  #show: thmbox-init(counter-level: 3)
  #show math.equation: i-figured.show-equation.with(only-labeled: true, level: 2)
  #set page(
    paper: paper,
    margin: margin,
    numbering: "1",
    header: context {
      if calc.odd(here().page()) {
        align(right, emph(hydra(2)))
      } else {
        align(left, emph(hydra(3)))
      }
      line(length: 100%)
    },
    footer: context {
      if here().page() == 1 {
        // set align(center)
        // counter(page).display("I")
        // } else if here().page() <= 4 {
        //   set align(center)
        //   counter(page).display("I")
      } else {
        set align(center)
        [#author —— #counter(page).display("1") —— #title]
      }
    },
  )
  #show emph: text.with(font: ("New Computer Modern Sans", "STKaiti"))
  #show raw.where(block: false): it => box(
    fill: luma(240),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
    it,
  )
  #show math.equation: set text(purple, size: 1em)
  #show raw.where(block: true): it => {
    let lang = if it.has("lang") { it.lang } else { "TEXT" }
    set text(size: 10pt)
    block(
      fill: luma(252),
      stroke: 0.5pt + luma(200),
      radius: 6pt,
      width: 100%,
      inset: 0pt,
      clip: true,
      stack(
        dir: ttb,
        block(
          fill: luma(240),
          width: 100%,
          inset: (x: 10pt, y: 8pt),
          stroke: (bottom: 0.5pt + luma(220)),
          grid(
            columns: (1fr, auto),
            align: (left + horizon, right + horizon),
            text(font: "Arial", weight: "bold", fill: luma(150), size: 8pt, upper(lang)),
          ),
        ),
        block(
          width: 100%,
          inset: 12pt,
          it,
        ),
      ),
    )
  }
  #set text(font: font, size: font-size, lang: "zh")
  #set heading(numbering: heading-numbering)

  #body

]

#let abstract = note.with(
  variant: "Abstract",
  color: purple,
)
