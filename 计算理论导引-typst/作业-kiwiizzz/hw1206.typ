#set page(paper: "a4", margin: 3em)
#import "@preview/dvdtyp:1.0.1"
#import "@preview/numbly:0.1.0": numbly
#import "@preview/thmbox:0.3.0": *
#import "@preview/cuti:0.2.1": show-cn-fakebold

#show: show-cn-fakebold
#import "@preview/mitex:0.2.5": *
#set text(font: "Songti SC")
//#show emph: text.with(font: "STKaiti")
//#show smartquote: set text(font: "Libertinus Serif")
#import "@preview/dvdtyp:1.0.1": *
#show math.equation: set text(purple, size: 1em)
#set line(length: 100%, stroke: 0.1pt)
#show: dvdtyp.with(
  title: "计算理论导引第五次作业",
  author: "易守拙 2024300001103",
)
#let pspace() = $bold("PSPACE")$
#let npc() = $bold("NPC")$
#let p() = $bold("P")$
#let np() = $bold("NP")$
#problem[
  证明$#pspace()^#pspace()$ = #pspace().
]
#solution([
  显然有$#pspace() subset.eq #pspace()^#pspace()$,因为我们可以选择不问神谕.

  以下来证明反向的包含.考虑$ #pspace()^#pspace() eq.delta ⋃_( O in #pspace())#pspace()^O $.对于一个$O in #pspace(),$我们来证明对一个简单的$MM in #pspace()$,它能模拟图灵机$MM^O$.

  设这个$MM^O$会问$k$次神谕,我们可以把$MM^O$的计算过程看成一个二叉树,每一个节点都是提问,会随着神谕的返回而分裂成左右两个子树(代表着不同的状态).所以这个二叉树有$k$层,我们用dfs的方法模拟这个二叉树.每一次模拟都共享一个空间;由于$O in #pspace()$,每一次模拟都是$"poly"(n)$的.具体模拟如下:

  1. $MM$在神谕之外的所有操作都和$MM^O$相同;我们开辟一个新的$"poly"(n)$空间来存储$MM$的神谕计算空间.
  2. 遇到神谕的时候,保存当前格局,然后在那个$"poly"(n)$空间中运行$MM^O$的下一次神谕;
  3. 根据神谕返回的yes或者no,顺着模拟之后的格局.

    这个图灵机的空间当然是$O("poly"(n))$的,所以反向包含也成立,进而原命题成立.

])

#problem[
  $A in #npc(),B in #p().$证明:$A ∩ B = nothing ==> A∪ B = #npc()$.
]
#solution[
  由上次作业我们知道$A ∪ B subset.eq #np()$,要证明它是#np()难的.

  由题意,对$forall L in #np(), exists f$多项式归约到$A$.$g(x)$定义如下:

  1. 先计算$f(x)$;
  2. 用#p()时间计算$f(x) in B ?$.如果不在,说明$g(x) in A ∪ B <==> g(x) in A <==> x in L$.
  3. 如果在,并且$A ∩ B = nothing$,这说明$x in.not L$,我们令此时$g(x) = y,y in #p()\\B$. 这时,$forall x in.not L ==> g(x) in.not A ∪ B$.

  这说明了$L lt.slant_p A ∪B,g$是我们找到的归约函数.所以$A ∪ B = #npc()$.

]

#problem[
  证明,${phi.alt 01^(abs(phi.alt)^c)| phi.alt in "SAT"}$是#np()完全的,而${phi.alt 01^(2^abs(phi.alt))| phi.alt in "SAT"}$是#p()的.
]
#solution[

  *(1)*.由于$phi.alt 01^(abs(phi.alt)^c)$的验证需要判定一个`SAT`里的公式$phi.alt$,所以它一定是#np()时间的.

  考虑这个规约$f: phi.alt |->phi.alt 01^(abs(phi.alt)^c)$.这显然是个归约.并且,判定一个01串是不是满足`QBF`格式用栈的一次扫描之后模拟即可,是线性时间的;同时,在这一步里维护计数器就能同时得到$abs(phi.alt)$.然后后面直接枚举$abs(phi.alt)^c$个$01$串,也是一次扫描即可得到结果.

  所以,总时间复杂度是$O(n)$.所以$f$是多项式时间的,进而也就是$"SAT" lt.slant_p {phi.alt 01^(abs(phi.alt)^c)| phi.alt in "SAT"}$.所以${phi.alt 01^(abs(phi.alt)^c)| phi.alt in "SAT"}$是#np()完全的.

  *(2)*.记$n = abs(phi.alt 01^(2^abs(phi.alt)))$,那么,$abs(phi.alt) = O(log n)$.类似(1),判定这个格式是否正确是$O(n)$的.如果格式正确,我们还需计算这个结果,也就是判定$phi.alt$.直接暴力枚举每个指派,时间复杂度是$O(2^(O(log n))) = O(n)$的.而后面的01串只是垃圾信息,对结果没有影响.所以,我们得到了${phi.alt 01^(2^abs(phi.alt))| phi.alt in "SAT"} in #p()$.
]
