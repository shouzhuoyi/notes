# 计算理论导引

> 武汉大学 2025-2026 学年 2024 级弘毅班《计算理论导引》课程笔记与学习资源

## 📚 项目简介

本仓库是《计算理论导引》课程的完整学习资源库，由 **kiwiizzz(易守拙)** 和 **xhkzdepartedream(杨研亮)** 共同维护。包含课程笔记、作业解答、课件资源等，旨在为后来者提供系统性的学习参考。

## 📁 文件结构

本课程只会用到`0. Introduction.pdf` `1. Time Complexity.pdf` `2. NP Completeness.pdfSpace` `3. Complexity.pdf`四个课件。

```
计算理论导引-typst/
├── 核心笔记（Typst格式）/
│   ├── main.typ              # 笔记入口文件
│   ├── chap1.typ             # 第1章：时间复杂性
│   ├── chap2.typ             # 第2章：NP完全性
│   ├── chap3.typ             # 第3章：空间复杂性
│   ├── karp21.typ            # Karp 21个NPC问题
│   ├── review.typ            # 复习材料
│   ├── review-no-ans.typ     # 无答案复习题
│   └── test.typ              # 测试文件
├── 作业-kiwiizzz/           # kiwiizzz的作业（Typst格式）
│   ├── 2024300001103-易守拙-第二次作业.pdf
│   ├── 2024300001103-易守拙-第五次作业.pdf
│   ├── fuck_i_use_typst_for_hw.pdf
│   ├── fuck_i_use_typst_for_hw.typ
│   ├── hw1206.typ
│   └── Overleaf_Homework_Template/  # LaTeX作业模板
├── 作业-xhkzdepartedream/   # xhkzdepartedream的作业（Markdown格式）
│   ├── hw1.pdf              # 第1次作业（PDF）
│   ├── hw2.md               # 第2次作业
│   ├── hw3.md               # 第3次作业
│   ├── hw4.md               # 第4次作业
│   └── hw5.md               # 第5次作业
├── 计算复杂性- SJTU/        # 来自SJTU的课程官方资源
│   ├── 课件/                # 11个PDF课件
│   │   ├── 0. Introduction.pdf
│   │   ├── 1. Time Complexity.pdf
│   │   ├── 2. NP Completeness.pdf
│   │   ├── 3. Space Complexity.pdf
│   │   ├── ......
│   ├── 导读/
│   └── 测试/
├── image/                   # 图片
├── Final Exam Instructions.txt  # 2025-2026期末考试范围
├── 2025-2026 Final Exam.txt  # 2025-2026期末考试真题
└── modified_dvd.typ         # 修改后的Typst模板
```

## 📖 内容概览

### 核心笔记章节

1. **第1章：时间复杂性**
   - 图灵机基本概念
   - 时间可构造函数
   - 通用图灵机
   - 时间谱系定理
   - 线性加速定理

2. **第2章：NP完全性**
   - NP类定义
   - Cook-Levin定理
   - Karp 21个NPC问题
   - 规约技术
   - 近似算法

3. **第3章：空间复杂性**
   - 空间可构造函数
   - 空间谱系定理
   - Savitch定理
   - PSPACE完全性
   - 对数空间归约

### 特色内容

- **karp21.typ**：详细分析Karp提出的21个经典NPC问题
- **review.typ**：包含答案的复习材料
- **review-no-ans.typ**：无答案的复习题，适合自测

## 🛠️ 技术栈

本仓库主要使用 **Typst** 排版系统，具有以下优势：
- 语法简洁，学习曲线平缓
- 编译速度快
- 支持高质量的数学公式排版
- 便携性介于Markdown和LaTeX之间

### 使用的Typst包
```typst
#import "@preview/dvdtyp:1.0.1"    # 文档模板
#import "@preview/numbly:0.1.0"    # 编号系统
#import "@preview/thmbox:0.3.0"    # 定理框样式
#import "@preview/cuti:0.2.1"      # 中文伪粗体
#import "@preview/mitex:0.2.5"     # 数学公式支持
```

## 📝 使用指南

### 查看与编译笔记

请按照typst官方教程或vscode配置typst环境的指南搭建环境，按照指引自行编译pdf文件。

### 作业资源

附带两位笔记作者的作业。仅供参考，严禁抄袭！

## 🤝 贡献指南

欢迎后来者继续维护和完善本仓库：

1. **修正错误**：如发现笔记中的错误或疏漏，请提交Issue或Pull Request
2. **补充内容**：可以添加新的例题、习题解答或扩展阅读
3. **格式优化**：改进排版或添加新的Typst样式

## 📄 许可证

本仓库内容遵循 [MIT License](LICENSE) 开源协议。

## 💭 写在最后

> 这门课程难度很大，请一定参照书本弄清定义。但也不要因为课上听得一头雾水而放弃，最后的考试一定会给每个认真准备的同学一份满意的结果。——xhkzdepartedream

希望这份笔记能帮助你更好地学习计算理论导引这门课程，也希望我们的笔记对大家有所帮助。才疏学浅，时间仓促，难免有疏漏之处，恳请广大读者不吝批评修正。

**祝学习顺利！** 🚀
