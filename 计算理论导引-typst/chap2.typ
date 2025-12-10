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



= Space Complexity
可重用导致了空间复杂性的研究非常*风格迥异*.
#definition[
  如果$S : NN --> NN, L subset.eq {0,1}^* ,$我们称$L in bold("SPACE")(S(n))$,如果存在一个$MM$在$c S(n)$个格子之内解决它.
]

与时间复杂性类似,我们有空间复杂性的可构造性.
#definition[
  如果$S : NN --> NN , S(n) gt.eq.slant log(n)$,我们称,
  + $S$空间可构造 $<==> exists MM$,它在$O(S(n))$空间内把$1^n$转成$⌞S(n)⌟$；类似定义
  + $S$完全空间可构造$<==>$在上述过程中，$MM$刚好使用$S(n)$空间。
]
对于非确定图灵机$NN$，要求无论选择哪一条计算路径，所用的工作带上格子数不超过$O(S(n))$。当输入

== 格局图
我们可以把图的可达路径问题和图灵机是否接受的问题挂钩.格局图的用处立马可以被看到.
#definition[
  1. 格局图$G_(MM,x)$的节点是$MM(x)$的格局, 有向边表示一步操作引起的合法的格局之间的转换.
  2. 用$C_("start"),C_("end")$表示起始/终止格局,我们就把*”$MM$是否接受x“*等价成了*”$G_(MM,x)$是否包含从$C_("start")$到$C_("end")$的路径“*.

  #line()
  格局图的一个点可以用长度为$O(S(abs(x)))$的01串表示,所以这个图顶多有$2^(O(S(abs(x))))$个顶点.
]

#remark[ *Configuration（格局）的编码长度*

  一个格局 $C$ 必须完整地编码图灵机的所有信息，包括：

  磁带内容： 共有 $S(|x|)$ 个磁带格子，每个格子用固定的位数（通常是 $O(1)$ 或 $O(log|Sigma|)$）编码。总长度为 $O(S(|x|))$。

  读写头位置： 共有 $S(|x|)$ 个可能位置。需要 $log(S(|x|))$ 位来编码。

  机器状态： 状态集合 $Q$ 是有限的，需要 $O(1)$ 或 $O(log|Q|)$ 位来编码。

  因此，一个完整的格局 $C$ 作为一个布尔变量串，其总长度是由磁带内容长度主导的，即：#mitex(`$$\text{Length}(C) = O(S(|x|)) + O(\log S(|x|)) + O(1) = \mathbf{O(S(|x|))}$$`)
]

利用格局图我们可以解决如下问题：
#problem[
  任意给你两张快照$C$和$C'$，我们如何快速验证是否能从$C$的状态，根据规则，只走一步就变成$C'$的状态？
]
这个问题的结果是惊讶的:我们可以在$O(S(n)log(S(n)))$的时间内完成.

#proof[
  设$kappa = angle.l q,h, tau_1, dots.c , tau_S angle.r$表示格局,q是状态,h是读写头位置,后者全是工作带内容.
  设状态q的编码长度为Q：假设有 Q 个状态，我们就用 Q 个布尔变量 $u₁, u₂, ..., u_Q$ 来表示。
  设符号编码x长度为e：$x_i = {x_i^1, dots.c, x_i^e,x_i^h}$($x_i^h$表示读写头是否指向i)
  定义一公式$phi(u, x, v, y)$:
  $
    phi(u, x, v, y) = &(x_i^h and phi.alt(u, x_i, v, y_i, v, y_i, y_(i-1)^h, y_(i+1)^h)) or \
    &(overline(x_(i-1)^h) and overline(x_(i)^h) and overline(x_(i+1)^h) and (x_i^1 =y_i^1) and dots.c and (x_i^e =y_i^e) )
  $
  其中，$u$与$x$，$v$与$y$分别构成两个格局；$phi.alt$是一个根据迁移函数定义的合取范式.

  定义$ phi_(MM,x) = and.big_(i in S(n)) phi_i $,这个公式的长度是$O(S(n)log(S(n)))$.

  所以,我们可以对$phi_(MM,x)(C,C^')$扫描一遍后就能求值,进而解决问题.
]

#line()
利用bfs的思想,我们可以得到这个定理的第三个包含.
#theorem[
  #mitex(
    `\textbf{TIME}(S(n)) \subseteq \textbf{SPACE}(S(n)) \subseteq \textbf{NSPACE}(S(n)) \subseteq \textbf{TIME}(2^{O(S(n)}))`,
  )
]

== 空间复杂性类
四个关键的定义.
#mitex(
  `

\begin{align*}
    \mathbf{L} &\overset{\text{def}}{=} \mathbf{SPACE}(\log(n)), \\
    \mathbf{NL} &\overset{\text{def}}{=} \mathbf{NSPACE}(\log(n)), \\
    \mathbf{PSPACE} &\overset{\text{def}}{=} \bigcup_{c > 0} \mathbf{SPACE}(n^c), \\
    \mathbf{NPSPACE} &\overset{\text{def}}{=} \bigcup_{c > 0} \mathbf{NSPACE}(n^c).
\end{align*}
`,
)
任何能在多项式时间内运行的（非确定性）计算，最多只能使用多项式空间。因为图灵机每一步最多使用一个新格子，所以运行 T(n) 步最多使用 T(n) 个格子。

我们知道$bold("NP") subset.eq bold("PSPACE")$.这是因为,*空间可重用*,而空间复杂性类里我们对时间毫无约束.对非确定图灵机的不同的计算路径,我们可以先算一个($O(S(n))$),再擦掉,最后再计算一次.

#remark[
  Games are Harder than Puzzles.(ppt)

  *Fuck 计算理论导引.(——YYL)*
]

还有一个定理.
#theorem[

  $ italic("path")in bold("NL") $
  #line()
  PATH 问题：给定一个有向图 $G=(V,E)$ ，以及两个顶点 $s$ （起点）和 $t$ （终点），判断是否存在一条从 $s$ 到 $t$ 的有向路径。
]
#proof[
  标准的确定性算法（如 BFS 或 DFS）需要线性空间（$O(n)$）来记录已访问的节点，防止循环。但在非确定性模型中，我们可以“聪明地猜”一条路径，而不需要记录所有访问过的节点。

  对任意一个点$e in G$,设定一个非确定图灵机$NN$,它猜测$e$的一个邻居(不妨为$f$).猜测成功后,$NN$把$e$改成$f$,继续猜测.猜测$abs(G)$次后,如果不到达$t$,就拒绝.
  一次操作自然是$log(abs(G))$的,工作带只需同时存储：\
  当前节点 $v$ ：$O(log(n))$\
  计数器 $i$ ：$O(log(n))$\
  总共：$O(log(n))+O(log(n))=O(log(n))$ 空间。那么,$"path" in bold("NL")$.
]

== 空间谱系定理
nobody cares.


== Logspace Reduction
即使你不直接算出整个 $f(x)$，只要你能“按需访问”它的每一位，并且只用很少的空间（对数空间），那这个函数就算‘隐式对数空间可计算’。<label:logspace-reduction>
#definition[
  称$f$为隐式对数空间可计算的,如果他满足:

  #mitex(
    `1. \(\exists c, \forall x, |f(x)| \leq c |x|^c,\)\\
2. \(\{(x, i) \mid i \leq |f(x)|\} \in \mathbb{L}\) \\
3. \(\{(x, i) \mid f(x) \mid = 1\} \in \mathbb{L}\).`,
  )
]

#remark[
  即使你不直接算出整个 f(x)，只要你能“按需访问”它的每一位，并且只用很少的空间（对数空间），那这个函数就算‘隐式对数空间可计算’。
  1. 输出长度不能太长，最多只能是输入长度的多项式倍数。
  2. 给定输入 $x$ 和一个位置 $i$，你能用对数空间判断：$f(x)$ 的长度是否至少有 $i$ 位。
  3. 给定输入 $x$ 和一个位置 $i$，你能用对数空间判断：$f(x)$ 的 $i$ 位是不是1。
]


#definition[
  可计算全函数$f:{0,1}^* arrow.r {0,1}^*$是问题A到问题B的*m-归约*，记为$A lt.eq.slant_m B$，若满足：对任意0-1串x]

我们称$B$是对数空间规约到$C$的,当且仅当隐式空间可计算的B到C的规约.记作$lt.eq.slant_L$.

自然想讨论$lt.eq.slant_L$的结合律.答案是肯定的.
#theorem[
  $lt.eq.slant_L$是结合的.
]
#figure(align(center, image("9ed3534a619618e298d4a93523973690.jpeg", width: 40%)), caption: [
  派YYL来做这个漂亮的手写图
])
#proof[
  我们维护一个对数长的计数器,来看 $g$ 在处理 $f(x)$ 的哪一位.这是因为,图灵机在模拟 $g$ 的时候,不需要记录 $f(x)$ 的每一位,而只关心读写头到了哪里.我们可以视作 $f(x)$ 被记录在了一个虚拟带中,靠这个计数器来模拟读写头的读写.

  当 g 运行时，它的读写头会在虚拟带上移动。我们需要知道：g 的读写头当前在虚拟带的哪个位置？这个位置可以用一个计数器来记录。因为 f(x) 的长度是 $O(n^c)$（多项式），所以计数器只需要 $O(log n)$位。维护一个计数器 pos，表示 g 的读写头当前在虚拟带（即 $f(x)$）的哪个位置。初始时，pos = 0。每次 g 需要读取虚拟带的 pos 位时，调用 f 的“按需访问”功能，计算$f(x)_("pos")$。这可以在 $O(log n)$ 空间内完成（因为 f 是隐式对数空间可计算的）。每次 g 移动读写头（左移或右移），我们就更新 pos。
]
#line()

事实上,我们可以更直观的定义函数规约.以下的定义和1.4.1*等价*.
#definition[
  称$f:{0,1}^* arrow.r {0,1}^*$是*对数空间可计算的*,iff,$MM_f$使用了工作带上的对数个格子,并且他的输出带是只写的:也就是说,输出带的读写头每写一次都必须往右移一位.
]
tmd为什么书上不证明这两个定义是等价的?

== Space Completeness
#quote[
  ...*PSPACE*-难的问题是对人类计算能力的极限挑战;我们已经无奈地接受了一个事实,就是人类是完全打不过多项式空间图灵机的.
]

我们来考察一些问题的困难性.
#definition[称$A$是*X-难*的,iff, $forall A in XX, A lt.eq.slant_X B$.如果$A in X$,那么$A$是*X-完全*的.]

例如：A language $L'$ is PSPACE-hard if $L≤_L L'$ for every $L in bold("PSPACE")$.

If in addition $L' in bold("PSPACE")$ then $L'$ is *PSPACE*-complete.

PSPACE 中的每一个问题 L，都可以用对数空间归约到 L'。也就是说，L' 至少和 PSPACE 中最难的问题一样难。但L' 本身不一定在 PSPACE 中！


QBF之前已经写过.我们来考察这一个不错的结果.
#theorem[
  QBF 是 *PSPACE*-完全的。(*Stockmeyer-Meyer 1974*)

  QBF: $Q_1 x_1 Q_2 x_2 . . . Q_n x_n . φ(x_1, . . . , x_n)$，其中$Q_i$是$forall$或者$exists$。
]
#proof[
  先来看一个引理.
  #lemma[
    `QBF`可在线性空间内判定.
    #line()
    #proof[
      把$psi = Q_1x_1...Q_n x_n phi(x_1, ..., x_n)$化成如下所示的二叉树:
      #figure(align(center, image("image.png", height: 25%)))
      然后,对其利用dfs,得到一个指派,然后再线性空间里计算$psi$的值.
    ]

  ]
  回到原定理.我们只需证$forall L in bold(L)$,$x in {0,1}^*,MM$在$S(abs(x))$空间里判定$L$.我们的想法是,把格局图中$C_("start") -> C_("accept")$的路径用QBF表示.我们归纳的构造这样的QBF.

  我们令$psi_i (C,C')$判定是否有路径从$C$到$C'$,并且长度不超过$2^i$.所以$psi_i (C,C')$的逻辑结构如下:
  $
    & (exists C forall D^1 forall D^2 ((D^1 = C and D^2 = F) or (D^1 = C and D^2 = C')) ==>psi_(i-1)(D^1,D^2))
  $<yes>
  上面一个公式的意思是:
  #mi(`$\exists C''$`)：先猜一个中间点 $C''$。

  #mi(`$\forall D^1 \forall D^2$`)：对于任意的一对节点 #mi(`$(D^1, D^2)$`)...

  #mi(`$(\dots) \Rightarrow \psi_i(D^1, D^2)$`)：如果这对节点满足特定条件：如果你考察的是 (起点, 中点) 这一对，或者 你考察的是 (中点, 终点) 这一对，那么它们之间必须连通（调用 $psi_i$）。

  再来估算$abs(psi_i).$不难看出$abs(psi_i) = abs(psi_(i-1)) + O(S(abs(x)))$.所以$abs(psi_x) = O(S(abs(x))^2)$.所以我们定义了一个规约.
]

#remark[

  1. Why $abs(psi_i) = abs(psi_(i-1)) + O(S(abs(x)))$? 这是因为,的式子中,我们得利用蕴含恒等式去计算.蕴含的前面有四个等号,我们通过暴力枚举每个点来判断等号是否成立,这是 $O(S(abs(x)))$的.
  2. 我们可以把一个QBF看成一个博弈游戏,A先玩,B后玩.那么QBF表示的意思自然就是A是否有获胜策略.上面这个式子就证明了,判断博弈游戏里一个人是否有获胜策略是*PSPACE*-完全的.
  3. 核心公式这一步不是把代码复制粘贴两遍（导致代码膨胀），而是写了一个 for 循环或者定义了一个函数，然后传入不同的参数调用它。如果$D^1,D^2$不是$C,C',cent$之一,上述式子一定真,因为前提是假的;当它们落进去了,就得递归的判断了.

]

因为格局图的大小是$2^(S(|x|))$，所以找到的中间格局会使得递归深度除以2，也就是变成$2^(S(|x|)-1)$，所以一共递归$S(|x|)$次，所以复杂度是$O((|x|)^2)$。

我们可以把定理的证明思路归纳成:利用$NN$的猜测能力来解决$exists$,用计数器的枚举能力解决$forall$.下面这个定理给出了类似的思想.
#theorem("Savitch Theorem")[
  如果$S$是空间可构造的,那么,$bold("NSPACE")(S(n)) subset.eq bold("SPACE")(S(n)^2)$.
]
#proof[
  #figure(align(image("image-1.png", width: 70%), center), caption: [
    证明的图
  ])
  这张图直接展示了证明的思路:我们构造这样的格局二叉树,使得,$C_("start"),C_("accept")$在左下角和右下角.我们通过“先左儿子,再右儿子,再祖先”的顺序dfs整个二叉树,利用枚举二进制编码来判断是否存在右儿子.这个流程显然是确定图灵机可完成的.

  那么,这里需要多少空间?二叉树的高度是$O(log(2^(S(n)))) = O(S(n))$的.一个格局的枚举是$O(S(n))$的.由于最坏情况我们需要存$C_("start") --> C_1$的所有路径,也就是说需要遍历所有层.所以,这个图所占的空间是$O(S(n)^2)$.

]
#line()
这个定理的推论是重要的:$bold("PSPACE") = bold("NPSPACE").$左边包含右边是显然的.右边包含左边利用定义证明.注意到$bold("NSPACE")(p^n) subset.eq bold("SPACE")(p^(2n)) ,forall p in "poly"$.
== NL完全性
#definition[
  称$B$是*NL-完全*的,iff, $forall A in bold("NL"), A lt.eq.slant_L B$.

]
我们可以看到一个很惊讶的结果:如果$A in bold("NL")$,那么$A$是*NL-完全*的.
我们通过证明`PATH`是*NL*-完全的来证明这个结果.

#theorem[
  `PATH` 是 *NL*-完全的。(*Karp 1972*)
]
#proof[
  记$L in bold("NL").$我们来证明$L lt.eq.slant_L "PATH"$.定义规约$kai: x |-> ⟨ G_(NN,x),C_("start"),C_("accept") ⟩ .$注意,我们可以用邻接矩阵储存$G,G$的每一个元素都可以在对数空间内计算得到.
  所以$kai$是对数规约.得证.
]

== Immerman-Szelepcsenyi Theorem
在Savitch Theorem中,我们证明*CONPSPACE = NPSPACE*.但是,*coNL*和*NL*无法判断.

但是,Immerman提出了,`PATH`的补问题：
#theorem("Immerman-Szelepcsenyi Theorem")[
  #overline("PATH")$in bold("NL")$.
]
#proof[
  用bfs.记s为起点,t为终点.我们引入集合$C_i,c_i$,$C_i$是所有能从$s$在$i$步内到达的点的集合,$c_i = abs(C_i).$
  我们可以把一些(有限个)$c_i$放到带子上,但是我们不能存哪怕任何一个$C_i$.
  具体的算法如下.

  1. 记$c_i = 0 , i = 1,dots,n$;
  2. 计算$c_1$;
  3. 从$c_i -> c_(i+1)$，此时$c_i$的值是确凿无疑的，计算过程如下:
    - 对每个不为$s$的节点$v$，若$v in C_i$或从某个$C_i$中的节点$u$到$v$有一条边，则计数器$c_(i+1)$+1。
    可是$C_i$无法被保存，只能猜测：
    - *猜测*$C_i$这个点集，猜测的结果被记为$hat(C)_i$，并验证$hat(C)_i$是否等于$C_i$：
      - 首先，$hat(C)_i$之中的每个元素都和s的距离不超过i，我们用`PATH`算法验证.
      - 若`PATH`验证通过，则还需要$abs(hat(C)_i) = c_i$.这通过维护计数器可以做到.
    - 以上两步有任意一个条件未满足的图灵机$NN$所在的时空分支停机，而有一个时空中，以上两步都通过，则可以认为$hat(C)_i$是确凿无疑的了。
  4.最终图灵机已经正确地算出$c_(n-1)$，现在要判定t是否在可能的$C_(n-1)$里。为此，再*猜测*一次$C_(n-1)$即可。

  非确定算法总会有一条计算路径将$C_i$正确猜出，将$c_i$正确算出。
]
#let nl() = $bold("NL")$
#corollary[
  $text("co")bold("NL")=bold("NL")$.
]
#proof[
  PATH是 #nl()-完全的，所以#overline("PATH")是co#nl()-完全的。又由$#overline("PATH") in nl()$，有$text("co")#nl() #sym.subset.eq #nl()$。再由补问题的定义，得证。
]


#theorem[
  `2SAT` 是#nl()完全的.
]
#proof[
  1. 证明 $"2SAT" ∈ #nl()$ （相对简单）。

    假设我们有一个`2SAT`是$phi$。

    对$phi$的k个变量,构造2k个点$x_1,dots,x_k,overline(x_1),dots,overline(x_k)$；构造边$overline(u) --> v,overline(v)--> u <==> u or v in phi$.

    证明：$phi$不可满足当且仅当$v ,overline(v)$是通路.

    必要性很显然，充分性：
    假定不存在$v,overline(v)$的通路，我们对没有赋值的$v,forall w s.t.v-->w$,给$w$赋值为真,$overline(w)$赋值为假.这样归纳的我们找到了真值指派,矛盾.

    这就把`2SAT`问题归约到了图的不可达性问题(#overline("PATH"))，而(#overline("PATH"))和PATH都是#nl()-完全的；

    所以$2 S A T ∈ #nl()$。

  2. 证明 $2 S A T$ 是 #nl()-难的。

    留给ysz证明，我说留给ysz证明，你耳朵龙马（书P58）


]

#theorem[
  #mitex(
    `L \subseteq \textbf{NL} \subseteq \textbf{P} \subseteq \textbf{NP} \subseteq \textbf{PSPACE} \subseteq \textbf{EXP}.`,
  )
]
