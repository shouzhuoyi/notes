#set page(paper: "a4", margin: 3em)
#import "@preview/dvdtyp:1.0.1"
#import "@preview/numbly:0.1.0": numbly
#import "@preview/thmbox:0.3.0": *
#import "@preview/cuti:0.2.1": show-cn-fakebold
#import "@preview/dvdtyp:1.0.1": *
#show: dvdtyp.with(
  title: "Review-no-ans",
  // subtitle: "2025",
  // author: "kiwiizzz&xhkzdepartedream",
)
#show: show-cn-fakebold
#import "@preview/mitex:0.2.5": *
#set text(font: ("New Computer Modern Sans", "FmlSong", "Family Song"))
#show emph: text.with(font: ("New Computer Modern Sans", "STKaiti"))
#show strong: text.with(font: ("New Computer Modern Sans", "STKaiti"))
#show smartquote: set text(font: "Libertinus Serif")

#show math.equation: set text(purple, size: 1em)
#set line(length: 100%, stroke: 0.1pt)


#problem[
  UC问题:
  $ "UC"(alpha) = cases(delim: "{", 0","& "if " MM_alpha (alpha) = 1, 1 ","& upright("otherwise"),) $
  停机问题：
  $
    "HALT"(alpha , x) = cases(delim: "{", 1"," & upright("if ") MM_alpha (x) arrow.b, 0"," & upright("otherwise"),)
  $
  它们都不能被判定.
]


#problem[
  设图灵机$MM$在$T(n)$步内判定$L$.对任意$epsilon>0$,有图灵机$MM'$,$MM'$能在$epsilon T(n)+n+2$步内判定$L$.
]


#problem[
  若函数 $f , g$ 是时间可构造的,而且 $f (n + 1) = o (g (n))$,则 $bold(upright(N T I M E)) (f (n)) subset.neq bold(upright(N T I M E)) (g (n))$.

]

#let np() = $bold("NP")$
#let nl() = $bold("NL")$
#let p() = $bold("P")$


#problem[
  `PATH` 是#nl()-complete的.
]


#problem[
  对数空间归约$lt.slant_L$的传递性.
]

#problem[
  证明:$L subset.eq {0,1}^star, L in #np()$等价于:

  $exists p :NN |-> NN, MM$是多项式时间的*图灵机*,且$forall x in {0,1}^star,$ 下述等价关系成立：$ x in L <==> exists u in {0,1}^(p(abs(x))) and MM(x, u) = 1 $.
]

#definition[
  解释空间可构造、完全空间可构造、时间可构造、隐式对数空间可计算、图灵机的基本概念.
]




