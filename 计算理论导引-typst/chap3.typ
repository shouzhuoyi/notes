#set page(paper: "a4", margin: 3em)
#import "@preview/numbly:0.1.0": numbly
#import "@preview/thmbox:0.3.0": *
#import "@preview/cuti:0.2.1": show-cn-fakebold
#show: show-cn-fakebold
#import "@preview/mitex:0.2.5": *
#set text(font: "Songti SC")
//#show emph: text.with(font: ("STKaiti"))
#show smartquote: set text(font: "Libertinus Serif")
#import "@preview/dvdtyp:1.0.1": *

#set line(length: 100%, stroke: 0.1pt)
// #show: dvdtyp.with(
//   title: "计算理论导引笔记",
//   subtitle: "2025",
//   author: "kiwiizzz,xhkzdepartedream",
// )

#set line(length: 100%, stroke: 0.1pt)


= NP Completeness
#quote[
一个合格的计算机科学家能直觉地判断一个问题是否可计算。
]

作为一个开始,先撇开$bold("NP")$的猜测定义,而给粗一个等价的定义:
#definition[
  $L subset.eq {0,1}^star, L in "NP", <==> exists p :NN |-> NN, MM$是多项式时间的*图灵机*,且$forall x in {0,1}^star,$ 下述等价关系成立：$ x in L <==> exists u in {0,1}^(p(abs(x))).MM(x,u) = 1$


  我们称$MM$是L的*验证器*.若$abs(u) = abs(p(x))$,称$u$是$x$的*证书*.

]
#remark[
  L视为一类问题，x就是这类问题的一个具体的实例，u可以视为x的解。
  
  如果对每个x（具体的问题），都有这样的关系：一个输入 x 属于问题集合 L，当且仅当 存在一个u，它的长度不超过 p(|x|)，并且验证器 M 拿着 x 和 u 一跑，而且这个计算的时间还是多项式时间。
]

#proof[
  考虑通用图灵机对非确定图灵机的模拟,和非确定图灵机的猜测能力来考察iff的两边.
]

我们可以理解为:*P*是能在*多项式时间找出证明*的问题,而*NP*是多项式长证明的问题.
下面是一些NP-问题的例子.
#example[
  1. 独立集IS
  2. 旅行商TSP
  3. 图同构问题GI
]

== NP-难
先来定义Karp规约,因为我们想刻画*NP*里面的很难的问题.
#definition[
  $L,L' subset.eq {0,1}^star.$称$L lt.eq.slant_K L'$,如果有一个函数$r:{0,1}^star |-> {0,1}^star$，使得对于所有$x in {0,1}^star$,$x in L <==> r(x) in L'$.

  称$L$是$L'$的*Karp规约*.
]

#definition[
  $L$是*NP-难*的,$forall A in bold("NP")$，使得$A lt.eq.slant_K L$.进一步,如果$L in bold("NP")$,则$L$是*NP-完全*的.
]
令人不禁想问(或者只有傅想问:)真的有*NP*完全问题吗?有一个简单的思路:构造所有的NP问题的问题.记作TMSAT问题.

#definition("有界停机问题")[
  TMSAT = ${ ⟨alpha, x, 1^n, 1^t⟩ |$ 存在 $u ∈ {0,1}^n$，使得图灵机 $M_alpha$ 在输入 $(x, u)$ 上运行 t 步后输出 1} 
]
它是NP-完全的。证明如下：

#proof[

  *Step1.*TMSAT ∈ NP

拿到一个证书 u（长度 n）
模拟图灵机 $M_alpha$ 在输入 (x, u) 上运行 t 步
如果它输出 1 → 接受；否则拒绝
模拟 t 步的时间是 $O(t)$，而 t 是输入的一部分，所以输入长度至少是 t，因此模拟时间是多项式级别的。

所以 TMSAT ∈ NP。

*Step2.* $exists L in bold("NP"), "TMSAT" lt.eq.slant_K L$

我们记$L = { ⟨alpha, x, 1^n, 1^t⟩ |$ 存在 $u ∈ {0,1}^n$，使得健忘图灵机 $UU_alpha$ 在输入 $(x, u)$ 上运行 t 步后输出 1}.则$L lt.slant_K "TMSAT"$,取
$ f(z) = cases(
   ⟨alpha , x ,1^n , 1^(c(abs(alpha))t log t) ⟩ ","&z= ⟨alpha, x, 1^n, 1^t⟩,
   z","&"else"
) $
所以我们分两步证明了命题.

]

#theorem[
  If $bold(P) = bold("NP") $then $bold("EXP") = bold("NEXP")$
]
#proof[
  说白了是添加垃圾。若$L ∈ bold("NEXP")$ is accepted by an NDTM in $2^n^c$ time，
  
  $L_(p a d) = { x 01^(2^{|x|^c}) | x in L } in N P$
  把每个输入 x 后面加上一串很长的 01 串，长度是 $2^(|x|^c)$（指数级长）。现在$L_(p a d)$已经属于$N P$了。
  那么根据假设，$L_(p a d)$属于$P$。

  放过我吧，我写不下去了。
]

== Cook-Levin 定理
回顾一下合取范式CNF.kCNF是最多k个变量的CNF.

在第一章我们就学过SAT,它是所有可满足的CNF的集合。2-SAT是指每一个语句最多只有2个变量的主合取范式。
#theorem[
  SAT是*NP-完全*的.
]
#proof[
  先来对SAT有一些认知.


  #lemma[
    SAT $lt.slant_K$ 3-SAT.考虑:
    $u_1 or u_2 or u_3 or u_4 or u_5 = (u_1 or u_2 or v) and (not v or u_3 or w) and (not w or u_4 or u_5)$.

    反之也成立(这是因为3-SAT是SAT的子集).所以,3SAT和SAT是一样困难的.
  ]


  #line()
  *Step1.准备工作*


  注意,我们可以把一堆等号表示成合取范式：$x = y ⇔ (x or y) and (not x or not y)$.
  
  断言:$forall f:{0,1}^l |-> {0,1}, $我们有一个(最多)$l 2^l$-CNF的合取范式$phi_f$,使得$f(x)  = phi_f (x)$. 
  也就是说，可以为任意布尔函数 f 构造一个 CNF 公式 $φ_f$，让它和 $f$ 在所有输入上输出完全一致。
  
  断言是正确的.这是因为,对于一个指派,我们总能在$l$个符号内把$f(x)$的值表示出来.又有$2^l$个指派.

  定义$L in bold("NP")$.由本文开篇提到的定义,$L in bold("NP")$等价于：存在通用多项式图灵机$MM$和多项式$p$ 使得$forall x in {0,1}^star, x in L <==> exists u in {0,1}^(p(|x|)), MM(x,u) = 1$.
  
  我们来构造一个多项式时间可计算的$phi : L --> "SAT",s.t. phi(x) in "SAT" <==> x in L.$也就是说构造一个Krap归约,
  $
  phi(x) in "SAT" <==> exists u in {0,1}^(p(|x|)), MM(x,u) = 1.
  $
  *Step2.计算的逻辑刻画*

  本步的主要动机是想把图灵机的计算变成公式.
  设单带图灵机$MM=(Gamma , Q , delta)$,时间函数$T(n),t = T(abs(x))$.不妨假设终止格局$C_t$时,带子上只是由输入、结果(0\/1)、$square$组成的,并且读写头指向那个结果(这是因为读写头只动了t步).具体的,如图所示.
  #align(figure(image("image-2.png",width:070%),caption:[
    1
  ]),center)

  我们将格局$C_i$的带子上的每一个符号用$l eq.delta log(abs(Gamma)) + log(abs(Q)) + 1$长度的01串编码.三个项的意思:第一个是存符号,第二个是存格局的状态;最后一个是存第$i$时刻读写头是否指向本格.
  
  图中的A之所以为A，是因为它会依赖于三个位置：上一时刻它顶上的a，或者a左边的1，或者a右边的b。
  
  那么,立刻可以用$bb(f):{0,1}^(3l) |-> {0,1}^l$来计算$C_i [j]$. 从上面三个的编码，可以推出下面一个的编码。

  这等价于可以用$bb(overline(f)):{0,1}^(4l) |-> {0,1}$来等价表示（Why?类比$x and y and z --> w$和利用蕴含表达式之后的结果）.这是一个布尔函数,根据断言,有一个合取范式$phi.alt$.如果记$z^(i,j) = C_i [j]$,则$bb(overline(f))$就是$
    phi.alt_(i,j) eq.delta phi.alt(z^(i-1,j-1),z^(i-1,j),z^(i,j-1),z^(i,j))
  $
  的一堆公式$phi.alt_(i,j)$构成的.
#align(figure(image("image-3.png",width:070%),caption:[
    图里的那么多C就是之前提到的$bb(f)$.这么一堆公式合取出来就的得到了输出.
  ]),center)

  最后定义$phi$为所有局部字句的合取。这是确保计算历史合法：在 CNF 公式中，所有的$C_(i j)$ 都是“未赋值的布尔变量”，SAT 求解器可以任意给它们赋值——只要满足局部子句。如果不强制它们之间的时间一致性，就可能出现逻辑上合法但计算上不可能的赋值。

  注意，每一个$C$的大小不超过$4l 2^(4l)$.$l$依赖于图灵机本身的定义，所以$C$的大小是常量。而一共有$t^2$个$C$，所以输出的长度是$O(t^2)$，是多项式时间的。

  这就证明了归约所花费的时间是多项式时间的。
  
  把公式分成三堆:input,compute,output.
  1. input. $gamma_0 eq.delta z^(0,0)z^(0,1) dots z^(0,t)$


  *我发现跟这个分成三队没关系。*

]

Krap随后提出了21个NP-完全问题,让这个研究变得很有意义.(也让找到一个NP-完全问题这种idea发不了论文——傅育熙)
#example("Karp的21个问题")[

- SAT
  - 0-1 Integer Programming
  - Clique
    - Set Packing
    - Vetex Cover
      - Set Covering, Feedback Node Set, Feedback Arc Set
      - Directed Hamilton Circuit
        - Undirected HC

  - 3-SAT
    - Chromatic Number
      - Clique Cover
      - Exact Cover
        - Hitting Set, Steiner Tree, 3-Dimensional Matching
        - Knapsack
          - Job Sequencing
          - Partition
            - Max Cut
]

#problem("Godel's Question")[
  设$cal(A)$是一个公理系统，该公理系统可以解释合取范式，

  `THEOREM`$={phi,1^(|phi|^c)}|phi text("有一个长度不超过")|phi|^c 的 cal(A) text("中的证明")$
]
#proof[
  1. 显然，给定一个证明，计算机能在“证明长度”的多项式时间内，快速验证它是否正确。
  2. 
]