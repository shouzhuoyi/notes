#set page(paper: "a4", margin: 3em)
#import "@preview/dvdtyp:1.0.1"
#import "@preview/numbly:0.1.0": numbly
#import "@preview/thmbox:0.3.0": *
#import "@preview/cuti:0.2.1": show-cn-fakebold
#import "@preview/dvdtyp:1.0.1": *
#import "@preview/mitex:0.2.5": *
#show: dvdtyp.with(
  title: "Karp的21个NPC问题简要证明",
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


我们只需理解就好.
#problem[
  - SAT
    - 0-1 Integer Programming (0-1 整数规划：对于一个 #mi(`m \times n`) 的整数矩阵 $A$ 和一个 $m$ 维的整数向量 $b$，是否存在一个 $n$ 维向量 $x = (x_1, x_2, dots, x_n)$，其中每个变量 $x_i in {0, 1}$，使得满足所有的线性不等式约束：$A x lt.eq b$)
    - Clique (最大团问题：在无向图中是否存在一个规模至少为 $K$ 的团？)
      - Set Packing (集合包装问题：给定一个有限集合U及其子集列表，此列表中是否存在k个两两不相交的子集？)
      - Vertex Cover (顶点覆盖问题：给定一个N个点，M条边的无向图G（点的编号从1至N），是否存在一个不超过k个点的集合S，使得G中的每条边都至少有一个点在集合S中？)
        - Set Covering (集合覆盖问题：给定全集U及其子集构成的集合S，是否存在一个S的子集C，使得C的阶不超过k且C中集合的并集等于U？)
        - Feedback Node Set (反馈点集：在有向图中找出最小的点集，移除后使图变为无环图)
        - Feedback Arc Set (反馈弧集：在有向图中找出最小的边集，移除后使图变为无环图)
        - Directed Hamilton Circuit (有向哈密顿回路：在有向图中寻找一条经过每个顶点恰好一次的闭合回路)
        - Undirected HC (无向哈密顿回路：在无向图中寻找一条经过每个顶点恰好一次的闭合回路)
    - 3-SAT
      - Chromatic Number (图着色问题：为图的节点上色，使相邻节点颜色不同所需的最少颜色数)
        - Clique Cover (团覆盖问题：将图的所有节点划分为最少数量的团)
        - Exact Cover (精确覆盖问题：在给定的子集里是否存在原集合的一个划分)
          - Hitting Set (撞击集问题：寻找最小的元素集合，使其与已知的所有集合都有交集)
          - Steiner Tree (斯坦纳树问题：在图中用最小总边权连接指定的若干关键节点)
          - 3-Dimensional Matching (三维匹配问题：在三类不同元素的组合中，寻找最大规模的互不重叠的三元组集合)
          - Knapsack (背包问题：在限定的总重量内，选择物品使得总价值最大)
            - Job Sequencing (作业排序问题：在有期限和惩罚的条件下，安排任务处理顺序以最小化惩罚)
            - Partition (划分问题：判定是否能将一组数分成两部分，使得两部分的和相等)
              - Max Cut (最大剪切问题：将图的节点分成两部分，使得跨越两部分的边数最多)
]
#proof[
  1. SAT $lt.slant_K$ 0-1 Integer Programming. 
      - 对于 SAT 实例中的每一个布尔变量 $X_i$，在整数规划中创建一个对应的二进制变量 $x_i in {0, 1}$。如果 $X_i$ 为真，对应 $x_i = 1$。如果 $X_i$ 为假，对应 $x_i = 0$。
      - $X_i$转化为$x_i$。$not X_i$ 转化为$(1 - x_i)$。
      - 子句（Clause）转化SAT 要求公式中的每一个子句都必须为真;一个子句只要其中有一个文字为真即可满足。
      - 例如 $X_1 or not X_2 or X_3$转化为如下不等式：$x_1 + (1 - x_2) + x_3 gt.eq 1$。因为每个变量只能是 0 或 1，要让各项之和 $gt.eq 1$，则至少有一个变量（或其否定）必须等于 1，完美模拟了逻辑“或” ($or$) 的含义。
      - 如果原 SAT 公式 $S$ 有 $m$ 个子句，我们就会得到 $m$ 个线性不等式。SAT 是可满足的 这组 0-1 不等式组有可行解。

      $forall S in "SAT"$,S有m个子句,n个元素.$bold(A)$是n行m列的矩阵,$A_(i j)$表示第i个元素在第j个字句有没有出现,$bold(x)$是S的指派,取$bold(b) = bold(0)$.$bold(A bold(x)) = bold(b)$,这就是一个规约.
    #line()
  2. SAT $lt.slant_K$ Clique. $forall S in "SAT"$,S有m个子句,n个元素($x,not x$视为不同的元素).
    $ G = angle.l V,E angle.r,V eq.delta {x_1, x_2, ... , x_n| x_i in S},E eq.delta {(x_i, x_j) | x_i,x_j "不在一个子句中且不矛盾"} $

    如果这 $m$ 个点两两都有边（即"团"），就意味着：
    - 它们来自 $m$ 个不同的子句（涵盖了所有子句）。
    - 它们彼此不冲突、不相关（这些文字可以同时为 True，而不会导致逻辑上的自相矛盾）。
    #line()
  3. Clique $lt.slant_K$ Set Packing. $forall G = angle.l V,E angle.r in "Clique"$,$cal(U) = overline(E)$，$S_v eq.delta {e in cal(U) | v in e}$，则原先构成团的点定义的$S_v$是两两不相交的。#line()
  4. Clique $lt.slant_K$ Vertex Cover.$G = angle.l V,E angle.r$有一个大小为$k$的团$S$，补图就有一个大小为$k$的独立集$S$(一组点两两之间都没有边)，则$overline(G)$的所有边全部落在$V\/ S$之中。#line()
  5. Vertex Cover $lt.slant_K$ Set Covering.$forall G = angle.l V,E angle.r in "Vertex Cover"$，$cal(U) = E,S_v eq.delta {e in cal(U) | v in e}$，即直接选择Vertex Cover问题中那些能覆盖所有边的点即可。#line()
  6. Vertex Cover $lt.slant_K$ Feedback Node Set.$forall G = angle.l V,E angle.r in "Vertex Cover"$,把E里的无向边化成2个有向边.$forall angle.l u,v angle.r in E,angle.l u-> v angle.r ,angle.l v -> u angle.r in E'$#line()
  7. Vertex Cover $lt.slant_K$ Feedback Arc Set.把点拆成两个,构造环.并且视图诱导它删边只删掉拆分点出来的那个边.$ forall G = angle.l V,E angle.r in "Vertex Cover", forall v in V ,{v_1,v_2} in V' ; $
  $ forall angle.l u,v angle.r in E,angle.l u_1 -> u_2 -> v_1 ->v_2 -> u_1 angle.r in E' $#line()
  1. 3SAT $lt.slant_K$ Directed Hamilton Circuit.#link("https://blog.csdn.net/weixin_58140705/article/details/137030103")
  2. 3-SAT $lt.slant_K$ Chromatic Number.这太难了.#link("https://blog.csdn.net/devout_/article/details/130201864")
  3.  Chromatic Number $lt.slant_K$ Clique Cover.每个同一个颜色的点,取补图之后就是一个团.
  4.  Chromatic Number $lt.slant_K$ Exact Cover.注意,在规约的时候,我们可以任意*捏造一个集合$S$*,然后再给出划分.放过我吧,我不会
  5.  Exact Cover $lt.slant_K$ Hitting Set.$X ={x_1,dots,x_n},cal(S) = {S_1,dots,S_m},U eq.delta {s_1,dots,s_m},C_i eq.delta{s_j | x_i in S_j},cal(C) = {C_i}.$其中s和S对应.#line()
  6.  Hitting Set $lt.slant_K$ Steiner Tree.我觉得后面不会考

]
