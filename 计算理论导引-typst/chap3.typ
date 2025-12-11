#set page(paper: "a4", margin: 3em)
#import "@preview/numbly:0.1.0": numbly
#import "@preview/thmbox:0.3.0": *
#import "@preview/cuti:0.2.1": show-cn-fakebold
#show: show-cn-fakebold
#import "@preview/mitex:0.2.5": *
//#set text(font: "Songti SC")
//#show emph: text.with(font: ("STKaiti"))
//#show smartquote: set text(font: "Libertinus Serif")
#import "@preview/dvdtyp:1.0.1": *

#set line(length: 100%, stroke: 0.1pt)
// #show: dvdtyp.with(
//   title: "计算理论导引笔记",
//   subtitle: "2025",
//   author: "kiwiizzz,xhkzdepartedream",
// )

#set line(length: 100%, stroke: 0.1pt)
#let np() = $bold("NP")$
#let p() = $bold("P")$

= NP Completeness
#quote[
  一个合格的计算机科学家能直觉地判断一个问题是否可计算。
]

作为一个开始,先撇开$bold("NP")$的猜测定义,而给粗一个等价的定义:
#definition[
  $L subset.eq {0,1}^star, L in "NP", <==> exists p :NN |-> NN, MM$是多项式时间的*图灵机*,且$forall x in {0,1}^star,$ 下述等价关系成立：$x in L <==> exists u in {0,1}^(p(abs(x))).MM(x, u) = 1$


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
  $
    f(z) = cases(
      ⟨alpha , x ,1^n , 1^(c(abs(alpha))t log t) ⟩ "," & z= ⟨alpha, x, 1^n, 1^t⟩,
      z"," & "else"
    )
  $
  所以我们分两步证明了命题.

]

#theorem[
  If $bold(P) = bold("NP")$then $bold("EXP") = bold("NEXP")$
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

  断言:$forall f:{0,1}^l |-> {0,1},$我们有一个(最多)$l 2^l$-CNF的合取范式$phi_f$,使得$f(x) = phi_f (x)$.
  也就是说，可以为任意布尔函数 f 构造一个 CNF 公式 $φ_f$，让它和 $f$ 在所有输入上输出完全一致。

  断言是正确的.这是因为,对于一个指派,我们总能在$l$个符号内把$f(x)$的值表示出来.又有$2^l$个指派.

  定义$L in bold("NP")$.由本文开篇提到的定义,$L in bold("NP")$等价于：存在通用多项式图灵机$MM$和多项式$p$ 使得$forall x in {0,1}^star, x in L <==> exists u in {0,1}^(p(|x|)), MM(x, u) = 1$.

  我们来构造一个多项式时间可计算的$phi : L --> "SAT",s.t. phi(x) in "SAT" <==> x in L.$也就是说构造一个Krap归约,
  $
    phi(x) in "SAT" <==> exists u in {0,1}^(p(|x|)), MM(x, u) = 1.
  $
  *Step2.计算的逻辑刻画*

  本步的主要动机是想把图灵机的计算变成公式.
  设单带图灵机$MM=(Gamma , Q , delta)$,时间函数$T(n),t = T(abs(x))$.不妨假设终止格局$C_t$时,带子上只是由输入、结果(0\/1)、$square$组成的,并且读写头指向那个结果(这是因为读写头只动了t步).具体的,如图所示.
  #align(
    figure(image("image-2.png", width: 070%), caption: [
      1
    ]),
    center,
  )

  我们将格局$C_i$的带子上的每一个符号用$l eq.delta log(abs(Gamma)) + log(abs(Q)) + 1$长度的01串编码.三个项的意思:第一个是存符号,第二个是存格局的状态;最后一个是存第$i$时刻读写头是否指向本格.

  图中的A之所以为A，是因为它会依赖于三个位置：上一时刻它顶上的a，或者a左边的1，或者a右边的b。

  那么,立刻可以用$bb(f):{0,1}^(3l) |-> {0,1}^l$来计算$C_i [j]$. 从上面三个的编码，可以推出下面一个的编码。

  这等价于可以用$bb(overline(f)):{0,1}^(4l) |-> {0,1}$来等价表示（Why?类比$x and y and z --> w$和利用蕴含表达式之后的结果）.这是一个布尔函数,根据断言,有一个合取范式$phi.alt$.如果记$z^(i,j) = C_i [j]$,则$bb(overline(f))$就是$ phi.alt_(i,j) eq.delta phi.alt(z^(i-1,j-1), z^(i-1,j), z^(i,j-1), z^(i,j)) $
  的一堆公式$phi.alt_(i,j)$构成的.
  #align(
    figure(image("image-3.png", width: 070%), caption: [
      图里的那么多C就是之前提到的$bb(f)$.这么一堆公式合取出来就的得到了输出.
    ]),
    center,
  )

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

== Berman-Hartmanis猜测
Berman-Hartmanis猜测：所有NP-完全问题都是等价的,也就是,多项式同构的,$ exists "Cook-Levin reductions" L ,A lt.slant_L B lt.slant_L A $

那么,记作$A ≅_p B$.我不想看Myhill字同构定理,但是他们通过构造垃圾信息证明了$exists "Karp reductions" k,k^(-1),==> A ≅_p B$.

#theorem[
  Berman-Hartmanis猜测$==> bold(P) eq.not bold("NP")$.
]
#proof[
  对语言$S subset.eq {0,1}^star , S^(lt.slant n)$表示S中所有长度不超过n的串的集合.我们称S是*稠密的*,iff,$abs(S^(lt.slant n)) = 2^n^(O(1))$;S是*稀疏的*,iff,$abs(S^(lt.slant n)) = n^(O(1))$.


  #lemma[
    记$L$稠密,$L'$稀疏.则$L ≅_p L'$ *不成立*.
    #line()
    #proof[
      反证,设$r$是双射卡普规约并且在多项式时间($p(n)$)计算$L --> L'$.则$r(L(n)) subset.eq L'^(lt.slant p(n))$.但是$L$稠密,所以$abs(L'^(lt.slant p(n))) = 2^(O(p(n)))$.所以$L'^(lt.slant p(n))$是稠密的,矛盾.
    ]

  ]

  熟知`SAT`是稠密的,则其不与${1^n | n in NN}$ 同构.若$bold(P) = bold("NP")$,则$bold("NPC") = bold(P)$,则${1^n | n in NN}$是$bold("NP")$完全的.矛盾!这就证明了$bold(P) eq.not bold("NP")$.

]

#remark[
  1. recall that $bold("NPC")$ 是#np()完全的问题构成的集合,而Karp规约是构造一个时间可计算函数把一个问题打到另一个问题上.
  2. Why `SAT` is dense? 考察$ phi.alt = (x_1 or x_2 or x_3 ) or.big_(i) C_i $.其中,$x_i$让$phi.alt$变得恒真,然后我们随便选$C_i$使得$abs(phi.alt) = n$.这至少是$2^n$的.
  3. $bold("NPC")$的意思是$bold("NP")$-完全问题。

]

== Ladner定理

令人不禁想问(其实只有傅和甘想问),#np()\\#p()里面有其他问题吗?Ladner定理证明了,#np()$eq.not$#p()时,#np()\\#p()里面*恰好*有无穷个其他问题.接下来考察一个弱化的版本.

#theorem[
  若#np()$eq.not$#p(),$bold("NPC") ∪ bold(P) eq.not np()$.
]
#proof[
  证明的动机是,`SAT`$in$ #np()完全的,但是`2SAT`$in$ #p() .想扔掉`SAT`里的一些元素,让他不#np()完全,但是又不至于落到#p()里面.

  #line()
  利用填充技术,将$phi.alt <==> phi.alt and n_1 and dots and n_h$,这里的等价符号的意思是可满足的等价性.用二进制,就表示为$phi.alt 01^h$.

  容易验证,${phi.alt 01^(abs(phi.alt)^c)| phi.alt in "SAT"}$是#np()完全的,而${phi.alt 01^(2^abs(phi.alt))| phi.alt in "SAT"}$是#p()的（直接暴力枚举所有变元的值即可）.

  记$ "SAT"_H = {phi.alt 01^(abs(phi.alt)^(H(abs(phi.alt))))| phi.alt in "SAT"} $并定义示性函数$"SAT"_H (x)$.

  我们如何做$H$?来做对角线法.对角化思想:如果某个算法想“猜中”$"SAT"_H$，我们就改变$"SAT"_H$的结构，让它失败。

  $
    H(n) = cases(
      i","quad & i<log(log(n)) and (forall x,MM_i (x)"在"i abs(x)^i"步内输出""SAT"_H (x)),
      log(log(n)) "," quad & "else"
    )
  $
  如果存在这样的 $i$，则令$H(n)=i$，这意味着我们发现了一个可能的 #p() 算法(在小输入上表现良好).于是我们“惩罚”它：把$H(n)$ 设为 $i$,从而让填充量变小(因为$i$很小),使得$"SAT"_H$更难,破坏这个算法的正确性.如果没发现,我们就往上跳.

  $H(n)$有两个性质：

  1. $H(n)$是非递减函数。

  2. $H$可在多项式时间内计算。

    计算步骤就和定义一样,枚举i,然后枚举*确定*的通用图灵机$MM_i$然后模拟那么多步计算.
    - 根据通用图灵机的定义，模拟*一个图灵机在一个输入$x$上*时间为$c(log(log(log(n))))C log C,C = log(log(n))(log(n))^(log(log(n)))$(这是$i|x|^i$直接代入的结果).

    带入之前的可得到$c(log(log(log(n))))C log C$是$o(n)$的，这是因为下标小于$log(log(n))$的自然数的二进制长度不会超过三个log。
    - 我们最多需要检查 $log log n$ 个图灵机，每个图灵机要检查所有满足$|x| <= log(n)$的|x|，这样的$x$有$2^log(n) = O(n)$个(外面的$O(n)$)。

      使用暴力算法，
      判定$x in "SAT"_H$的时间是$2^log(n) = O(n)$的(括号里面的那个$O(n)$).
      所以,$     & T(n) lt.slant (log log (n))O(n)(o(n)+O(n)+T(log(n))+O(1)) \
      ==> & T(n) = o(n^3). $


    #line()
    现在来用反证法证明$"SAT"_H in.not #p()$。


    假设$"SAT"_H$$in$#p(),则存在$MM_i$在$c n^c$时间内计算$"SAT"_H$。则对充分大的$n$,$H(n) lt.slant i$。又$H$不递减，说明$exists n_0 , forall n > n_0 , H(n) = D$为常数。

    这意味着$"SAT" lt.slant_K "SAT"_H$(结合$"SAT"_H$的定义)，这说明$"SAT"$$in$#p()，又$"SAT"$是#np()-完全的，故#p()$eq$#np()，与前提矛盾。
    #line()

    再来用反证法证明$"SAT"_H in.not bold("NPC")$。

    若$"SAT"_H in bold("NPC")$,则存在一个在$d n^d$时间内计算的规约$r: "SAT"|-> "SAT"_H$.由上述,$exists N , abs(psi)>d and$
    $ abs(r(phi)) = abs(psi 01^(abs(psi)^(H(abs(psi))))) >N $,可得到$H(abs(psi)) > 2d+1$.
    则$     & abs(psi)^(2d+1) < abs(psi)^(H(abs(psi)))<abs(r(phi)) lt.slant d abs(phi)^d < abs(psi) abs(phi)^d \
    ==> & abs(psi) < sqrt(abs(phi)). $

    所以,我们构造$"Sat"(phi)$算法如下:
    1. 计算$abs(phi)$为$psi 01^(abs(psi)^(H(abs(psi))))$形式;
    2. 若$r(phi)>N$,递归$"Sat"(psi)$;
    3. 否则,直接算.

    设调用了k次,则$1 lt.slant abs(phi)^(2^(-k)) lt.slant N$.则$k lt.slant log(log(abs(phi)))$.所以多项式时间可计算,$"SAT"_H in$#p(). 这又是一个矛盾.
]

== 神谕图灵机,以及更多
=== 神谕图灵机的定义、Lowness
我们想主观的解决所有的“子程序调用”问题,这样引入了神谕的概念.
#definition("Oracle Turing Machine")[
  一个*神谕图灵机* $MM^?$ 有额外的一条读写*神谕带*和*状态* $q_("query"), q_("yes"), q_("no")$.

  - $MM^?$ 需要一个判定问题,也就是*神谕* $B subset.eq {0, 1}^*$.
  - 在执行$MM^B$时,每当$MM^B$进入状态$q_("query")$,机器移动到状态$q_("yes")$如果$a in B$和$q_("no")$如果$a in.not B$，其中$a$是神谕带上的内容。
  - 一个查询到$B$算作*单步*计算。换言之，无论$B$有多难，查询只花 1 步时间。

  我们用$MM^B(x)$表示$MM^B$在输入$x$上的输出.

]
一类神谕可以用该类中最难的问题作为代表，例如：$#np()^#np()=#np()^"SAT"$。

#definition("Lowness")[
  若$A^B=A$，称复杂性类$B$对复杂性类$A$是*低的*。
]
#remark[
  - 直观理解，有没有神谕$B$对$A$而言都一样，也就是说$B$对$A$而言过于简单。(*就像计算理论对YYL过于简单*)
  - $#p()、bold("L")、bold("NL")$对自己而言是低的（第一个是显然的，后面两个是因为空间可复用），$bold("EXP")$对自己eryan不是低的。
  - 普遍认为#np()对自己而言不是低的。也就是说，$#np()^#np() eq.not #np()$。
]
*你能不能设法定义一个更容易打出来的bold函数，每次要括号还要引号*不太行,数学模式下只能用bold了
非数学模式下ctrl+B就好了
我们可以利用哥德尔编码来给神谕图灵机编码并排序$MM^?_0,MM^?_1,dots$.

我们还能用神谕图灵机来定义一些复杂的复杂性类.例如,$#p()^O$是带神谕O的确定图灵机可判定的问题所构成的集合.

我们还能用这些复杂性类来定义复杂性类.例如(作业里已经有了)
$
  #np()^#np() eq.delta ⋃_(O in #np())#np()^O.
$

$#np()^(O[k])$是$#np()^(O)$的一个子类.

#let pspace() = $bold("PSPACE")$

=== Cook Reduction
#definition("Cook Reduction")[
  若$bold("A") in #p()^B$，称$A$可Cook归约到$B$，记为$A lt.slant_C B$。

]

$L$ 可Cook归约到 $L'$ iff $L$ 可Cook归约到 $overline(L')$.

TODO：*详细地解释一下*Cook 归约（多项式时间图灵归约）允许在归约过程中多次调用神谕，因此它不是“一对一”的映射；而 Karp 归约（多项式时间多一归约）是“一对一”的，因为它只允许一次转换、不允许多次查询。



牛魔的他终于开始了
我们来看(finally!)本章的最后一个定理:
#theorem("Baker-Gill-Solovay Theorem")[
  $exists A,B ,#p()^A = #np()^A and #p()^B eq.not #np()^B$
  .
]
#proof[
  1. 第一个case:$#pspace() = #p()^#pspace() in #np()^#pspace() = #pspace()$.让神谕 A 足够强大，以至于#p()机器也能“模拟”#np()机器。任意#pspace()完全的问题都能解决问题,例如`QBF`.
  
  
  #line()
  2. 第二个case:直观地想,如果有一个问题,拒绝它需要调用大于多项式次数的神谕,所以我们在调用多项式次数的情形下*会犯错*,那么构造这样的问题就好了.不妨设这样的神谕是$B$,并且有$B_0 subset.eq B_1 subset.eq B_2 dots.c ,B = ⋃ B_i$.

  我们的目标是:对这个语言$L_B eq.delta{1^n |"B包含一个长度为n的01串"}$,我们构造$B$,让*所有多项式图灵机$MM_i^B$犯错*,也就是$L_B in.not #p()^B$.($L_B in #np()^B$,是因为非确定图灵机总能猜测这个$s$,然后调用神谕,而不是光靠枚举所有可能的$s$)

  利用先前提到的哥德尔编码,我们想让$MM^(B_i)_i$无法正确判断$1^(n_(i+1))$是否属于$B$.
  
  归纳地构造$B_i$：
  1. 如果$MM^(B_i)_i$在$2^(n_(i+1)-1)$步内判定$1^(n_(i+1))$为*拒绝*,那我们就让$B_(i+1) = B_i + s, s in {0,1}^(n_(i+1)).$
  2. 如果$MM^(B_i)_i$在$2^(n_(i+1)-1)$步内判定$1^(n_(i+1))$为*接受*,或者没停,那我们就让$B_(i+1) = B_i.$

  这两步以来,$B$里就是一系列“稀疏的”字符串集合,只在特定的$i$下有一个该长度的字符串.


  选择$n_(i+1)$足够大,保证$MM^(B_i)_i$在$2^(n_(i+1)-1)$步内只能查询$B_i$中的$"poly"(n_(i+1))$个字符串(因为每一步最多查一个字符串,而$B_i$只包含之前加入的有限个字符串).因此,我们可以安全地加入一个$s$,它不在$MM^(B_i)_i$的查询范围内,从而不影响$MM^(B_i)_i$在$B_i$上的行为.<1>
  
  #np() 机器可以非确定性地猜出正确的$s$，然后查询神谕，所以它总能正确判断$1^(n_(i+1))$是否属于$L_B$。
  
  
  根据对角线法则,我们可以发现$L_B$就是所求.命题得证.

  3. TODO:证明$L_B in #np()^B,L_B in.not #p()^B$。

]

#line()

#remark[
  1. 为什么#np()^#pspace() = #pspace()? 对一个$NN^cal(O),cal(O) in #pspace(),$它非确定的猜测一个$"poly"(n)+"poly"(T(cal(O)))$路径长度的可能分枝.所以,对一个#pspace()图灵机$MM_P$,可以由dfs的方法来模拟所有可能分支.
  2. 注意一下,其实$abs({0,1}^n) = 2^n > n^k$,所以光靠枚举是枚举不完所有的字符串的,这也是一个我们能让多项式图灵机犯错的基本逻辑.
  3. 动机：因为每一步最多查一个字符串,而$B_i$只包含之前加入的有限个字符串，但是增大$n_(i+1)$之后查询的次数也增大了。
   
    提问：理论上,是不是可以每次加入一大堆$s$,或者在$B_0$里加入一堆垃圾语言,严重延缓#p()图灵机的枚举?
   
    回答：这是没弄清楚#p()判定该语言的方式。一个#p()图灵机*无法感知*$B$里面有什么,只能一个个枚举n长度的01串是否存在于$B$内,再怎么更改$B$也没用，加入垃圾无从谈起。
  
]


P枚举所有的01串，跟加入垃圾延缓枚举有啥关系，P，P不知道B是啥，枚举对象是所有的01串，

让我烧烤一下放在哪

这里$n_(i+1)$只和调用神谕的时候*询问*$ a in_? B_i$的$a$有关.有可能$a$非常长,但我们只需要$n_(i+1)$比所有可能的$a$更长. 这一句话跟那个没关系吧，我要把它丢了 *我们只需要$n_(i+1)$比所有可能的$a$更长*，这是何意味，a的长度不就是$n_(i+1)$？ 狗屁,a的长度是神谕带上的内容
