#set page(paper:"a4", margin: 3em)
#import "@preview/numbly:0.1.0": numbly
#import "@preview/thmbox:0.3.0": *
#import "@preview/cuti:0.2.1": show-cn-fakebold
#show: show-cn-fakebold
#import "@preview/mitex:0.2.5": *
#set text(font: "Songti SC")
//#show emph: text.with(font: ("STKaiti"))
#show smartquote: set text(font: "Libertinus Serif")
#import "@preview/dvdtyp:1.0.1": *
#show math.equation: set text(purple,size: 1.2em)
#set line(length: 100%,stroke: 0.1pt)
#show: dvdtyp.with(
  title: "计算理论导引笔记",
  subtitle: "2025",
  author: "kiwiizzz,xhkzdepartedream",
)

#set line(length: 100%,stroke: 0.1pt)

#set math.equation(numbering: "(1)", supplement: [  公式:  ])

= Space Complexity
可重用导致了空间复杂性的研究非常*风格迥异*.
#definition[
  如果$S : NN --> NN, L subset.eq {0,1}^* , $我们称$L in bold("SPACE")(S(n))$,如果存在一个$MM$在$c S(n)$个格子之内解决它.
]

与时间复杂性类似,我们有空间复杂性的可构造性.
#definition[
  如果$S : NN --> NN , S(n) gt.eq.slant log(n)$,我们称,
  + $S$空间可构造 $<==> exists MM $,它在$O(S(n))$空间内把$1^n$转成$⌞S(n)⌟$；类似定义
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
利用格局图我们可以解决如下问题：
#problem[
  任意给你两张快照$C$和$C'$，我们如何快速验证是否能从$C$的状态，根据规则，只走一步就变成$C'$的状态？
]
这个问题的结果是惊讶的:我们可以在$O(S(n)log(S(n)))$的时间内完成.

#proof[
  设$kappa = angle.l q,h, tau_1, dots.c , tau_S angle.r$表示格局,q是状态,h是读写头位置,后者全是工作带内容.
  设状态q的编码长度为Q：假设有 Q 个状态，我们就用 Q 个布尔变量 $u₁, u₂, ..., u_Q$ 来表示。
  设符号编码x长度为e：$x_i = {x_i^1, dots.c, x_i^e,x_i^h}$($x_i^h$表示读写头是否指向i)
  定义一公式$phi(u,x,v,y)$:
  $
  phi(u,x,v,y) = &(x_i^h and phi.alt(u,x_i,v,y_i,v,y_i,y_(i-1)^h,y_(i+1)^h)) or \
  &(overline(x_(i-1)^h) and overline(x_(i)^h) and overline(x_(i+1)^h) and (x_i^1 =y_i^1) and dots.c and (x_i^e =y_i^e) )

  $
  其中，$u$与$x$，$v$与$y$分别构成两个格局；$phi.alt$是一个根据迁移函数定义的合取范式.

  定义$ phi_(MM,x) = and.big_(i in S(n)) phi_i $,这个公式的长度是$O(S(n)log(S(n)))$.

  所以,我们可以对$phi_(MM,x)(C,C^')$扫描一遍后就能求值,进而解决问题.
]

#line()
利用bfs的思想,我们可以得到这个定理的第三个包含.
#theorem[
  #mitex(`\textbf{TIME}(S(n)) \subseteq \textbf{SPACE}(S(n)) \subseteq \textbf{NSPACE}(S(n)) \subseteq \textbf{TIME}(2^{O(S(n)}))`)
]

== 空间复杂性类
四个关键的定义.
#mitex(`

\begin{align*}
    \mathbf{L} &\overset{\text{def}}{=} \mathbf{SPACE}(\log(n)), \\
    \mathbf{NL} &\overset{\text{def}}{=} \mathbf{NSPACE}(\log(n)), \\
    \mathbf{PSPACE} &\overset{\text{def}}{=} \bigcup_{c > 0} \mathbf{SPACE}(n^c), \\
    \mathbf{NPSPACE} &\overset{\text{def}}{=} \bigcup_{c > 0} \mathbf{NSPACE}(n^c).
\end{align*}
`)
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
  
 #mitex(`1. \(\exists c, \forall x, f(x)| \leq c |x|^c,\)\\
1. \(\{(x, i) \mid i \leq |f(x)|\} \in \mathbb{L}\) \\
2. \(\{(x, i) \mid f(x) \mid = 1\} \in \mathbb{L}\).`)
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

自然想讨论$lt.eq.slant_L $的结合律.答案是肯定的.
#theorem[
  $lt.eq.slant _L$是结合的.
]
#figure(image("9ed3534a619618e298d4a93523973690.jpeg"),caption:[
派YYL来做这个漂亮的手写图
])
#proof[
  我们维护一个对数长的计数器,来看 $g$ 在处理 $f(x)$ 的哪一位.这是因为,图灵机在模拟 $g$ 的时候,不需要记录 $f(x)$ 的每一位,而只关心读写头到了哪里.我们可以视作 $f(x)$ 被记录在了一个虚拟带中,靠这个计数器来模拟读写头的读写.

 当 g 运行时，它的读写头会在虚拟带上移动。我们需要知道：g 的读写头当前在虚拟带的哪个位置？这个位置可以用一个计数器来记录。因为 f(x) 的长度是 $O(n^c)$（多项式），所以计数器只需要 $O(log n) $位。维护一个计数器 pos，表示 g 的读写头当前在虚拟带（即 $f(x)$）的哪个位置。初始时，pos = 0。每次 g 需要读取虚拟带的 pos 位时，调用 f 的“按需访问”功能，计算$f(x)_("pos")$。这可以在 $O(log n)$ 空间内完成（因为 f 是隐式对数空间可计算的）。每次 g 移动读写头（左移或右移），我们就更新 pos。
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
    #figure(align(center,image("image.png",height:25%,)))
    然后,对其利用dfs,得到一个指派,然后再线性空间里计算$psi$的值.
  ]

]
回到原定理.我们只需证$forall L in bold(L)$,$x in {0,1}^*,MM$在$S(abs(x))$空间里判定$L$.我们的想法是,把格局图中$C_("start") -> C_("accept")$的路径用QBF表示.我们归纳的构造这样的QBF.

我们令$psi_i (C,C')$判定是否有路径从$C$到$C'$,并且长度不超过$2^i$.所以$psi_i (C,C')$的逻辑结构如下:
$
  &(exists F forall D^1 forall D^2 ((D^1 = C and D^2 =  F) or (D^1 =  F and D^2 = C')) ==>psi_(i-1)(D^1,D^2))
$<yes>
上面一个公式的意思是:想找一个中间量F,让我们能够递归的调用$psi_(i-1)$.写得这么丑陋完全是因为要让他有QBF的形式.如果$D^1,D^2$不是$C,C',F$之一,上述式子一定真,因为前提是假的;当它们落进去了,就得递归的判断了.
来估算$abs(psi_i).$不难看出$abs(psi_i) = abs(psi_(i-1)) + O(S(abs(x)))$.所以$abs(psi_x) = O(S(abs(x))^2)$.所以我们定义了一个规约.
]

#remark[

1. Why $abs(psi_i) = abs(psi_(i-1)) + O(S(abs(x)))$? 这是因为,@yes 的式子中,我们得利用蕴含恒等式去计算.蕴含的前面有四个等号,我们通过暴力枚举每个点来判断等号是否成立,这是 $O(S(abs(x)))$的.
2. 我们可以把一个QBF看成一个博弈游戏,A先玩,B后玩.那么QBF表示的意思自然就是A是否有获胜策略.上面这个式子就证明了,判断博弈游戏里一个人是否有获胜策略是*PSPACE*-完全的.

]

我们可以把定理的证明思路归纳成:利用$NN$的猜测能力来解决$exists$,用计数器的枚举能力解决$forall$.下面这个定理给出了类似的思想.
#theorem("Savitch Theorem")[
如果$S$是空间可构造的,那么,$bold("NSPACE")(S(n)) subset.eq bold("SPACE")(S(n)^2)$.
]
#proof[
#figure(align(image("image-1.png", width:70%),center),caption:[
  证明的图
])
格局$C_1$能否在$t$步内到达$C_2$被视为一个函数：$g(C_1,C_2,t)$。显然
$g(A, B, t) eq exists M (g(A, M, t/2) and g(M, B, t/2)$

$S(n)$ (空间项)：在这个递归公式中，$S(n)$ 代表存储一个格局（Configuration $C$）所需的空间大小。
]

这个定理的推论是重要的:$bold("PSPACE") = bold("NPSPACE").$左边包含右边是显然的.右边包含左边利用定义证明.注意到$bold("NSPACE")(p^n) subset.eq bold("SPACE")(p^(2n)) ,forall p in "poly" $.
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
#theorem[
#overline("PATH")$in bold("NL")$.
]
#proof[
 用bfs.记s为起点,t为终点.我们引入集合$C_i,c_i$,$C_i$是所有能从$s$在$i$步内到达的点的集合,$c_i = abs(C_i).$
我们可以把一些(有限个)$c_i$放到带子上,但是我们不能存哪怕任何一个$C_i$.
具体的算法如下.

1. 记$c_i = 0 , i = 1,dots,n$;
2. 计算$c_1$;
3. 从$c_i -> c_(i+1)$.计算过程如下:
 - 不考虑时间,我们可以先*猜测*$C_i (eq.delta  hat(C)_i)$.首先,它之中的每个元素都和s的距离不超过i.我们用`PATH`验证.
 - 假设`PATH`验证通过.我们还需要$abs(hat(C)_i) = c_i$.这通过维护计数器可以做到.
 - 接着用bfs,我们可以做到$hat(C)_i -> C_(i+1)$.
4.判定t是否在可能的$C_i$里.为此,再*猜测*一次即可.
]