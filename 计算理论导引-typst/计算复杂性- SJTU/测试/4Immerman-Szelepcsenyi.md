## Immerman-Szelepcsenyi 定理

$$
\overline{\mathrm{PATH}}\in\mathbf{NL}
$$

## 证明

需设计一对数空间NTM$\mathbb N$，当输入一个可达性问题实例$(G,s,t)$时，$\mathbb N(G,s,t)=1$当且仅当图G中从s到t没有路径。

设图G有n个结点。显然，如果s到t有路径，从s出发n-1步内能到达t，我们逐步构建从s出发$i\in[1..n-1]$步内能到达的节点集合。引入集合$C_i$和数$c_i$，其定义如下：

- $C_i$为从s出发i步内能到达的结点集合。显然$C_1\subseteq C_2\subseteq\cdots\subseteq C_{n-1}$，且以下三者等价：$\mathbb N(G,s,t)=1\Leftrightarrow$“s到t没有路径”$\Leftrightarrow t\notin C_{n-1}$.
- $c_i=|C_i|$为$C_i$中的节点数。

每个$C_i$的大小是线性的，故每个$c_i$的长度是对数的，所以可以把固定数目的$c_i$存放在工作带上。我们使用如下算法：

1. 计数器初始化$c_1=c_2=\dots=c_{n-1}=0$；
2. 计算$c_1$；
3. 由$c_i$计算$c_{i+1}$，直至算出$c_{n-2}$；
4. 由$c_{n-2}$判断t是否在$C_{n-1}$内。

第2步容易在对数空间内计算。枚举G中每个异于s的节点v，如果s到v有边，则计数器$c_1$自增。

第3步的计算需要知道$C_i$和$C_{i+1}$. 我们没法存下任何$C_i$，但是我们能存下$c_i$. 在存着$c_i$的时候，有$\mathbf{NL}$中的算法来判断任一节点v是否满足$v\in C_{i+1}$，即
$$
\mathrm{judge}(v,i)=\begin{cases}
1,&v\in C_{i+1}\\
0,&v\in C_{i+1}\\
\end{cases}
$$
judge(v, i)的算法如下：

> def judge(v, i):
>
> ​	ans=0;
>
> ​	counter=0;
>
> ​	for w in G:
>
> ​		//猜w是否在$C_i$中
>
> ​		if Guess($w\in C_i$):
>
> ​			if not PATH(G, s, w, i): //调用$\mathbf{NL}$中的可达性算法，G中s是否在i步内可达w.
>
> ​				//猜错了，w不在$C_i$内，停机。
>
> ​				halt();
>
> ​			if v==w or w到v有边:
>
> ​				//$v\in C_i$或从$C_i$起v一步可达。
>
> ​				ans=1;
>
> ​			counter+=1;
>
> ​	if counter$\neq c_i$:
>
> ​		//猜少了，猜的$C_i$中结点数不够，停机。
>
> ​		halt();
>
> ​	return ans;

以上算法中把$C_i$给准确地猜出来了，有且仅有一条正确猜测路径，且返回了judge(v, i)的正确结果，其余错误猜测路径全部停机。

那么$c_{i+1}$的计算只需要简单地累加得出：

> for v in G:
>
> ​	if judge(v, i):
>
> ​		$c_{i+1}$+=1;

计算出$c_{i+1}$后把$c_i$擦掉以腾出空间。

最终，我们可以计算出$c_{n-2}$，然后调用judge(t, n-2)得到$\mathbb N(G,s,t)$的结果。