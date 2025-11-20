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
#outline()
//TODO:吧所有解读换成#denote[]
#show math.equation: it => {
  if it.body.fields().at("size", default: none) != "display" {
    return math.display(it)
  }
  it
}

= 时间复杂性 <计算理论>
== 引入
=== 图灵机
#definition("图灵机")[
  一台 k-带图灵机 $MM$ 是一个*三元组* $(Gamma , Q , delta)$ ,其中:
  + 有限符号集 $Gamma$ , s.t. $Gamma supset.eq { 0 , 1 , square , gt.tri }$;

  + 有限状态集 $Q$, s.t. $Q supset.eq { q_(s t a r t) , q_(h a l t) }$;

  + 迁移函数 $delta : Q times Gamma^k arrow.r Q times Gamma^(k-1) times { L , S , R }^k$.
  
  $MM$的第一条带子是只读的输入带,剩下的都是工作带;最后一条带子是输出带.

]
#quote(attribution: "Turing, A. M.",block: true)[
This course is about _classifying and comparing_ problems by the amount of resource
necessary to solve them.
]
#denote[
  + 有限状态集$Q$ 是机器所有可能"心理状态"的集合，比如"正在读输入""正在计算""准备输出"等。
    - 必须包含:$q_(s t a r t)$开始状态，机器一启动就处于这个状态；$q_(h a l t)$停机状态，一旦进入这个状态，机器就停止运行，不再执行任何操作。\
    - 你可以在$Gamma,Q$中自己定义别的奇妙的符号,但必须包含以上特别指出的符号.

  + 迁移函数输入:当前状态 + k 个读写头各自看到的符号(每条带子一个符号，共 k 个)输出:
    - 下一个状态(Q 中的一个);
    - 要写到每条带子当前格子的新符号（k 个符号 → $Γ_k$);
    - 每个读写头下一步怎么移动：$L , S , R$ 分别表示读写头向左、右或者保持不动.
]



#example()[
  图灵机的初始化:

+ $gt.tri$ 在每条带子的最左端 ;

+ 所有工作带的格子里都放空符号 $square.stroked$;

+ 输入带除了输入之外的地方也是空符号.
]

我们自然的会把 $(q , a_1 , dots.h , a_k) arrow.r^delta (q ' , a'_(bold(2)) , dots.h , a'_k , A_1 , dots.h , A_k)$ 称为一条*指令*. 其中 $A_i in { L , S , R }$ 即一条移动;根据定义,$a_1$ 不需要修改,因为是只读的.

=== 格局
下面来看#strong[格局];.

#definition("格局")[
$MM (x)$ 表示预制输入 $x$。计算的任意时刻 $t$ 的*格局* $sigma_t = (q , kappa_2 , dots.h , kappa_k , h_1 , dots.h , h_k)$ 是一个 $2 k$ 元组,其中 $kappa_i$ 是工作带内容,$h_i in bb(N)$ 是读写头位置.

初始格局:$(q_("start"),epsilon,epsilon,dots.c,epsilon,0,0,dots.c,0)$

种植格局:$(q_("halt"),kappa_2 , dots.h , kappa_k , h_1 , dots.h , h_k)$,只要求$q_("halt")$.

]
解读:\ 
1. $t$时刻的格局能反映这一时刻的图灵机状态,包含当前状态$q$,$2~k$条纸带的状态$kappa_2~kappa_k$,每条纸带上读写头的位置$h_i$.\
2. 初始格局是唯一的. 如果达到了终止格局,格局之间的传递被称为#strong[计算路径];,详见P6.\
3. 时间函数记作 $T (n)$, $n = lr(|x|)$.$T(n)gt.eq.slant n$,这是因为我们假定图灵机必须先完整的读一遍输入.
4. 可以用“快照”来理解“格局”，但“快照”在后面的部分仍有定义，不要混淆。

=== 问题与语言
#definition("问题与语言")[
  1. 一个函数 $f : { 0 , 1 }^* arrow.r { 0 , 1 }^(\*)$ 被称为一个*问题*. \

  - 如果对每个 $x in { 0 , 1 }^(\*)$，图灵机 $MM$ 满足 $M (x) = f (x)$，则称 M*计算*或*求解*函数 $f$.

  - "$M (x) = y$"表示"图灵机 $MM$ 在输入带预装 $x$ 的情况下停机，且输出带上写有 $y$".

  2. 一个函数 $d : { 0 , 1 }^(\*) arrow.r { 0 , 1 }$ 被称为一个*判定问题*. \

  - 如果图灵机 M 计算 $d$，则称 M*判定*$d$.

  一个集合 $L subset.eq { 0 , 1 }^(\*)$ 被称为一个*语言*. 其中 $L^(\*)$ 表示 L 中元素的有限串集合. \

  - 如果图灵机 M 判定如下特征函数： $ L (x) = cases(
      delim: "{", 1","   & upright("如果") x in L, , 0","   & upright("如果") x in.not L,

    ) $ 那么称 $MM$ 接受语言 L, 或者 L 是可判定的.
  - 一个判定问题 $A subset.eq { 0 , 1 }^(\*)$ 的补问题 $A^(‾)$ 定义为 ${ 0 , 1 }^(\*) \\ A$.

]

解读: 问题就是函数,函数就是问题.
参考书例子: 回文串 (朴素, P8).

一个问题是#strong[图灵机可解的] $arrow.l.r.double$ 有一台图灵机计算它.


#theorem("思考题")[
为以下函数设计图灵机:

  + $s (x) = x + 1$. 用进位处理实现计数器.

  + $u (x) = 1^x$. 附加 $1^x$ 限制运行步数.

  + $e (x) = 2^x$. 输出 $2^x$.

  + $l (x) = log x$. 若 $x = 2^k$,输出$lr(|x|) + 1$,否则输出$lr(|x|)$.

  #proof[
    + $s (a) = + 1$。先找到串的末尾，然后做如下操作：

      + 如果当前位是 1，将其翻转为 0，然后向左移动一位；

      + 如果当前位是 0，将其翻转为 1，然后停机；

      + 如果是 $gt.tri$，改写为 1，然后停机。

    + $u (a) = 1^n = underbrace(11 dots.h.c 11, n upright("个") 1)$。对输入端做减法，然后减 1 个就输出一个 1。

    + $e (a) = 2^n$。用第二条给出 $1^n$，然后对这个一元串，读的第一个写 1，读的后续所有都写 0。

    + $l (a) = log (a)$。先判断 $x$ 的二进制有几位，有几位就输出几个 1，成为串 $L$；然后判断 $x$ 是不是 $2$ 的幂次，如果第一个是 1 就往右挪，如果碰到了另一个 1 就是 N，否则是 Y；最后，如果是 Y 就在 $L$ 后补一个 1，如果是 N 就不做，最后，把 $L$ 变成二元串。
  ]
]
== 时间可构造性 <时间可构造性>
#definition("时间可构造性")[
  一个函数 $T : bb(N) arrow.r bb(N)$（且 $T (n) gt.eq n$）被称为是 时间可构造的（Time Constructible）。

  - 如果存在一台图灵机 $M$，它能在 $O (T (n))$ 时间内计算并输出 $T (n)$ 的二进制表示（即计算函数 $1^n arrow.r.bar ⌊ T (n) ⌋$）。

  一个函数 $T : bb(N) arrow.r bb(N)$（且 $T (n) gt.eq n$）被称为是 完全时间可构造的（Fully Time Constructible）。

  - 如果存在一台图灵机 $M$，它在接收输入 $1^n$ 后，会在#strong[恰好] $T (n)$ 步后停机。

]
解读:时间可构造性是指,$T(n)$本身可以被一个图灵机在接收$1^n$(表示n这个数)的输入后,在有限步($O(T(n))$)内,输出$n$的二进制表示.\

若在图灵机里面加入一个不停向右移动一格、到达规定位置后停机的条带,就得到了一个#strong[时钟图灵机] $bb(T)$作为计时器,用以限制另一台图灵机($MM$)的运行时间,强制它在指定步数内停止.
#definition("硬连接")[
我们可以构造一台新的图灵机 $MM'$，它(利用时间函数是$T(n)$的时钟图灵机$TT$)通过以下方式为 $MM$ 的计算强制设定一个时间上限：

  + 在输入 $x$ 上，$MM'$ 首先计算出步数上限 $k = T (lr(|x|))$。（由于 $T$ 是时间可构造的，此步骤可在 $O (T (lr(|x|)))$ 时间内完成）。

  + $MM'$ 模拟 $MM$ 在输入 $x$ 上的运行，最多 $k$ 步。

  + 如果 $M$ 在 $k$ 步内停机，$M'$ 就停机并返回 $M$ 的结果。如果 $M$ 在 $k$ 步内没有停机，$M'$ 会强制停机并进入#strong[拒绝状态];。
  具体的构造如下:
  $
  MM = (Q_0,Gamma_0,delta_0) ,TT = (Q_1,Gamma_1,delta_1),MM' = (Q,Gamma,delta)\
  Q= Q_0 times Q_1,"assuming" (q,q_"halt"^1) =(q_"halt"^0,q) =  q_"halt"\
  Gamma = Gamma_0 times Gamma_1\
  delta = delta_0 times delta_1   

  $

]
解读:
构造一台集成的图灵机$MM'$,前$k_0$条给$MM$用,后$k_1$条给$TT$用,用笛卡尔积来定义$MM'$的状态.新机器的停机条件为:$MM$和$TT$其中有任何一台停机.

一个图灵机被称为#strong[神游的];，如果读写头的逻辑是确定的。

== 通用图灵机
#definition("通用图灵机")[
  + 一个转移规则 $(p , a , b , c) arrow.r (q , d , e , R , S , L)$ 可以被编码为，比如说： $ 001 dagger 1010 dagger 1100 dagger 0000 dagger dagger 011 dagger 1111 dagger 0000 dagger 01 dagger 00 dagger 10 $,$dagger$是不同字符之间的分隔符,$dagger dagger$表示状态编码和转移方向之间的间隔.

  + 一个转移表可以被编码为一个具有如下形式的字符串： $ dagger.double angle.l upright(r u l e)_1 angle.r dagger.double angle.l upright(r u l e)_2 angle.r dots.h.c dagger.double angle.l upright(r u l e)_m angle.r dagger.double $

  其中，二进制表示可以通过以下映射获得： 
  $ 0             & arrow.r 01 ,\
  1             & arrow.r 10 ,\
  dagger        & arrow.r 00 ,\
  dagger.double & arrow.r 11 . $

]
解读:\
就像程序可以作为数据被另一个程序读取和执行，这一部分的目标是：把一台图灵机的所有信息（状态、符号、转移规则）压缩成一个二进制字符串，这样它就可以被其他图灵机读取和模拟。 \
编码的一些性质:
  - 每一台图灵机都可以表示为01编码的字符串,且编码是无限的,因为$0^i sigma 0^j <==> sigma$;
  - $forall Sigma in {0,1}^*$,它都代表着一个图灵机.(即使有一些无意义的串,也将其强行联系某个垃圾图灵机.比如$0^(n)$根本编码不出$dagger.double$,所以他是*非法的*;基于此,我们把所有的非法串映射到一个特定的$MM_(0)$)


\


我们可以接着考察图灵机的枚举.根据上面的假定,我们可以建立一个双射$f:{0,1}^* --> cal("TM"),cal(T M)$是所有图灵机构成的集合.我们把它称作对图灵机的枚举.

用$ phi(x) eq.delta 
cases(
  y"," quad &MM_i(x)=y\    
  arrow.t "," quad &MM_i(x) arrow.t
)
$来编码可计算的图灵机.



#theorem("枚举定理,以及更多")[
  存在一个通用图灵机 $cal(U)$，它使以下陈述为真：

  + 对于所有的 $x , alpha in { 0 , 1 }^(\*)$，有 $cal(U) (x , alpha) tilde.eq M_alpha (x)$。 等价关系的定义是,要么他们都停机且输出相同,要么他们都在运行.
  + 如果 $M_alpha (x)$ 在 $T (lr(|x|))$ 步内停机，那么 $cal(U) (x , alpha)$ 在 $c T (lr(|x|)) log T (lr(|x|))$ 步内停机，其中 $c$ 是一个关于 $alpha$ 的多项式。
  - 具有 $cal(O) (T (n))$ 时间放大的版本出现于 1965 年。

  - 当前版本发表于 1966 年。
]
解读：存在一台通用图灵机，它可以模拟任何一台图灵机。这是说：对于任意的输入，上述两台图灵机的行为完全等价（产生的输出完全相同或者同时永不停机）；代价是一点额外的时间。

#proof[
    我们来构造一个满足的图灵机。完整的证明在 P13-15，给出思路如下：

    + 我们先把 $U$ 的主工作带分成 $k$ 层，用一条工作带虚拟的模拟 $k$ 条带(用存 $k$ 元组的方法来解决);我们把0处的位置记作读写头读取的东西,然后我们把读写头的移动模拟为带子的反向移动.

    + 存放冗余信息（用 $times$ 表示），把主工作带划分为以 $2^i$ 为长度的多个区间，如图所示；
      #figure(image("1.png", width: 100%), caption: [
        证明图
      ])
    + 填充的规则如下：$L_i , R_i$ 上填充的有效信息加起来是 $2^(i + 1)$，且单个是只有满、半满、空 3 种状态。填充这个需要时间复杂度 $O (T log T)$。

    + 来考察移动。只考虑左移。找到 $i$，s.t. $R_0 , dots.h , R_(i - 1)$ 全空，然后把 $R_i$ 中的 $2_i$ 个元素把前面 $i - 1$ 个全部填充成半满，同时替换 0 层；然后，原有的 $L_(i - 1)$ 中的有效信息填入 $L_i$ 中，以此类推。图见上。我们可以通过$cal(U)$的第二条工作带来复制碰到的第一个非冗余信息,然后在区间大小的线性时间内完成复制工作.这里的时间复杂度是 
   $
    sum_(i = 0)^lr(log T(n)) (2^i dot.c T(lr(|x|)) / 2^i) = O (T (n)) dot.c log (T(n)).
   $

   只需证明 $k lt.eq c (x)$。由于 $k lt.eq lr(|x|)$，这是显然的.
  ]

解读：
- 我们还是要用01串来编码符号集合.
- In other words, once a shift with index $i$ is performed, the next $2^i -1$ shifts of that parallel tape only involves indexes less than $i$. yyl补全这些
- 这句话说明了,调整一次后,调整的内容里面垃圾是足够多的,我们的下面的操作不需要太复杂,因为有足够多的垃圾等我们搬空.这种设计方式大大减少了复杂性.




我们称一个图灵机是#strong[健忘的];，如果在计算的时刻我们不考察输入了什么，而是考察输入的长度和操作了多少步。//@thm:enumeration可以被推广。

修改 $U$ 的定义：预先将所有 $L_i , R_i$ 区间半满，然后引入计数器模拟步数。如果第 $i$ 位从 0 变成 1，扫描 $0$-$i$ 的区间，把 $L_j , R_j$, $j in { 0 , 1 , 2 , dots.h , i - 1 }$ 置为半满。这样，他就是健忘的，那我们有如下推论：

#proposition("健忘图灵机")[
  一些推论thm:consequences 设 $L$ 可在 $T (n)$ 时间内被图灵机判定，那么，$exists C T (n) log T (n)$ 时间内可判定 $L$ 的健忘图灵机，其中 $C$ 是常数。

  设 $f in sans(T I M E) (T(n))$，有双读写带的图灵机在 $O (T (n) log T (n))$ 时间内计算 $f$，有单读写带的图灵机在 $O (T (n^2))$ 时间内计算 $f$。

]
== 对角线方法 <对角线方法>
不存在一段程序(图灵机)，使得其能够计算所有函数。可以使用对角线法以及通用图灵机构造出这样的反例。
我们的目标是找到一个无法被图灵机计算的函数。

#problem(" decidable")[
  UC问题:
  $ cal(U C) (alpha) = cases(
    delim: "{", 0","& "if " MM_alpha (alpha) = 1, 1 ","& upright("otherwise"),

  ) $
停机问题：
  $ cal(H a l t) (alpha , x) = cases(
    delim: "{", 1","   & upright("if ") MM_alpha (x) arrow.b, 0","   & upright("otherwise"),

  ) $
它们都不能被判定。
]
#proof[
  
1.$cal(U C)$需要循环嵌套.假定$UU CC$可以判定$cal(U C)$,那么,
$
UU CC(⌞UU CC ⌟) =0 <==> UU CC(⌞UU CC ⌟) =1
$
(直接代入UC的定义就可以得到这里的等价关系,从而导出了矛盾).
(张小皓提出了这个反例在互换$UU CC$里0和1就失效了,但事实上两者都不可判定.)

//用\llcorner 和 \lrcorner
2.利用反证，假设存在这样的 $MM_(H)$，那么我们给出可以判断 $cal(U C)$命题的图灵机的构造：

$ MM_(H) (alpha) = cases(
  delim: "{", 0","   & MM_(H) (alpha , alpha) = 1 and MM_alpha (alpha) = 1, 1","   & upright("otherwise"),

) $

这便给出了一个矛盾。
]

解读:
1.否定性命题的一般证明方法就是利用反证法,其中对角线方法给了很好的例子.

== 加速定理 <加速定理>
加速定理的动机在于思考:对于一个问题,有没有最好的算法解决它?
我们现在知道,结论否定(*Blum’s Speedup Theorem*).为了证明他,我们不证明他.转而看向线性加速定理.
#theorem("Linear Speedup(线性加速定理)")[
  设图灵机$MM$在$T(n)$步内判定$L$。对任意$epsilon>0$,有
在图灵机$MM'$，$MM'$能在$epsilon T(n)+n+2$步内判定$L$.
]
#proof[
  我们来构造这个$MM'$.
  - $MM'$的符号集$Gamma' supset.eq Gamma^m$,并且在$n+2$步内把原来的符号压缩$m$倍.其中2指的是从$triangle.r,☐$浪费的两步.
  - $MM'$的读写头回正,需要$n/m$步.
  - $MM'$的读写头模拟m步操作,至多需要5步.
  - 则$ T'(n) lt.eq.slant n+2 + n/m + 5/m T(n) lt.eq.slant n+2 +6/m T(n) $
  - 我们取$m = 6/ epsilon$即可.
]

解读:

1.你总能把原来的运行时间压缩到任意小的比例($epsilon$很小)，只需要再加一点“启动开销”$(n+2)$。
核心思想是：让新机器 $MM'$ 一次“看多格”，而不是像老机器 $MM$ 那样一格一格慢慢挪。

2.$MM'$需要：
- 读取当前“超级格子”的内容（包含 $m$ 个原始字符）→ 1 步
- 根据 $MM$ 的状态和当前字符，查表决定下一步动作 → 1 步
- 修改“超级格子”中的某个字符（如果需要）→ 1 步
- 决定读写头往左/右移动：
- 如果向右移出当前“超级格子”，就要跳到下一个“超级格子”，并调整内部位置 → 1 步；如果向左移出当前“超级格子”，同理 → 1 步
- 更新状态 → 1 步
所以，最多需要 5 步 来完成一次“模拟 $m$ 步中的一步”的操作。

当$T(n) >> n$我们有一个类似小o的思想:
#proposition()[
  设图灵机$MM$在$T(n)>>n$步内判定$L$.(或者我们记作,$T(n)= omega(n)$)对任意$epsilon>0$,有
在图灵机$MM'$，$MM'$能在$epsilon T(n)$步内判定$L$.(这就是说，线性项被忽略了。)
]<linearspeedup>
证明见作业$section 2.4$.

== 时间复杂性类 <时间复杂性类>

#definition("时间复杂性类")[
  A decision problem $L ⊆ {0, 1}^*$ is in $bold("TIME")(T(n))$, if there exists a $TT MM$ that accepts L
and runs in time $c T(n)$ for some $c gt 0$.
]
解读：\
$bold("TIME")(T(n))$是一个集合：所有能在$T(n)$时间内被图灵机解决的问题的集合.\



基于线性加速定理,我们不能定义问题的复杂性类,只能定义解决问题的时间的复杂性类.

我们先提出了 $upright(bold(P))$。一个*复杂性类*是一个模型无关的问题类.
我们把所有具有多项式时间算法的问题认为是同一类，即令
 $ upright(bold(P)) = union.big_(c gt.eq 1) bold("TIME") (n^c) $
以及
 $ upright(bold(E X P)) = union.big_(c gt.eq 1) bold("TIME") (2^n^c) $


然后我们提出了一个"明显的定理"（证明他！）。

#theorem("时间复杂性类")[
  我们称 $upright(bold(c o T)) = {dash.en(A) divides A in bold("T") }$,$bold(T)$是一个时间复杂性类.$upright(bold(c o T)) subset.eq bold("T") arrow.l.r.double upright(bold(c o T)) supset.eq bold("T") arrow.l.r.double upright(bold(c o T)) = bold("T")$

]
#proof[
  有人托梦给我证明了.——YYL

]
== 非确定图灵机 <非确定图灵机>
=== 非确定图灵机的定义及其时间定义
非确定图灵机的引入是为了解决*验证问题(Validation Problem)*.它不是物理上可实现的,但是他_很好玩_.

What nondeterminism provides is the power of *guessing*.

非确定图灵机 $NN$ 指的是有*两个*迁移函数的图灵机，它可以不确定地使用两者的策略之一。换言之，每一步可以有多个选择。从初始状态出发，其所有的可能路径会像二叉树不断向下延伸(类似《银河系漫游指南》的无尽概率跃迁方程/*你到底在说什么*/)，每条路径可能终止，也可能不停机。非确定并不是随机。

#definition("非确定图灵机的接受与拒绝，及其时间定义")[
1. 设非确定图灵机 $NN$，它的每条*计算路径*(也就是一个$delta_i,i in {0,1}$的序列)试图构造一个存在性证明。如果构造成功，输入 1 并称这个终止格局叫#strong[接受格局];；类似的定义#strong[拒绝格局];。当输入 $x$ 的时候，若 $N$ 有一条计算路径终止于接受格局，称 $NN$ *接受* $x$，并记作 $NN (x) = 1$；类似定义*拒绝*。

2. 对于每一个输入 $x$，以及每一个“非确定性选择序列”，机器 $NN$ 必须在 $T(|x|)$ 步内停机（到达 $q_h$）。

]

=== *$"P","NP","EXP","NEXP"$*问题

类似 $upright(bold(P))$，我们有 $upright(bold(N P)) , upright(bold(N E X P))$。有一个明显的结论（P27）

#theorem()[
   $ upright(bold(P)) subset.eq upright(bold(N P)) subset.eq upright(bold(E X P)) subset.eq upright(bold(N E X P)) . $

]
#proof[
  第一个和第三个包含关系很显然；中间的包含关系是说，非确定性图灵机（NTM）在多项式时间内能解决的问题，可以用确定性图灵机在指数时间内模拟出来。根据非确定性图灵机的定义，这也是可以理解的。
]

#line()

=== 快照
类似的考察通用性，我们给出#strong[快照];的定义：

#definition("快照")[
  一个 $k + 1$ 元组 $(q , a_1 , dots.h , a_k) subset.eq Q times Gamma times dots.h.c times Gamma$。它包含了读写头指向的符号，但是不包含读写头位置和剩余工作带的内容.
]
解读:
+ 基于一个给定的图灵机,快照的大小是恒定的,而不像格局的长度是$O(T(abs(x)))$.

=== 通用非确定图灵机
类似前文,我们可以定义一个"通用"的非确定图灵机$VV$.
+ 它猜测$NN_alpha (x)$的一个终止于接受格局的快照序列和一个同等长度的0-1串,后者表示$NN_alpha$在计算时做的非确定选择，即$delta_0,delta_1$的一个.猜测快照序列时，$VV$只考虑输入带上的符号，忽略工作带上的符号；工作带上的符号通过猜测得到.
+ $VV$需要多一条带来记录$NN_alpha$的实际读写过程.对每一条工作带,$VV$对之前猜测到的01串中的合法的快照带回去验证是否成功.注意,这个验证是逐带进行的.

解读:

1.$VV$的代价是它都不一定停机,因为我们没办法确定快照序列的长度,也不能确定它完全停机;有一个办法是利用时钟图灵机$TT$来强制让他停止.

2.

3. 验证的进行:首先,$NN$也需要写入操作数这一个过程,我们的快照也记录下了这个信息;读写头的移动被$delta_i$确定了;读的什么内容被快照决定了(这就是确定了读/写了什么内容).

<kuaizhao>
== 命题& 谓词逻辑 <命题-谓词逻辑>
关于命题和谓词逻辑的基本知识参考离散数学.来看在图灵机下的新的定义.

#definition[
 #strong[可满足性问题];是所有可满足的合取范式的集合,记作#strong[SAT];.k-合取范式中,每个语句最多含有$k$个字;这些合取范式的集合被记作`kSAT`.

]
#proposition()[
   $upright(bold(S A T)) in upright(bold(N P)) .$

  #proof[
    给定合取范式$phi.alt (x_1 , x_2 , dots.h.c , x_n)$,一个多项式时间的非确定图灵机可以猜测一个指派,然后验证之.
  ]
]
为了简化问题,我们规定谓词逻辑的个体域是布尔域${ 0 , 1 }$,并简写$exists x_1 exists x_2 dots.h.c exists x_k$为$exists x_1 x_2 dots.h.c x_k$(当然,$forall$也这么做).

#definition("QBF")[
 如下形式的前束范式被称为#strong[量化布尔公式];: $ Q_1 x^1 Q_2 x^2 dots.h.c Q_k x^n dot.op phi.alt (x^1 , dots.h.c x^n) $ 其中,$x^i$为#strong[一串变量];,$Q_i$为$forall , exists , forall , dots.h.c$或者$exists , forall , exists , dots.h.c$.

问题`QBF`是所有永真的量化布尔公式的集合.当然也有`kQBF`.

]
== 很多定理 <很多定理>
我们来讨论对不同的函数 $f , g$，$bold(upright(T I M E)) (f (n)) subset.eq bold(upright(T I M E))(g (n))$ 是严格的。我们给出三个定理。

#theorem("时间谱系定理")[
  若函数 $f , g$ 是时间可构造的，而且 $f (n) log f (n) = o (g (n))$，则 $bold(upright(T I M E)) (f (n)) subset.neq bold(upright(T I M E)) (g (n))$。

  
]
#proof()[(对角线方法)
   我们来证明一个否定命题 $bold(upright(T I M E)) (g (n)) subset.eq.not bold(upright(T I M E)) (f (n))$。
   
   构造反例$L$：输入 $x$，在$MM_x$计算$g(lr(|x|))$ 步；如果完成模拟，输出 $MM_x (x)$ 的反转，否则输出 0。由定义,$L in bold(upright(T I M E)) (g (n))$，且$DD$在时间$g (n)$判定$L$。
   
   接下来证明不存在图灵机$MM$，能够在$f(n)$时间内判定$L$。

  假定 $L in bold(upright(T I M E)) (f (n))$，且有$M_z (z)$能判定。

  我们取充分大的 $z$，由 1.3.2，我们知道 $g (lr(|z|)) gt.double f (lr(|z|)) log (lr(|z|))$，$DD$ 可以模拟完运算。因为两者都判定$L$，s$DD (z) = MM_z (z)$；同时，按照输出结果我们有 $DD (z) = overline(MM_z (z))$，这便是一个矛盾。

  ]

  解读:
  1.由于$g$时间可构造,所以$DD$可以用一个$TT_(g(n))$的时钟图灵机掐表来实现.也就是说,$ DD <-- TT_(g(n)) and lambda z . UU(z,z) $,$and$表示掐表.

  2.证明过程中的反证法看起来不那么显然,但是是基于一个直观的命题上的:$ bold(upright(T I M E)) (f (n)) subset bold(upright(T I M E))(g (n)) $

  3.我们*为什么*可以取这样的 $L in bold(upright(T I M E)) (f (n))$,$M_z (z)$ 判定之,并且这里的$z$还能充分大?其实,我们是这么做的:取这样的$z$,s.t.$MM_z$判定$L$的时间函数$T(n) lt.eq.slant C f(n)$.

  4.对角线方法的图例:
  #figure(image("diag.jpg",width: 80%),caption: [
    对角线的来源是用通用图灵机模拟一个图灵机的时候,在对角线的时候取反.
  ])
  #line()
初等函数类的定义是如下的： $ upright(E X P) = union.big_(c > 1) upright(T I M E) (2^(n^c)) $ $ upright(2 E X P) = union.big_(c > 1) upright(T I M E) (2^(2^(n^c))) $ $ upright(3 E X P) = union.big_(c > 1) upright(T I M E) (2^(2^(2^(n^c)))) $ $ dots.v $ $ upright(E L E M E N T A R Y) = upright(E X P) union upright(2 E X P) union upright(3 E X P) union dots.h $

非确定图灵机的谱系问题也有对应的定理和证明方法.这里的定理稍显奇怪(因为是$f(n+1)$).
#theorem("时间谱系定理")[
  若函数 $f , g$ 是时间可构造的，而且 $f (n + 1) = o (g (n))$，则 $bold(upright(N T I M E)) (f (n)) subset.neq bold(upright(N T I M E)) (g (n))$。

]<1>
#proof[
  我们来设计一个精致的图灵机$ZZ$来证明这个命题.
  + 首先,$ZZ$的输入读写头和第一条工作带读写头往右扫描.
    - 若输入不形如$1^n and n > 1$,直接停机并输出0. 
    - *第一条工作带*上第一个位置写1,然后随机写0和1.我们记${h_i}$为工作带上写1的位置序列.
  + *第二条工作带*上,$ZZ$直接模拟那些所有非确定图灵机和$TT_(2f(n))$的硬连接.不妨设这些图灵机为${LL_i}$.$ZZ$模拟完${LL_i}$之后,需要做如下操作来接着模拟${LL_(i+1)}$:
    - 暂停第1步的操作;
    - 在*第三条工作带*上构造$1^(h_(i-1)+1)$.这是因为我们假定第三条工作带上保留着$1^(h_(i-2)+1)$,我们只需要再写$h_(i-1) - h_(i-2)$个1.这里额外开销的时间是$O(h_i)$是线性的;
    - 把$LL_(i-1)$的编码复制到第三条工作带上.这也是线性时间的;
    - 恢复第一步时候的读写头;
    - 恢复输入带和第一条工作带读写头的同步全速向右扫描。与此同时,$ZZ$用暴力法计算$LL_(i-1)(1^(h_(i-1)+1))$.计算完后,$ZZ$将结果写在第二条工作带上，与此同时，在第一条工作带上写1,这个写了1 的格子的地址就是$h_i$.
  + 当输入带结束扫描之后,做如下操作:
    - 若$n = h_i$,$ZZ$接受$1^n <==>$$LL_(i-1)(1^(h_(i-1)+1)) = 0$;
    - 否则, $ZZ$非确定的让$VV(LL_(i-1),1^(n+1))$计算$g(n)$步.

  #line()
   
  设$L$是$ZZ$接受的语言,来考察一下时间复杂度.关键性的是$VV(LL_(i-1),1^(n+1))$的计算开销,不难看出其余步骤全是线性的;所以$L in bold(upright(T I M E)) (g(n))$.

  另一方面,用*反证法*证明$L in.not bold(upright(T I M E)) (f(n))$.
  假设 $L in bold(upright(N T I M E)) (f(n))$，且有$NN_i$能判定.由线性加速定理,我们假定时间函数是$2f(n)$.根据定义,$LL_i$接受$L$,那么当$i$充分大的时候,我们有
   $ 
    LL_i (1^(h_i + 1)) &= ZZ(1^(h_i + 1)) \
    &= LL_i (1^(h_i + 2)) \
    &= ZZ(1^(h_i + 2)) \
    &= dots.c \
    &= LL_i (1^(h_(i + 1))) \
    &= ZZ(1^(h_(i + 1))) \
    &≠ LL_i (1^(h_i + 1))
  $
  这一矛盾说明结论成立.




]

#line()
#remark[

  1.为什么在Step2里,我们要用$TT_(2f(n))$来做计时工作?这是由于@linearspeedup 提出的线性加速定理的推论.

  2.暴力法的意思就是枚举所有的计算路径

  3.#figure(image("32c815519fe3bff44e3e15fc68be1016.jpeg"),caption:[
    这个图展示了每个带子上都写了些啥.从上到下分别是输入带,第一、第二条工作带,和草稿带.
  ])
  4.既然$LL_i$完全由递归呈现,那么$LL_0$在哪里?注意,我们必须假定有一个成熟的算法来枚举${LL_i}$.并且我们不用关心时间复杂度.当$ZZ$的扫描输入这一步骤结束之后,枚举自然应该结束.
  
  5.非确定图灵机里反转很麻烦,需要指数级的时间.所以这个证明绕来绕去的.
]
#line()

作为本章的结束，来看一个定理。

#theorem("间隙定理")[
  设 $r (x) gt.eq x$ 为可计算全函数（不一定时间可构造的）。存在可计算全函数 $b (x)$，$upright(T I M E) (b (x)) = upright(T I M E) (r (b (x)))$。

 
] #proof[
   记 $k_0 < k_1 < dots.h.c$, $k_0 = 0$, $k_(i + 1) = r (k_i) + 1$。并记 $P (i , k)$ 为"$forall j lt.eq i$, $lr(|z|) = i$, $MM_j (z)$ 要么 $k$ 步内停机，要么 $r (k)$ 步不停机"。我们设 $n_i = sum_(j = 0)^i lr(|Gamma|)^i$ 为图灵机 $MM_i$ 的符号串编码长度为 $i$ 的总数，讲这些符号串翻过去作为输入（也就是对角线方法）。

    计算结果肯定不超过 $n_i$ 个，那么由抽屉原理，存在 $j lt.eq n_i$, $P (i , k_j) = 1$。定义 $b (i) = k_j$，所以对所有 $i$, $P (i , b (i)) = 1$。

    取 $L in upright(T I M E) (r (b (x)))$。对足够大的 $x$，总存在一个图灵机 $MM$，它要在 $b (lr(|x|))$ 步停机，要么 $r (b (x))$ 步内不停机，后者显然不符合，这就说明了 $L in upright(T I M E) (b (x))$。

  ]

#remark[

  1.$b(x)$不是一个时间可构造函数,因为间隙定理显然是与非确定时间谱系定理是有点矛盾的.
]

= 空间复杂性

= 作业答案
== 第一次
== 第二次
#problem()[设 $T (n) , T' (n)$ 为时间可构造.证明 $T (n) + T' (n)$、$T (n) dot.op T' (n)$、$T (n)^(T' (n))$ 均为时间可构造.能证明 $T (n) \/ T' (n)$ 是时间可构造吗?$log T (n)$ 呢?]

#solution[
  设 $bb(M_T)$ 和 $bb(M_(T'))$ 分别是计算 $T (n)$ 和 $T' (n)$ 的图灵机.

  - $T (n) + T' (n)$:考察这样的$bb(M_(+)) ,$它先和 $bb(M_T)$执行一样的运算操作,在执行完成后,它不清空带子,而是继续进行和$bb(M_(T'))$ 一样的操作,最后把他们的计算结果加起来,这个二进制加法操作的开销是$O (log (n))$的.所以总运行时间是 $O (T (n) + T ' (n))$ 步. 因此, $T (n) + T' (n)$ 是时间可构造的.

  - $T (n) dot.op T' (n)$:考察这样的$bb(M_dot.op) ,$它进行如下操作:先和 $bb(M_T)$执行一样的运算操作,待完成后,再一个独立的带子上写下一个1,这个循环持续$T' (n)$遍.由于$T' (n)$时间可构造,这个操作是可以被图灵机实现的,所以$T (n) dot.op T' (n)$ 是时间可构造的.

  - $T (n)^(T' (n))$:类似上一个,构建一个循环. \
    先计算 $T (n)$ (需要 $T (n)$ 步),再计算 $T' (n)$ (需要 $T' (n)$ 步);因为根据定义,我们需要最后$T (n)^(T' (n))$ 的二进制表示,所以需要执行一个 $T' (n)$ 次的循环, 在循环体中, 执行一个 $T (n)$ 次的乘法操作.乘法操作参考(2),是时间可构造的.

  - $T (n) \/ T' (n)$:不行.若$T (n) = 2^(2^n) , T' (n) = 2^n$,需要用 $bb(M_T)$ ,先算出$T (n)$的值是多少,但是$T (n) gt.double T (n) \/ T' (n)$,不能被写成大O的形式.

  - $log T (n)$:同理不行.

]

#problem[在通用图灵机的证明中,我们让 $lr(|R_i|) = 2 dot.op 2^(i^2)$.证明在哪一步会出问题?如果没有问题的话,我们会得到一个更高效的通用图灵机!]

#solution[
  由于更改,我们必须在原来的证明中把冗余信息的存放方式修正为:要么全空,要么存$log (R_i / 2) \/ 2$(替代半满),要么存$log (R_i / 2)$(替代全满).

  问题出在最后的移动冗余信息中.考察一个简单的图灵机 $bb(M)$, 它只是简单地将其读写头向右移动 $T (n)$ 个单元格, 每步都在纸带上写入一个符号.令 $S (i)$ 为从中心点 0 到段 $R_(i - 1)$ 末尾的总容量. $S (i) = sum_(j = 0)^(i - 1) lr(|R_j|) = sum_(j = 0)^(i - 1) 2 dot.op 2^(j^2)$.

  为了让 $M$ 的读写头移动到第 $S (k) + 1$ 个单元格, $U$ 必须已经执行了所有 $i = 1 , 2 , dots.h , k$ 的重组操作,把$R_i$的冗余信息搬到前面$1 tilde.op i - 1$个格子内.则: $ T^quote.l.single (n) gt.eq sum_(i = 1)^k C_i = sum_(i = 1)^k O (2^(i^2)) = O (2^(k^2)) $

  取$k = sqrt(log_2 T (n)) + 1$,代回 $T_U (n)$: $ T^' (n) &=O(2^(log T(n) + 2sqrt(log T(n)) + 1)\ 
  &= O(T(n) dot.c 2^(2sqrt(log T(n))))
  $ 他的效率很低下.

]
#problem[说明:若忽略不终止性,在第 28 页上定义的非确定的"通用"图灵机是正确的.]

#solution[
  #heading(level: 4, numbering: none)[($arrow.r.long.double$) ]
  <rightarrow>
  根据非确定性计算的定义, 如果 $bb(N)_alpha$ 接受输入 $x$, 那么必然存在至少一条从初始格局到接受格局的合法计算路径.设这条接受路径为格局序列 $cal(C) = (C_0 , C_1 , dots.h , C_m)$, 其对应的非确定性选择序列为 $cal(D) = (delta_1 , dots.h , delta_m)$.

  $bb(V)$ 本身是一台非确定图灵机, 它能够探索所有可能的计算分支. 因此, 必然存在一$bb(V)$的计算路径, 在该路径上, 它所猜测的格局序列恰好是 $cal(C)$, 猜测的选择序列恰好是 $cal(D)$. 此时被猜测的序列本身就是一条合法的接受路径, 所有验证步骤都会成功,$bb(V)$将停机并成功模拟了运算.

  #heading(level: 4, numbering: none)[($arrow.l.long.double$) ]
  <leftarrow>
  如果$bb(V)$ 接受输入 $angle.l alpha , x angle.r$, 那么必然存在至少一条$bb(V)$的计算路径使其进入接受状态. 在这条使 $bb(V)$ 接受的路径上, 它必须成功地完成"猜测"和"验证"两个阶段.$bb(V)$所猜测的格局序列 $cal(C) = (C_0 , C_1 , dots.h , C_m)$ 和选择序列 $cal(D) = (delta_1 , dots.h , delta_m)$ 必须满足以下所有条件:

  - $C_0$ 被验证为是 $bb(N)_alpha$ 在输入 $x$ 上的初始格局.

  - $C_m$ 被验证为是一个接受格局.

  - 对所有 $i in { 0 , dots.h , m - 1 }$, 转移 $C_i arrow.r C_(i + 1)$ 被验证为是 $bb(N)_alpha$ 在选择 $delta_(i + 1)$ 下的一步合法操作.

  根据定义,$bb(N)_alpha$ 接受 $x$.

]
#problem[证明:设图灵机 $bb(M)$ 在 $T (n) = omega (n)$步内判定 $L$.对任意 $epsilon > 0$,有图灵机 $bb(M)'$,$bb(M)'$ 能在 $epsilon T (n)$ 步内判定 $L$.]
#solution[
  根据线性加速定理,我们知道有图灵机$bb(M)'$,它能在$F (n) =^Delta epsilon_1 T (n) + n + 2$步内判定$L$,其中$epsilon_1 > 0$. \
  由于$T (n) = omega (n)$,知$forall delta > 0 , exists N in bb(N) , $ $ forall n > N ,0 \< (n+2)/T(n) \< delta
  ==> F(n) \< (epsilon_1 + delta)T(n). $ 我们取$epsilon_1 = delta = epsilon / 2$即可.

]
#denote[
  为什么没有一个2.2.4.1的编号?
]
