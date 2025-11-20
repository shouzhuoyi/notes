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
即使你不直接算出整个 $f(x)$，只要你能“按需访问”它的每一位，并且只用很少的空间（对数空间），那这个函数就算‘隐式对数空间可计算’。
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
  这里应该有一个归约的定义
]