## Ladner定理

若$\mathbf P\ne\mathbf{NP}$，则$\mathbf P\cup\mathbf{NPC}\ne\mathbf{NP}$，即存在$\mathbf{NPI}$问题。

## 证明

由Cook-Levin定理知$\mathrm{SAT}$问题为$\mathbf{NPC}$问题。

定义语言
$$
\mathrm{SAT}_H=\{\psi0\underbrace{11\cdots1}_{n^{H(n)}个1}|\psi\in\mathrm{SAT}且|\psi|=n\}
$$
定义函数
$$
H(n)=i,\quad i<\log\log n且是满足以下条件的最小值：\\对于任意|x|\le\log n的输入x，\mathbb M_i(x)在i|x|^i个步骤内输出\mathrm{SAT}_H(x)。\\
如果上述i不存在，则H(n)=\log\log n。
$$
显然$H(n)$是个非递减函数。

计算$H(n)$的算法：

> for $i$ in $[0..\log\log n-1]$ :
>
> ​	for $x$ with $|x|\le\log n$ :
>
> ​		模拟$\mathbb M_i(x)$的计算，使用通用图灵机$\mathbb U(i,x)$ ;	$O(cC\log C)$
>
> ​		计算$\mathrm{SAT}_H(x)$ ;

计算$\mathrm{SAT}_H(x)$的算法：

> 获得$x$中$\psi'$的长度$n'$ ;	$n'\le|x|\le\log n$
>
> 暴力判断$\psi'$是否在$\mathrm{SAT}$中 ;	$O(2^{n'})=O(n)$
>
> 计算$H(n')$ ;	$T(\log n)$
>
> 计算$n'^{H(n')}$ ;	$O(|n'|^{H(n')})=O((\log\log n)^{\log\log n'})$
>
> 判断$x$中末尾的1串的长度是否为$n'^{H(n')}$ ;	$O(n'^{H(n')})=O((\log n)^{\log\log n'})$

计算$H(n)$的时间函数$T(n)$满足
$$
T(n)\le(\log\log n)(2^{1+\log n})(cC\log C+O(n)+T(\log n)+\cdots)\\
其中c=c(|i|)=c(\log\log\log n),\quad C=i|x|^i=O((\log\log n)(\log n)^{\log\log n})
$$
总之$H(n)=o(n^3)$。？

## 引理：若$\mathbf P\ne\mathbf{NP}$，则$\mathrm{SAT}_H\notin\mathbf P$。

假定$\mathrm{SAT}_H\in\mathbf P$，存在$\mathbb M_\alpha$在$c|x|^c$步骤内判定$\mathrm{SAT}_H(x)$，因为与$\mathbb M_\alpha$等效的图灵机编码有无限个，可以取足够大的$\alpha>c$，$\mathbb M_\alpha(x)$可以在$\alpha|x|^\alpha$步骤内判定$\mathrm{SAT}_H(x)$，当$n$足够大使得$\alpha<\log\log n$以后，按照定义$H(n)=\alpha$恒成立。也就是说，当$n$足够大时，$\psi\in\mathrm{SAT}$当且仅当$\psi0\underbrace{11\cdots1}_{n^\alpha个1}\in\mathrm{SAT}_H$，即$\mathrm{SAT}\le_{K}\mathrm{SAT}_H$，则$\mathrm{SAT}\in\mathbf P$，这与$\mathbf P\ne\mathbf{NP}$矛盾。故$\mathrm{SAT}_H\notin\mathbf P$。

## 引理：若$\mathbf P\ne\mathbf{NP}$，则$\mathrm{SAT}_H\notin\mathbf {NPC}$。

假定$\mathrm{SAT}_H\in\mathbf{NPC}$，存在多项式$d|\varphi|^d$时间内可计算的卡普规约$r:\mathrm{SAT}\mapsto\mathrm{SAT}_H$，即
$$
\varphi\in\mathrm{SAT}当且仅当r(\varphi)=\psi0\underbrace{11\cdots1}_{n^{H(n)}个1}\in\mathrm{SAT}_H
$$
因为$H(n)$是趋于无穷大的，存在足够大的$N$，当
$$
|r(\varphi)|=|\psi0\underbrace{11\cdots1}_{n^{H(n)}个1}|>N
$$
时$H(n)>2d+1$且$|\psi|>d$。在这种情况下
$$
|\psi|^{2d+1}<n^{H(n)}<|r(\varphi)|\le d|\varphi|^d<|\psi||\varphi|^d
$$
得到$|\psi|<\sqrt{|\varphi|}$，于是我们得到了多项式时间判定$\mathrm{SAT(\varphi)}$的递归算法：

> 计算$r(\varphi)$，判断结果是否为$\psi0\underbrace{11\cdots1}_{n^{H(n)}个1}$的形式，若不是，拒绝$\varphi$。
>
> 若$|r(\varphi)|>N$，递归调用$\mathrm{SAT(\psi)}$，否则暴力判定$\psi$是否在$\mathrm{SAT}$中。

设递归深度为$k$，即递归$k-1$次时依然要继续递归，则
$$
\underbrace{\sqrt{\cdots\sqrt{|\varphi|}}}_{k-1个根号}=|\varphi|^{2^{1-k}}>N\\
N^{2^{k-1}}<|\varphi|\\
2^{k-1}\log N<\log|\varphi|\\
(k-1)\log2+\log\log N<\log\log|\varphi|\\
k=O(\log\log|\varphi|)
$$
递归每一层都只需要多项式的时间，而递归边界暴力判定$\psi$时，由于$|\psi|\le N$，时间为常数，故$\mathrm{SAT}\in\mathbf P$，矛盾。故$\mathrm{SAT}_H\notin\mathbf{NPC}$。