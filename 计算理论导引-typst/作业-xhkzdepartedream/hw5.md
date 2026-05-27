# 计算理论导引第五次作业


1. 证明 $\mathbf{PSPACE}^{\mathbf{PSPACE}} = \mathbf{PSPACE}$。
    显然$\mathbf{PSPACE} \subseteq \mathbf{PSPACE}^{\mathbf{PSPACE}}$。下证$\mathbf{PSPACE}^{\mathbf{PSPACE}} \subseteq   \mathbf{PSAPCE}$。
    设有神谕图灵机$\mathbb{M}^O$，其中$O \in \mathbf{PSAPCE}$，$\mathbb{M}$的计算空间也在多项式空间中。
    对于一个普通的$\mathbb{M}$，以如下方式模拟$\mathbb{M}^O$：
    当$\mathbb{M}^O$调用神谕时，在$\mathbb{M}$的工作带上的特定空间中模拟神谕的求解，返回答案之后抹去刚刚求解神谕所用的空间。下次调用神谕的时候，复用上述空间。
    故总空间是$\mathbb{M}$主程序使用的空间加上调用神谕所使用的空间的最大值，二者均为多项式空间，故$\mathbb{M}$花费的空间也为多项式空间，故$\mathbf{PSPACE}^{\mathbf{PSPACE}} \subseteq   \mathbf{PSAPCE}$。
    故$\mathbf{PSPACE}^{\mathbf{PSPACE}} = \mathbf{PSPACE}$。

  

2. $A \in \mathbf{NPC},B \in \mathbf{P}.$证明：$A\cap B=\emptyset \implies A \cup B = \mathbf{NPC}.$
    由上次作业：$A, B \in \mathbf{NP} \implies A \cap B, A \cup B, AB \in \mathbf{NP}$，可知：$A \cup B \in NP$。
    下证：$A \cup B$ 是 $\mathbf{NP}$-hard的。
    由于$A \in \mathbf{NPC}$，$\forall L \in \mathbf{NP}$，都存在一个karp归约：$L \leq_{K} A$，由karp归约的传递性，现只需构造一个归约$f:  A \to A \cup B$，使得$\forall x,x\in A \iff f(x) \in A \cup B$，即可得证。$f$的计算过程如下：
    - 首先判定$x \in B$？
        - 若$x \notin B$，由于$A\cap B=\emptyset$，则$x \in A$。此时，$f(x) = x$，故$x\in A \iff f(x)=x\in A \cup B$成立。
        - 若$x \in B$，则$x \not\in A$，选取一个 $y \notin A \cup B$，令 $f(x) = y$。此时$x\in A \iff f(x)\in A \cup B$中，左右两边均为False，成立。
        其中检查 $x \in B$的步骤可以在多项式时间内完成（因为 $B \in \mathbf{P}$）。所以$f$的计算可以再多项式时间内完成，所以$A \leq_{K} A \cup B$，$A \cup B$ 是 $\mathbf{NP}$-hard的。



3. 证明：$L_{1}=\{ \phi 01^{|\phi|^c} \mid \phi \in SAT \}$ 是$\mathbf{NP}$完全的，而 $L_{2}=\{ \phi 01^{2^{|\phi|}} \mid \phi \in SAT \}$ 是$\mathbf{P}$的。

    1. 构造$f:  \phi \mapsto \phi 01^{|\phi|^c}$，显然$f$满足归约的性质：$\forall \phi,\phi \in SAT \iff  f(\phi)=\phi 01^{|\phi|^{c}}\in L_{1}$。所以$L_{1}$是$\mathbf{NP}$-hard的。
        构造$L_{1}$的验证器$\mathbb{M}$如下：$\forall x \in L_{1}$以及对应的证书$u$，$\mathbb{M}$首先验证$u$是否满足$\phi 01^{|\phi|^c}$的形式，这一步可以在多项式时间内完成；若满足，再使用$u$计算$\mathbb{M}(x,u)$。由于$SAT$问题的验证可以在多项式时间内完成，所以这一步也可以在多项式时间内完成。因为 $L$ 的实例可以在多项式时间内被验证，所以 $L \in \mathbf{NP}$。
        综上，$L_{1}=\{ \phi 01^{|\phi|^c} \mid \phi \in SAT \}$ 是$\mathbf{NP}$完全的。
    2. 记$|\phi|=n$，则输入的长度$|\phi 01^{2^{|\phi|}}|=O(2^n)$。又$SAT$问题变元的数量为$O(n)$，故暴力求解的时间为$O(2^n)$，故$L_{2}=\{ \phi 01^{2^{|\phi|}} \mid \phi \in SAT \}$ 可在$\mathbf{P}$时间内解决。
