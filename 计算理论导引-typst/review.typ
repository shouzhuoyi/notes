#set page(paper: "a4", margin: 3em)
#import "@preview/dvdtyp:1.0.1"
#import "@preview/numbly:0.1.0": numbly
#import "@preview/thmbox:0.3.0": *
#import "@preview/cuti:0.2.1": show-cn-fakebold
#import "@preview/dvdtyp:1.0.1": *
#show: dvdtyp.with(
  title: "Review",
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

= 证明题
#problem[
  非确定图灵机解决一个问题的具体时间怎么估计?
]
#solution([
  一个非确定图灵机要决策的时候是同时分裂出很多个不同路径的决策.我们把这个决策树的*深度*
  而不是总*节点数*当作时间函数.

  这也侧面地印证了非确定图灵机不是可以被造出来的.
])

#problem[
  UC问题:
  $ "UC"(alpha) = cases(delim: "{", 0","& "if " MM_alpha (alpha) = 1, 1 ","& upright("otherwise"),) $
  停机问题：
  $
    "HALT"(alpha , x) = cases(delim: "{", 1"," & upright("if ") MM_alpha (x) arrow.b, 0"," & upright("otherwise"),)
  $
  它们都不能被判定.
]
#solution[
  如果你不知道,*$MM_alpha$的意思是图灵机的顺序编码里编码为$alpha$的那个图灵机.如果一个图灵机有两个输入,第一个输入是通用图灵机模拟的编码的那个图灵机.*
  1. 若存在$CC$判定$"UC"$,那么,记$alpha$是$CC$的二进制编码,$CC(alpha) = 0 <==> CC(alpha) = 1$.换言之,若能判定,根据问题定义,应该输出0;如果不能判定,则根据问题定义,输出1.两者矛盾.
  2. 如果存在$CC$判定$"HALT"$,那么,记$alpha$是$CC$的二进制编码,我们能给出停机问题的解法:$CC_alpha (alpha) = 1 and CC_alpha (alpha) ↓$的时候输出0,其他情况输出1.这也是个矛盾.
]

#problem[
  设图灵机$MM$在$T(n)$步内判定$L$.对任意$epsilon>0$,有图灵机$MM'$,$MM'$能在$epsilon T(n)+n+2$步内判定$L$.
]
#solution[
  我们来构造这个$MM'$.
  - $MM'$的符号集$Gamma' supset.eq Gamma^m$,并且在$n+2$步内把原来的符号压缩$m$倍.其中n是线性扫描时间,2指的是从$triangle.r,square$浪费的两步.
  - $MM'$的读写头回正,需要$n/m$步.
  - $MM'$的读写头模拟m步操作,至多需要5步.(读写头务必读当前格子和左右两边的$3m$个符号来确定m步操作的那m个格子在哪)
  - 则$ T'(n) lt.eq.slant n+2 + n/m + 5/m T(n) lt.eq.slant n+2 +6/m T(n) $
  - 我们取$m = 6/ epsilon$即可.
    #line()
    注意一个推论:$T(n)>>n$时可以忽略掉$n+2$(等价无穷小即可)
]

#problem[
  若函数 $f , g$ 是时间可构造的,而且 $f (n + 1) = o (g (n))$,则 $bold(upright(N T I M E)) (f (n)) subset.neq bold(upright(N T I M E)) (g (n))$.

]
#solution[
  我们来设计一个精致的图灵机$ZZ$来证明这个命题.
  + 首先,$ZZ$的输入读写头和第一条工作带读写头往右扫描.
    - 若输入不形如$1^n and n > 1$,直接停机并输出0.
    - *第一条工作带*上第一个位置写1,然后随机写0和1.我们记${h_i}$为工作带上写1的位置序列.
  + *第二条工作带*上,$ZZ$直接模拟那些所有非确定图灵机和$TT_(2f(n))$的硬连接.不妨设这些图灵机为${LL_i}$.$ZZ$模拟完${LL_i}$之后,需要做如下操作来接着模拟${LL_(i+1)}$:
    - 暂停第1步的操作;
    - 在*第三条工作带*上构造$1^(h_(i-1)+1)$.这是因为我们假定第三条工作带上保留着$1^(h_(i-2)+1)$,我们只需要再写$h_(i-1) - h_(i-2)$个1.这里额外开销的时间是$O(h_i)$是线性的;
    - 把$LL_(i-1)$的编码复制到第三条工作带上.这也是线性时间的;
    - 恢复第一步时候的读写头;
    - 恢复输入带和第一条工作带读写头的同步全速向右扫描.与此同时,$ZZ$用暴力法计算$LL_(i-1)(1^(h_(i-1)+1))$.计算完后,$ZZ$将结果写在第二条工作带上,与此同时,在第一条工作带上写1,这个写了1 的格子的地址就是$h_i$.
  + 当输入带结束扫描之后,做如下操作:
    - 若$n = h_i$,$ZZ$接受$1^n <==>$$LL_(i-1)(1^(h_(i-1)+1)) = 0$;
    - 否则, $ZZ$非确定的让$VV(LL_(i-1), 1^(n+1))$计算$g(n)$步.

  #line()

  设$L$是$ZZ$接受的语言,来考察一下时间复杂度.关键性的是$VV(LL_(i-1), 1^(n+1))$的计算开销,不难看出其余步骤全是线性的;所以$L in bold(upright(T I M E)) (g(n))$.

  另一方面,用*反证法*证明$L in.not bold(upright(T I M E)) (f(n))$.
  假设 $L in bold(upright(N T I M E)) (f(n))$,且有$NN_i$能判定.由线性加速定理,我们假定时间函数是$2f(n)$.根据定义,$LL_i$接受$L$,那么当$i$充分大的时候,我们有
  $
    LL_i (1^(h_i + 1)) & = ZZ(1^(h_i + 1)) \
                       & = LL_i (1^(h_i + 2)) \
                       & = ZZ(1^(h_i + 2)) \
                       & = dots.c \
                       & = LL_i (1^(h_(i + 1))) \
                       & = ZZ(1^(h_(i + 1))) \
                       & ≠ LL_i (1^(h_i + 1))
  $
  这一矛盾说明结论成立.
]

这真的会考吗?
#let np() = $bold("NP")$
#let nl() = $bold("NL")$
#let p() = $bold("P")$


#problem[
  `PATH` 是#nl()-complete的.
]
#solution([
  1. `PATH` $in #nl()$.dfs并猜测邻居.只需维护一个计数器,说明猜的这条路有几个点;每次从当前结点出发,猜一个邻居.
  2. $forall L in #nl(), exists f: L |-> "PATH"$.$forall x in L ,$考虑格局图$G(NN,x)$.$f(x)eq.delta angle.l G(NN,x),C_"start",C_"accept" angle.r$,并且定义初始格局为s,终止格局为t.

])

#problem[
  对数空间归约$lt.slant_L$的传递性.
]
#solution([
  我们设$B,C,D$是语言,$B lt.slant_L C, C lt.slant_L D$,映射分别是$f,g. quad h eq.delta g circle.tiny f.$

  当图灵机在模拟h的时候,维护一个对数长度的位置$"pos" = O(log(n))$.当模拟$h$的时候,这个pos表示$g$的读写头到哪里了.每一次模拟的时候,对这个pos,根据隐式对数空间可计算的定义,我们可以在$t = O(log(n))$里找到$f$的第pos位.总的开销是$"pos"+t = O(log(n))$.

  输入显然是多项式长度的,然后查找第i位和判定是不是1也能在对数空间内完成(参考上述描述).所以h是隐式对数空间可计算的.
])

#problem[
  证明:$L subset.eq {0,1}^star, L in #np()$等价于:

  $exists p :NN |-> NN, MM$是多项式时间的*图灵机*,且$forall x in {0,1}^star,$ 下述等价关系成立：$ x in L <==> exists u in {0,1}^(p(abs(x))) and MM(x, u) = 1 $.
]
#solution([
  1. *$==>$.* 这就是通用图灵机模拟非确定图灵机.Formally,设$NN$判定$L, p eq.delta T(n)*c$,c是一个转移函数$delta$编码成二进制所需的字符串长度.

    对L里的问题,$exists u in {0,1}^(p(abs(x)))$,且$u$是那个非确定图灵机的正确的计算路径的迁移函数编码.对这个串,有一个通用图灵机对他模拟计算,如果计算结果是接受,那么$x$在$L$里.反之就不在.
  2. *$<==$.* 一个非确定图灵机$NN$可以再多项式时间内猜一个$p(n)$长度的字符串$u$,然后模拟我们已经知道的那个通用图灵机的计算,如果计算结果是接受,那么$x$在$L$里.反之就不在.

])

= 名词解释
#definition[
  解释空间可构造、完全空间可构造、时间可构造、隐式对数空间可计算、图灵机的基本概念.
]
#solution[
  1. 如果$S : NN --> NN , S(n) gt.eq.slant log(n)$,我们称,
    + $S$空间可构造 $<==> exists MM$,它在$O(S(n))$空间内把$1^n$转成$⌞S(n)⌟$；类似定义
    + $S$完全空间可构造$<==>$在上述过程中,$MM$刚好使用$S(n)$空间.

  #line()
  2. 一个函数 $T : bb(N) arrow.r bb(N)$（且 $T (n) gt.eq n$）被称为是时间可构造的,如果存在一台图灵机 $M$,它能在 $O (T (n))$ 时间内计算并输出 $T (n)$ 的二进制表示（即计算函数 $1^n arrow.r.bar ⌊ T (n) ⌋$）.
    #line()
    一个函数 $T : bb(N) arrow.r bb(N)$（且 $T (n) gt.eq n$）被称为是 完全时间可构造的（Fully Time Constructible）,如果存在一台图灵机 $M$,它在接收输入 $1^n$ 后,会在#strong[恰好] $T (n)$ 步后停机.

  #line()
  3. 称$f:{0,1}^* arrow.r {0,1}^*$是*对数空间可计算的*,iff,$MM_f$使用了工作带上的对数个格子,并且他的输出带是只写的:也就是说,输出带的读写头每写一次都必须往右移一位.
    #line()
    称$f$为*隐式对数空间可计算的*,如果他满足:
    1. $exists c, forall x ,abs(f(x)) lt.slant c abs(x)^c$
    2. ${(x,i) | i lt.slant abs(f(x))} in bold(L)$
    3. ${(x,i) | abs(f(x)_i) = 1} in bold(L)$
  #line()
  4. 一台 k-带*图灵机* $MM$ 是一个*三元组* $(Gamma , Q , delta)$ ,其中:
    + 有限符号集 $Gamma$ , s.t. $Gamma supset.eq { 0 , 1 , square , gt.tri }$;
    + 有限状态集 $Q$, s.t. $Q supset.eq { q_(s t a r t) , q_(h a l t) }$;
    + 迁移函数 $delta : Q times Gamma^k arrow.r Q times Gamma^(k-1) times { L , S , R }^k$.

  $MM$的第一条带子是只读的输入带,剩下的都是工作带;最后一条带子是输出带.

]



