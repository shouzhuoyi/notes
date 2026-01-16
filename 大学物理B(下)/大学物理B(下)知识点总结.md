> [!info]
> author: xhkzdepartedream&bjhh2005&Larryyyyyyy
> last update: 2025.12.23
> 特别感谢bjhh2005提供的原版物理下笔记，以及Larryyyyyyy在此基础上添加的“早期量子论”“量子力学基础”。如有谬误，恳请广大读者批评指正。祝各位同学顺利通过考试！——xhkzdepartedream

# 电磁学
## 1 恒定电流
$$
\begin{align}
I &= \frac{dq}{dt}\\
\vec j &= \frac{dI}{dS}\vec {e_0},I =\iint_S\vec j \cdot\vec{dS}\\ \\
\vec j &= \sigma \vec E\\
\end{align}
$$
其中$\rho = 1/\sigma$。
## 2 恒定磁场
### 2.1 毕奥萨伐尔定律
**积分法**求任意形状电流的**磁场分布**：
$$
d\vec B =\frac{\mu_0}{4\pi}\frac{Id\vec l \times\vec r}{r^3}\ 或\ 
d B =\frac{\mu_0}{4\pi}\frac{Id l sin\theta}{r^2}
$$
> [!note]
> **位置矢量 $\vec r$** 是从 **电流元** 到 **考虑磁场的点**。
#### 2.1.1 载流直导线
有限长：
$$
B = \frac{\mu_0I}{4\pi a}(\cos\theta_1-\cos\theta_2)\\
$$
顺着电流的方向，**起点到目标点** 与电流方向的夹角是 $\theta_1$，**终点到目标点** 与电流方向的夹角是 $\theta_2$
无限长：
$$
B =\frac{\mu_0I}{2\pi a}\\
$$
#### 2.1.2 载流圆线圈轴上
对于圆心处，$x = 0$：
$$
B_0 =\frac{\mu_0I}{2R}\\
$$
轴上其余位置：
$$
B =B_0\cdot \sin^3\varphi=\frac{\mu_0IR^2}{2(R^2+x^2)^{\frac 32}}
$$

> [!note]
>
> 载流圆线圈轴上的公式是**不带$\pi$的**。​

#### 2.1.3 载流密绕直螺线管轴线
$$
B =\frac{\mu_0nI}2 [\frac{x_2}{\sqrt{x^2_2+R^2}}-\frac{x_1}{\sqrt{x_1^2+R^2}}]\\
$$
无限长直螺线管
$$

B =\mu_0nI=\mu_0j\\
$$
长直螺线管端点处
$$
B =\frac12\mu_0nI=\frac12\mu_0j\\
$$
#### 2.1.4 运动电荷
$$
\vec B =\frac{\mu_0}{4\pi}\frac{q\vec v\times \vec r}{r^3}\\
$$
$I\vec l$ 降级之后就是 $q\vec v$​。

#### 2.1.5 无限大均匀平面电流
$$
B =\frac{\mu_0j}{2}
$$
两侧的磁场都为均匀磁场，并且大小相等，方向相反。

### 2.2 安培定律
$$
d\vec F = Id\vec l \times\vec B
$$
无限长平行载流直导线之间的相互作用：
$$
F=\frac{\mu_0 I_1 I_2}{2\pi d}
$$
### 2.3 安培环路定理：恒定磁场有旋
$$
\oint_l\vec B\cdot d\vec l =\mu_0\sum I_i\\
$$
### 2.4 高斯定理：恒定磁场无源
通过任意闭合曲面$S$的磁感应线，穿进的数目必定等于穿出的根数，磁通量恒为 0。

### 2.5 洛伦兹力
$$
\vec F = q\vec v \times \vec B\\
$$
#### 2.5.1 霍尔效应
$$
\begin{align}
U_{霍尔}= V_1-V_2 = R_H\frac{IB}d\\
霍耳系数：R_H =\frac 1{nq}\\
p 型半导体(空穴导电): R_H > 0\\
n 型半导体(电子导电)：R_H < 0\\
\end{align}
$$

### 2.6 磁矩与磁力矩
磁矩：描述**磁体**、**载流回路**、**基本粒子**等具有磁性的物体**磁性强度和方向**的向量。
对于 N 匝线圈有
$$
\vec m = NIS\vec e_n\\
$$
单位：$A\cdot m^2 \cdot T=N\cdot m$。
磁力矩：外磁场($\vec{B}$) 对具有磁矩 ($\vec{m}$) 的物体（如磁铁或载流回路）施加的旋转力矩。
$$
\vec M = \vec m \times \vec B
$$
磁场力和磁力矩的功可以统一为：$A=NI\Delta \Phi$。永远记住 **力矩** 求 **做功** 时是 **对角度** 积分。

## 3 磁场与介质的相互作用
$$
\begin{align}
\vec B（介质内的合磁场）&=\vec{B_0}（真空中的磁场）+\vec{B'}（磁化产生的附加磁场）\\
磁介质的相对磁导率\mu_r &=\frac{B}{B_0}\\
\end{align}
$$
### 3.1 磁化强度与磁化电流
磁化强度是单位体积内的净磁矩(单位体积内分子磁矩的矢量和)。
$$
\vec M =\frac{\sum\vec{p_m}}{\Delta V}\\
$$
磁化电流：顺磁质对磁化的“增强效应体现”，绕着轴线流动，方向用右手定则判断。
$$
j_S =\frac{I_S}l\\
$$
介质被**均匀**磁化时，$I_S$ 只出现在介质表面：
$$
\vec {j_S}=\vec M\times\vec n\\
$$
这里$\vec n$为磁介质表面的外法线单位矢量方向，是**从磁介质指向真空（非磁介质）** 的。
介质被非均匀磁化时，介质内部和表面都有磁化电流：
$$
\oint_L\vec M\cdot\vec{dl}=\sum I_S\\
$$
$\vec M$的方向大致与$\vec{B}$的方向相同。
### 3.2 磁介质中的安培环路定理
磁介质存在时$B$由传导电流$I_0$和磁化电流$I_s$共同产生（外部+磁介质的强化）：
$$
\begin{align} \\
\oint_{L} \mathbf{B} \cdot d\mathbf{L} &= \mu_0 \left( \sum I_0 + \sum I_s \right)\\
\vec H &=\frac{\vec B}{\mu_0}-\vec M\\
\oint_l \vec H\cdot\vec{dl}&=\sum I_C\\
\end{align}
$$
$\chi_m$可以理解为介质自己对磁场的贡献与外部电流对磁场贡献之比，因此$\mu_r = 1+\chi_m$。$\vec H =\frac{\vec B}\mu$把握好即可。
$$
\begin{align}
\vec M =\chi_m\vec H, \chi_m 称为磁化率\\
\mu_r = 1+\chi_m,\mu_r 称为相对磁导率\\
\vec B =\mu_0\mu_r\vec H =\mu \vec H,\mu =\mu_0\mu_r 称为绝对磁导率\\
\vec H =\frac{\vec B}\mu\\
\end{align}
$$
### 3.3 磁滞现象
[[物理下笔记#2.1 铁磁质磁化的磁滞现象及磁滞回线]]
## 4 电磁感应
### 4.1 法拉第电磁感应定律
$$
\begin{align}
感应电动势 E_i &=-\frac{d\Phi}{dt}\\
磁链\Psi &= N\Phi\\
感应电量 q_i &=-\frac1R\Delta\Psi\\
\end{align}
$$
动生电动势$E=Blv$不必多说。
感生电动势：$E_i=-\frac{d\Phi}{dt}=\iint_S\frac{\vec{dB}}{dt}\cdot\vec{dS}$不必多说。
感生电场：总是形成闭合回路，感生电流产生的磁场阻碍原磁通量的变化（楞次定律）
$$ \int_lE_B\cdot dl=-\iint_S \frac{dB}{dt}dS $$
特别地，对于圆柱体磁场区域：
- $r\leqslant R,E_B=-\frac{r}2\frac{dB}{dt}$
- $r\geqslant R,E_B=-\frac{R^2}{2r}\frac{dB}{dt}$
当 **感生电动势** 和 **动生电动势** 都存在时，需要求**偏导**(其中 $I$ 和 $x$ 都是对于时间 $t$ 的函数)：
$$
\begin{align}
\Phi &= \frac{\mu_0I}{2\pi}l_1 [\ln(x+l_2)-\ln(x)]\\
E&=-\frac{d\Phi}{dt}\\
&=-\frac{\partial \Phi}{\partial x}\frac{dx}{dt}-\frac{\partial \Phi}{\partial I}{dI}{dt}\\
\end{align}
$$
### 4.2 自感与互感
当一个线圈（称为初级线圈或回路 1）中的电流发生变化时，它产生的变化的磁场会在另一个邻近的线圈（称为次级线圈或回路 2）中**感应出电动势**。这种现象就是互感。
$$
\begin{align}
自感系数L&=\frac{\Psi}I\\
自感电动势E_L&=-\frac{d\Psi}{dt}=-L\frac{dI}{dt}
\end{align}
$$
单位：$1H=1Wb\cdot A^{-1}=1V\cdot s\cdot A^{-1}$
密绕螺线管：$L=\frac{\Psi}I=\mu\frac{N^2}lS=\mu n^2V(V是管体积)$
$$
\begin{align}
互感系数M_{12}=M_{21}=M\\
E_{21}=-\frac{d\Psi_{21}}{dt}=-M\frac{dI_1}{dt}\\
E_{12}=-\frac{d\Psi_{12}}{dt}=-M\frac{dI_2}{dt}\\
\end{align}
$$
一般地，$M=k\sqrt{L_1L_2}$，耦合系数$k$：$0\le k\le 1$，完美耦合：$M=\mu n_1n_2V=\sqrt{L_1L_2}$。
$\Psi_{12}$是线圈2在线圈1产生的磁链。
### 4.3 磁场的能量与电场的能量
真空中$\mu$换为$\mu_{0}$即可。
$$
\begin{align}
W_m&=\frac12LI^2\\​
w_m&=\frac{W_m}V\\&=\frac{B^2}{2\mu}=\frac12\mu H^2=\frac12 BH\\ \\
w_e&=\frac{1}{2} \varepsilon E^2
\end{align}
$$
单位分别为$J$、$J/m^3$。
# 电磁场与电磁波
## 1 全电流
$\Phi_{D}$是电位移通量，单位为C。
$\vec{j_{D}}=\frac{\partial\vec D}{\partial t}$是位移电流密度。
$$
\begin{align*}\\
I_{D}&=\frac{d\Phi_{D}}{dt},\Phi_{D}=\iint_{S}\vec{D}\cdot \vec{S},\\
I_S&=I_C+I_D\\
&=\iint_S\vec{j_C}\cdot d\vec S+\iint_S\frac{\partial \vec D}{\partial t}\cdot d\vec S\\\\
\oint_l\vec H\cdot d\vec l=I_S&=I_C+I_D=\iint_S\vec{j_C}\cdot d\vec S+\iint_S\frac{\partial\vec D}{\partial t}\cdot d\vec S\\
\end{align*}
$$
位移电流仅由**变化的电场**所引起，它既可以**沿导体传播**，也可以脱离导体**在真空中传播**，但**不产生焦耳热**。
介质的电磁性质：
$$
\begin{align}
D=\varepsilon E=\varepsilon_0\varepsilon_rE\\
B=\mu H=\mu_0\mu_rH\\
j_C=\sigma E\\
\end{align}
$$
$$
\begin{align}
波速u=\frac1{\sqrt{\varepsilon\mu}},真空中c=\frac1{\sqrt{\varepsilon_0\mu_0}}\\
\end{align}
$$
## 2 电磁波的产生与传播
### 2.1 LC震荡电路
$$
\begin{align}
\omega^2&=\frac1{LC}\\
T&=2\pi\sqrt{LC}\\
E_总&=E_e+E_m=\frac12LI_0^2=\frac{Q_0^2}{2C}\\
\end{align}
$$
### 2.2 电磁波的波动方程
波场中任一点的$\vec H$和$\vec E$相互垂直，传播方向$\vec r$沿$\vec E\times\vec H$​的方向
把握好$\frac{p_0\omega^2}{4\pi r}$即可以及$\frac EH=\sqrt\frac\mu\varepsilon$即可。
$$
\begin{align}
E&=\mu\cdot\frac{p_0\omega^2}{4\pi r}\sin\theta\cos\omega(t-\frac ru)=E_0\cos\omega(t-\frac ru)\\
H&=\sqrt{\varepsilon\mu}\frac{p_0\omega^2}{4\pi r}\sin\theta\cos\omega(t-\frac ru)=H_0\cos\omega(t-\frac ru)\\
\frac EH&=\sqrt\frac\mu\varepsilon\\
\end{align}
$$
- 介质折射率：$n=\frac{c}{u}=\sqrt{\varepsilon_r\mu_r}$
### 2.3 电磁波的能量
电磁波的平均能量密度（$J/m^3$）：
$$
\bar w=\frac{1}{2}\varepsilon E_{0}^2=\frac{1}{2}\mu H_0^2=\frac{1}{2u}E_0H_0
$$
电磁波的能流密度（$W/m^2$）/强度：在**单位时间**内，电磁波通过与波的传播方向**垂直**的**单位截面内**的电磁波的**能量**。
$\vec S$的方向是电磁波的传播方向。
$$
\begin{align}
\vec S&=\vec E\times \vec H\\
I=\bar S&=\bar wu=\frac12\sqrt\frac\varepsilon\mu E_0^2=\frac12E_0H_0\\
\end{align}
$$
电磁波的动量$\frac{\text{kg}}{\text{s} \cdot \text{m}^2}$：方向与$\vec S$一致。
$$
P=\frac{w}{c}=\frac{EH}{c^2}
$$
# 光学
## 1 光的干涉
### 1.1 分波阵面干涉
$$\begin{align}\\
\delta=d\sin\theta_{k}&=k\lambda\\ \\
有透镜：x_{k}&=f \tan{\theta_{k}},\Delta x=\frac{f\lambda}{d} \\
无透镜：x_{k}&=D \tan{\theta_{k}},\Delta x=\frac{D \lambda}{d} \\​
\end{align}
$$
明暗纹条件：
$$
\delta=\left\{
\begin{matrix}
\begin{align*}
&\pm k\lambda&&明\\
&\pm\frac{(2k+1)\lambda}2&&暗\\
\end{align*}
\end{matrix}
\right.
$$
![InterferenceExperiments|900](InterferenceExperiments.png)
尤其注意菲涅尔双棱镜分波面干涉，其中$\delta$是顶角（rad），$n$是棱镜的折射率，$R$是狭缝光源到棱镜的距离，$L$是棱镜到观察屏的距离。
例题参见17.18。

### 1.2 分振幅干涉
记住折射定律：
$$
n_{1}\sin i=n_{2}\sin r
$$
把握分振幅干涉的通式：
$$
\delta = 2ne \cos r + \psi
$$
其中$r$是在薄膜内部的反射角。
#### 1.2.1 薄膜干涉
不论是反射光还是透射光干涉都是如此：
$$
\begin{align*}
\delta_{反} &= \delta_0 + \delta_{反'} \\
&= 2n_{2}e\cos r+\delta_{反'}\\
&= 2e\sqrt{n_2^2 - n_1^2\sin^2 i} + 
\begin{cases}
0 & \text{反射状态相同} \\
\frac{\lambda}{2} & \text{反射状态不同}
\end{cases} \\
&= 
\begin{cases}
k\lambda & \text{明纹（相长干涉）} \\
(k-\frac12)\lambda& \text{暗纹（相消干涉）}
\end{cases}
\end{align*}
$$
#### 1.2.2 等倾干涉
$n$是介质折射率：
吐级现象：每吐出1个条纹，厚度增加$\frac{\lambda}{2n}$
吞级现象：每吞进1个条纹，厚度减小$\frac{\lambda}{2n}$
其中，迈克耳孙干涉仪：
$$
\begin{align}
\Delta h=\frac{N\lambda}{2}
\end{align}
$$
迈克耳孙干涉仪每一束光加入介质时，光程差的变化量要乘2。
例题：[[例题#1.1.1]][[例题#1.1.2]]
#### 1.2.3 非平行膜的等厚干涉
劈尖干涉：中间是空气薄膜，两玻璃片的交棱处有半波损失是暗条纹
因相邻两个条纹（等厚线）所对应的薄膜的厚度差均为$\frac{\lambda}{2}$。

$$
\tan \theta = \frac{\lambda}{2\Delta x}\\
$$
牛顿环：也有半波损失，中心是暗条纹
$$
\begin{align}
r_{k,明}=\sqrt{\frac{(k-\frac12)R\lambda}{n}} \\
r_{k,暗}=\sqrt{\frac{kR\lambda}{n}}
\end{align}
$$
$R$是元件的曲率半径。

## 2 光的衍射
### 2.1 单缝衍射
单缝衍射暗纹公式：
$$
a\sin\theta=\pm k\lambda\\
$$
单缝衍射明纹估算式：
$$
a\sin\theta=\pm(2k+1)\frac{\lambda}{2}\\
$$
**无论明纹还是暗纹，其角分布均取决于比值$\frac{\lambda}{a}$**。最中间的是第0级亮纹。
第 $k$ 级暗纹在屏幕上的位置：$x_k = k \frac{f \lambda}{a}$
故，中央亮纹线宽度：$\Delta x_{0}=\frac{2f\lambda}a$；其余各级亮纹线宽度：$\Delta{x_k}=\frac{f\lambda}{a}$
### 2.2 光栅方程
$$
d\sin\theta=k\lambda\ (k=0,\pm 1,\pm 2,\cdots)
$$
$d$：相邻狭缝间距。$k$：亮纹级数，最中间是亮纹（主极大）。$\theta$：衍射角，某一级衍射光与光栅法线之间的夹角。
> [!tip]
> $\theta$取$90^{\circ}$即用于计算最大级数。$\frac{1}{d}$就是每毫米的级数。
> **“第$k$级主极大”**  指的是光栅衍射图样中第$k$级亮纹。

### 2.3 缺级现象
$$
k=\frac{d}{a}k'
$$
$a$是狭缝宽度。此式成立，即满足缺级。
> [!note]
将光栅衍射与单缝衍射两式相比即可（$\theta$是相同的，消去）。第0级不会缺级。

### 2.4 圆孔衍射
光经过圆孔不是一个点，而是一个有亮心的光斑（爱里斑）。如果两个物体的爱里斑离得太近，重叠到一定程度就分不清了。
$$
\begin{align}
\theta_{min} &= 1.22 \frac{\lambda}{D} \\
\Delta x&=\theta_{min} f \\
d &\approx 2L \theta = 2.44 \frac{\lambda L}{D}
\end{align}
$$
若要计算单位面积内爱里斑的数量，则可以使用$N=\frac{1}{\Delta x^2}$。
$L$与$f$在衍射中常常地位相同。

## 3 光的偏振
从自然光获得偏振光的过程称为**起偏**，检验光波是不是线偏振光的过程称为**检偏**。
>[!importaant] 自然光通过偏振片后光强变为一半。
### 3.1 偏振度
$$
\text{偏振度}P=\frac{I_{max}-I_{min}}{I_{max}+I_{min}}\\
$$
### 3.2 马吕斯定律
强度为$I_0$的线偏振光经偏振片后的光强：
$$
I=I_0\cos^2\alpha\\
$$
### 3.3 双折射
光射到各向异性的透明晶体上时，一束入射光会有两束折射光，这称为双折射现象。其中一条折射光遵守折射定律，这条光线称为寻常光（ordinary ray），又称为 o 光；另一条折射光线不遵守折射定律，这条光线称为非常光（extraordinary ray），又称为 e 光。
由于它们在晶体中的传播速度不同（折射率不同），穿过厚度为$d$的晶体后会产生一个光程差。
$$
\begin{align}
\delta=|n_{o}-n_{e}|\cdot d\\
\Delta\phi=\frac{2\pi}{\lambda}\cdot\delta
\end{align}
$$
λ/4 波片的条件：要使波片成为四分之一波片，需要相位差 $\Delta\phi=\frac{\pi}{2}+2k\pi$。

### 3.4 布儒斯特定律
当反射光与折射光刚好成 90° 时，反射光就是纯净的线偏振光，偏振方向垂直于入射面。此时的入射角 $i_B$ 称为**起偏振角**，满足：

$$\tan i_B = \frac{n_2}{n_1}$$
$n_1$：光所在的介质（通常是空气 $n=1$）。
$n_2$：射入的介质（如玻璃、水）。

# 狭义相对论
## 1 两条基本原理
1. 相对性原理
    物理定律在所有的惯性系中都有相同的表达式
2. 光速不变原理
    在任何惯性系中，光在真空中的速率都等于c他与观察者和光源的运动无关
## 2 洛伦兹时空坐标变换
> [!important] 谨记：$v$ 代表 $S'$ 系相对于 $S$ 系沿 $x$ 轴正方向的速度。

$$
\begin{matrix}
\left\{
\begin{aligned}
&x'=\gamma(x-vt)&x=\gamma(x'+vt')\\
&t'=\gamma(t-\frac{v}{c^2}x)&t=\gamma(t'+\frac{v}{c^2}x')\\
\end{aligned}
\right.
\end{matrix}\\
$$
$$
\gamma = \frac{1}{\sqrt{1-\frac{v^2}{c^2}}}\\
$$
- 时空是密不可分的整体
- 时空并不是绝对的，而是与物质的运动相关
- $c$为极限速度，当$v>c$时，整个式子无意义。
- $v\ll c$可转化为伽利略坐标变换
## 3 洛伦兹速度变换
> [!important] $u_x$ 是在 $S$ 系的速度，$v$ 是 $S'$ 相对于 $S$ 的速度。
$$
\begin{matrix}
\left\{
\begin{aligned}
&u'_x=\frac{u_x-v}{1-\frac{v}{c^2}u_x}
&u_x=\frac{u'_x+v}{1+\frac{v}{c^2}u'_x}\\
&u'_y=\frac{u_y}{\gamma(1-\frac{v}{c^2}u_x)}
&u_y=\frac{u'_y}{\gamma(1+\frac{v}{c^2}u'_x)}\\
&u'_z=\frac{u_z}{\gamma(1-\frac{v}{c^2}u_x)}
&u_z=\frac{u'_z}{\gamma(1+\frac{v}{c^2}u'_x)}\\
\end{aligned}
\right.
\end{matrix}
$$
> [!note]
> 其实这两种形式很好记忆，就是v变成-v而已，也就是一个参考系相对于另一个参考系的速度。
## 4 狭义相对论的时空观
1. 同时的相对性
2. 长度收缩
3. 时间膨胀
### 4.1 同时的相对性
根据空间间隔和时间间隔可知：
$$
\begin{matrix}
\left\{
    \begin{aligned}
    &\Delta x'=\gamma(\Delta x-v\Delta t)\\
    &\Delta t'=\gamma(\Delta t-\frac{v}{c^2}\Delta x)\\
    \end{aligned}
\right.
\end{matrix}
$$
1. 在$S$系中两个同地同时的事件，在其他系中仍然同地同时
2. 在$S$系中同一地点先后发生的两个事件，在其他系中时序不变
3. 在$S$系中不同地点同时发生的两个事件，在其他系中一定不同时
4. 对于两个没有关联的独立事件，时序是相对的
> [!note]
> $\Delta t$和$\Delta t'$之间的正负关系，其实决定了一个事件在不同参考系下的发生顺序
### 4.2 时间延缓
- **适用场景**：当你关注的是同一个时钟（或同一个地点发生的两个事件）的时间间隔时。
- **判断标准**：**原时 ($\Delta \tau$)**：在某个参照系中，这两个事件发生在**同一个空间位置**。
$$
\tau = \gamma\tau_0=\frac{\tau_0}{\sqrt{1-\frac{v^2}{c^2}}} > \tau_0
$$
- 固有时间$\tau_0$最短，运动时钟变慢了
- 时间测量具有相对性，运动时钟变慢效应是互逆的
### 4.3 长度收缩
**判断标准**：**原长 ($L_0$)**：物体在与其**相对静止**的参照系中的长度。
$$
L=\frac{L_0}{\gamma}=L_0\sqrt{1-\frac{v^2}{c^2}}<L_0
$$
- 固有长度最长，动尺$L$**在运动方向收缩，在垂直运动方向无收缩效应**
- 长度收缩效应是互逆的
## 5 狭义相对论动力学
### 5.1 质速关系
在相对论中，**速度 $v$** 是一个**结果**，而**总能量 $E$**（或总质量 $m$）才是**本质**。速度 $v$ 只是描述了粒子所具有的**总能量**与**静止能量**之间的数学关系（通过 $\gamma$ 因子）。你不是拥有了两种不同的东西（质量和速度），你只是拥有了**一种东西（能量）**，而它必须同时用两种方式（质量增加和速度增加）来体现，才能保证光速不变原理在宇宙中成立。
$$
\begin{align}
m=\gamma m_0\\
\end{align}
$$
v:物体运动速度的大小，m_0:物体的静止质量，m:物体的动质量

**动能 $E_k$ 和附加质量 $\Delta m$ 是完全等价的。** 它们之间只差一个 $c^2$ 的单位转换因子。当你给粒子一个能量时 ( $E_k$ )：在数学上，你增加了它的**速度 $v$**。在物理上，你增加了它的**运动质量 $m$**。
关系链条：
$$\text{施加能量 } \rightarrow \text{ 增加动能 } E_k \longleftrightarrow \text{ 增加附加质量 } \Delta m \longleftrightarrow \text{ 增加速度 } v$$
- 动质量恒大与静质量
- 若$v=c$，粒子的静质量必须为0，否则动质量会是无穷大
光子的速率为$c$，光子的静质量为0
### 5.2 相对论动力学基本方程
$$
\vec p=m\vec v=\gamma m_0\vec v\\
\vec F=\frac{d\vec p}{dt}=m\frac{d\vec v}{dt} + \vec v\frac{dm}{dt}\\
E_k=mc^2-m_0c^2=\gamma m_0c^2-m_0c^2\\
$$
> 相对论中，物体的质量不能看作常量，这能表明，力的作用不仅能改变速度，还能改变质量。
### 5.3 质能关系
$$
\begin{align*}
&动能：E_k=mc^2-m_0c^2\\
&静能：E_0=m_0c^2\\
&总能：E=mc^2\\
\end{align*}
$$
### 5.4 能量与动量的关系
$$
E^2=P^2c^2+E_0^2\\
$$
### 5.5 动量与动能的关系
$$
P=\sqrt{2m_0E_k(1+\frac{E_k}{2m_0c^2})}\\
$$
**对于光子：**
- 作为波，频率$\nu$，波长$\lambda$
- 作为粒子，$m_0=0,E=h\nu,P=\frac{E}{c}=\frac{h}{\lambda}$


# 早期量子论
## 1 黑体辐射 普朗克能量子假设
单色辐出度$e(\lambda,T)$：温度为T 的物体在单位时间内、从物体单位表面积上辐射出的波长在$\lambda$附近单位波长间隔内的电磁能量
辐出度$E(T)$：指**温度为T**的辐射体，在**单位时间**内、物体**单位表面积**上辐射出的各种波长电磁波的总能量，对$e(\lambda,T)$沿着$T$积分而成，单位：$W/m^2$。
斯特藩—玻尔兹曼定律：$$
E_{B}(T)=\sigma T^4
$$$\sigma=5.67\times 10^{-8}W\cdot m^{-2} \cdot K^{-4}$。斯特藩—玻耳兹曼常量。
维恩位移定律：在任一温度下，黑体的单色辐出度有一最大值，与这一最大值对应的波长称为峰值波长，而且随着温度T 的升高，峰值波长向短波方向移动。实验测得两者的关系为
$$
\lambda_{m}T=b
$$
$b=2.898\times 10^{-3}m\cdot K$。维恩位移常量。

## 2 光电效应
$$
\frac{1}{2}m v_{m}^{2}=h\nu -A
$$
$A$：逸出功。

## 3 康普顿效应
![[大学物理学/assets/大学物理B(下)知识点总结/assets-.png]]
$$
\begin{align}
p&=\frac{h}{\lambda} \\
\varepsilon&=h\nu \\
\Delta\lambda=\lambda-\lambda_{0}&=\frac{h}{m_{0}c}\left(1-\cos\theta\right) \\
&=\frac{2h}{m_{0}c}\sin^{2}\frac{\theta}{2}
\end{align}
$$
![[大学物理学/assets/大学物理B(下)知识点总结/assets- 1.png]]
由动量守恒还有：
$$
\begin{align}
p_e &= \sqrt{p_\lambda^2 + p_{\lambda 0}^2 - 2 p_\lambda p_{\lambda 0} \cos \varphi} \\
&= \sqrt{(\frac{h}{\lambda})^2 + \left(\frac{h}{\lambda_0}\right)^2 - 2 \frac{h^2}{\lambda \lambda_0} \cos \varphi}
\end{align}
$$

## 4 玻尔的氢原子理论
$$  
\sigma=\frac{1}{\lambda}=R_H(\frac{1}{m^2}-\frac{1}{n^2})  
$$
$n=1$时，$E_1=-13.6eV$为基态。
否则为激发态，显然
$$
E_n=\frac{E_1}{n^2}
$$
欲将电子脱离原子，需要
$$
E_{\infty}-E_1=13.6eV
$$
的电离能。
$$
\begin{align}
v_n&=\frac{e^2}{2\epsilon hn}\\
r_n&=\frac{\epsilon_0 h^2}{\pi m_ee^2}n^2
\end{align}
$$
# 量子力学基础
## 1 德布罗意物质波
由$E=h\nu,p=\frac{h}{\lambda}$
$$  
E=mc^2=\frac{m_0c^2}{\sqrt{1-(\frac{v}{c})^2}},p=mv=\frac{m_0v}{\sqrt{1-(\frac{v}{c})^2}}  
$$
得
$$  
\lambda=\frac{h}{p}=\frac{h}{\frac{m_0v}{\sqrt{1-(\frac{v}{c})^2}}}=\frac{h}{\sqrt{2m_0E_k(1+\frac{E_k}{2m_0c^2})}\\}  
$$
当$E_k<<m_0c^2$有
$$  
\lambda=\frac{h}{\sqrt{2m_0E_k}}  
$$
对于物质波，**只能**用上述公式求波长。

## 2 不确定关系
### 2.1 位置和动量的不确定关系
位置的不确定量$\Delta x$与该方向上动量的不确定量$\Delta P_x$满足
$$  
\Delta x\Delta p_x\ge\frac{\hbar}{2}  
$$
其中$\hbar=\frac{h}{2\pi}$。
### 2.2 能量和时间的不确定关系
若某个激发态的能级宽度$\Delta E$，平均寿命$\Delta t$，则
$$  
\Delta E\Delta t\ge\frac{\hbar}{2}  
$$
能级宽度$\Delta E$与谱线宽度$\Delta \lambda$有如下关系：
$$  
E=\frac{hc}{\lambda}\\ \Delta E=\left|\frac{\ce d E}{\ce d\lambda}\right|\Delta\lambda=\frac{hc}{\lambda^2}\Delta\lambda  
$$
## 3 波函数
### 3.1 自由粒子的波函数
沿x方向做匀速直线运动的一维自由粒子的波函数为

$$  
\Psi(x,t)=Ae^{-\frac{i}{\hbar}(Et-px)}  
$$
沿$\vec r$方向做匀速直线运动的一维自由粒子的波函数为
$$  
\Psi(\vec r,t)=Ae^{-\frac{i}{\hbar}(Et-\vec p\cdot\vec r)}  
$$
### 3.2 波函数的条件
归一化条件
$$  
\iiint_V|\Psi(\vec r,t)|^2\ce dV=\iiint_V\Psi\Psi^*\ce dV=1  
$$
其中
$$  
P(\vec r,t)=|\Psi(\vec r,t)|^2  
$$
单射，有限，连续。
### 3.3 一维无限深势阱能级
$$
E_n = \frac{n^2 h^2}{8ma^2}
$$