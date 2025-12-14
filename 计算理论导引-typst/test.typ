

#set page(width: auto, height: auto, margin: 1cm)

// 定义样式
#let dot-style = (fill: black, radius: 0.000001)
#import "@preview/cetz:0.4.1": canvas, draw
#canvas({
  import draw: *

  // ==========================
  // ==========================

  // 预先定义矩形的大小，避免在 rect() 内部直接写 (-2,-3) 导致解析报错
  let r-min = (-2, -3)
  let r-max = (2, 3)

  // --- 集合 B ---
  group(name: "group-b", {
    // 使用变量传入坐标
    rect(r-min, r-max, name: "frame")
    circle((0, 0.5), radius: 1.5, name: "set")
    content("set.north", $B$, anchor: "north", padding: 0.2)
    circle((0, -0.2), ..dot-style, name: "x")
    content("x.south", $x$, padding: 0.1)
  })

  // --- 集合 C ---
  group(name: "group-c", {
    translate((6, 0))
    rect(r-min, r-max, name: "frame")
    circle((0, 0.5), radius: 1.5, name: "set")
    content("set.north", $C$, anchor: "north", padding: 0.2)
    circle((-0, -0.2), ..dot-style, name: "fx")
    content("fx.south", $f(x)$, padding: 0)
    content((0, -2.5), $f(x)$)
  })

  // --- 集合 D ---
  group(name: "group-d", {
    translate((12, 0))
    rect(r-min, r-max, name: "frame")
    circle((0, 0.5), radius: 1.5, name: "set")
    content("set.north", $D$, anchor: "north", padding: 0.2)
    circle((0, -0.2), ..dot-style, name: "gfx")
    content("gfx.south", $g(f(x))$, padding: 0.1)
    content((0, -2.5), $g(y)$)
  })

  // ==========================
  // 2. 绘制箭头
  // ==========================

  line("group-b.set.east", "group-c.set.west", mark: (end: ">"), name: "arrow-f")
  content("arrow-f.mid", $f$, anchor: "south", padding: 0.1)

  line("group-c.set.east", "group-d.set.west", mark: (end: ">"), name: "arrow-g")
  content("arrow-g.mid", $g$, anchor: "south", padding: 0.1)

  // 顶部大弯箭头
  bezier(
    "group-b.frame.north",
    "group-d.frame.north",
    (6, 5),
    mark: (end: ">"),
  )
  content((6, 4.2), $g(f(x))$)
})
