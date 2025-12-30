# 计算理论导引第四次作业

1. 证明:隐式对数空间可计算函数就是对数空间可计算函数.

设函数$f$是隐式对数空间可计算函数，则$|f(x)|$可在多项式空间内表示（隐式对数空间可计算函数的定义）。维护一个计数器$i$，$i$ from 0 to $|f(x)|$，依次计算$f(x)$的每一位即可。由于$i$只需要$𝑂(log|𝑓(𝑥)|) = 𝑂(log|𝑥|)$的空间，且计算$f(x)$的每一位也只需要对数空间，得证。



2. 我们证明了`QBF`可在线性空间判定。将证明中描述的线性空间算法用程序实现。

唯一需要说明的一点是，尽管下面的`QBF`函数使用了两次递归，但第一次递归结束后可以释放所用的空间，仅保留结果；第二次递归复用第一次递归所用的空间。

```python
def QBF(phi,i):
    if i==len(phi): # 递归调用到达底部
    return calculate(phi, cur_assignment)

    Q, x, psi = split(phi) # 分离当前处理的量词与变元
    # x = 0的情况：
    cur_assignment[x] = 0
    val0 = QBF(psi,i+1)
    
    free_stack_space()
    # x = 1的情况：
    cur_assignment[x] = 1
    val1 = QBF(psi,i+1)
    
    if Q == EXISTS:
        return val0 or val1
    else:
        return val0 and val1
```



3. 说明斯托克迈尔-梅耶定理的证明中构造的$phi_x$是对数空间可计算的.

   $phi_x$的定义为$\psi_i(C,C')$：
   $$
   \begin{align*}
   (\exists C \forall D^1 \forall D^2 \left( (D^1 = C \wedge D^2 = C'') \vee (D^1 = C'' \wedge D^2 = C') \right) \Longrightarrow \psi_{i-1} (D^1, D^2))
   \end{align*}
   $$
   对于蕴含表达式左边的部分，通过枚举所有的$C,D^1,D^2$暴力求解，如果为假就继续下一组；如果为真则递归地计算$\psi_{i-1}$。显然蕴含表达式左边的部分需要常数空间，同时可以维护一个计数器$i$，记录当前递归的深度，这是对数空间的。综上，$phi_x$是对数空间可计算的。

   

   

4. 用程序实现萨维奇定理证明中的算法。

      ```python
      def Accessible(u, v, k):
          if k == 0:
          return (u == v) or Edge(u, v)
          # 枚举中间点 w
          for binary_index from 0 to N-1:
          w = nodes[binary_index]
          if Reach(u, w, k-1):
          	free_used_space()
          	if Reach(w, v, k-1):
          		return True
          return False
      ```

      main函数调用：`Reach(start_node, accept_node, ceil(log2(N))).`

      假设问题的空间是 $S(n)$，那么所有可能的格局总数 $N$ 是 $2^{O(S(n))}$，递归深度是$O(S(n))$，每一次递归仅需要`w`的枚举二进制编码，这是$\log(N)=O(S(n))$。故总共需要$O(S(n))\times O(S(n))=O(S(n)^2)$的空间。

      

5. 证明：$A, B \in \mathbf{NP} \implies A \cap B, A \cup B, AB \in \mathbf{NP}$。

      设非确定性多项式图灵机$\mathbb{N}_A,\mathbb{N}_B$分别判定$A,B$，现构造输入$x$以及$\mathbb{N}$分别证明：

      1. $\mathbb{N}$先后模拟$x$在$\mathbb{N}_A,\mathbb{N}_B$上的过程，分别输出结果，时间为$\mathbb{N}_A,\mathbb{N}_B$在输入$x$上花费的时间之和，显然也为多项式时间；
      2. 同上。
      3. $\mathbb N$猜测一个分割点，将输入$x$分割为$x_1,x_2$，再模拟$\mathbb{N}_A,\mathbb{N}_B$分别计算。显然也为多项式时间。

