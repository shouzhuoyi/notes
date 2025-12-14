#set page(paper: "a4", margin: 3em)
#import "@preview/dvdtyp:1.0.1"
#import "@preview/numbly:0.1.0": numbly
#import "@preview/thmbox:0.3.0": *
#import "@preview/cuti:0.2.1": show-cn-fakebold
#import "@preview/dvdtyp:1.0.1": *
#show: dvdtyp.with(
  title: "答疑",
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
  非确定图灵机解决一个问题的具体时间怎么估计?
]
#solution([
  一个非确定图灵机要决策的时候是同时分裂出很多个不同路径的决策.我们把这个决策树的*深度*
  而不是总*节点数*当作时间函数.

  这也侧面地印证了非确定图灵机不是可以被造出来的.
])

