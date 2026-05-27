# 计算理论导引第三次作业

1. 利用分配律 $x \land (y \lor z) = (x \land y) \lor (x \land z)$ 和 $x \lor (y \land z) = (x \lor y) \land (x \lor z)$，是否可在多项式时间内将合（析）取范式转换成析（合）取范式？

否。假设我们有一个 CNF 公式，它的编码长度是 n：

- 变量个数最多是 $O(n)$，子句个数最多也是 $O(n)$；
- 用分配律展开成 DNF 时，存在一类CNF，其每一个子句都至少含有2个变元，对于这类CNF而言项数至少是 $O(2^k)$，其中 $k$ 是子句个数，所以项数为 $O(2^{\Theta(n)})$。
- 每个项的编码长度为$O(n)$，所以总时间复杂度为$O(n)\cdot O(2^{\Theta(n)})=O(n\cdot2^{\Theta(n)})$。
- 任何算法都必须至少写出输出，而输出长度显然大于$O(n)$，故答案为**否**。



2. 证明 $\textbf{EXP}^{\textbf{EXP}} = \textbf{2-EXP}$。

尝试避开“神谕图灵机”的概念，用很不严谨但很直观的话来说：本质上是在EXP时间内调用需要EXP时间的函数。

主程序运行时间是$O(2^{n^{c_1}})$，最坏的情况是需要执行$O(2^{n^{c_2}})$次子程序，子程序的输入可能长达$m=O(2^{n^{c_1}})$。故总时间为：
$$
O(2^{n^{c_1}})\cdot O(2^{m^{c_2}})
$$
注意这里的$m=O(2^{n^{c_1}})$，已经出现两个2了。又对于足够大的$n$，$c\cdot n^c\sim n^{c'}$，所以$O(2^{n^{c_1}})\cdot O(2^{m^{c_2}})=O(2^{2^{n}})$。



3. 证明 $\textbf{2SAT} \in \textbf{P}$。

$a \or b\Leftrightarrow \neg a \rightarrow b\Leftrightarrow \neg b \rightarrow a$，考虑有$2n$个顶点的有向图，每个子句都添加$\neg a \rightarrow b, \neg b \rightarrow a$两条有向边，假设一共连了$m$条有向边，再使用$tarjan$算法求出所有强联通分量，所需时间为$O(m+n)$。再检查所有的结果：如果存在$x$使得$\neg x$与$x$属于同一个强连通分量，则判定无解，反之判定有解。显然检查结果所需要的时间也是$O(n)$。所以总时间仍然在多项式时间内。



4. 写一段对数空间程序，解决 $\texttt{MULP}.它定义为
           \texttt{MULP} \overset{\text{def}}{=} \{ (a, b, c) \mid a, b, c \text{ 为二进制数，且 } a \cdot b = c \}
           $

维护当前进位值c以及当前计算位数j，记j=0时表示正在计算最低位（第0位）。

```python
# 输入: a, b, c 是二进制字符串，从低位到高位存储（a[0] 是最低位）
# 输出: 如果 a * b == c，返回 True；否则返回 False

def verify_mul(a, b, c):
    n = len(c)  # c 的长度，最多为 len(a) + len(b)
    
    # 遍历 c 的每一位 j
    for j in range(n):
        carry = 0  # 当前位的进位（实际上是累加和，最后取模 2）
        
        # 遍历 b 的每一位 i
        for i in range(len(b)):
            if b[i] == '0':
                continue  # 如果 b[i] 是 0，跳过
            
            # 计算 a 的第 (j - i) 位
            k = j - i
            if k < 0 or k >= len(a):
                continue  # 超出 a 的范围，忽略
            
            # 将 a[k] 加到累加和中
            if a[k] == '1':
                carry += 1
        
        # 计算当前位的值（模 2）
        bit_j = carry % 2
        
        # 检查 c 的第 j 位是否匹配
        if j >= len(c) or c[j] != str(bit_j):
            return False  # 不匹配，拒绝
    return True
			
```

5. 证明空间压缩定理:设图灵机 $M$ 在 $S(n)$ 空间判定 $L$。对任意 $\epsilon > 0$，存在图灵机 $M'$，$M'$ 能在 $\epsilon S(n) + 1$ 空间内判定 $L$。

将图灵机的工作带上每连续$k$个格子压缩成一个格子，设$M$定义为$(\Gamma,Q,\delta)$，则$M'$定义为$(\Gamma',Q’,\delta)$，其中$\Gamma'=\Gamma^k$，$Q'$的每一个元素是一个序偶$(q,i)$，$q$是$M$的当前状态，$i\in{0,1,...,k-1}$是$M$的读写头处于当前$k$个格子组成的元组中的位置编号。所以$S'(n)=\lceil \frac{S(n)}{k} \rceil=\frac{S(n)}{k}+1$。取$\epsilon=\frac{1}{k}$即可。