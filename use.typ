// 学生操作指南：编译本文件可得到可阅读的 PDF；实验报告只编辑 main.typ。
#import "utilities/machine-learning-report.typ": machine-learning-report
#import "utilities/three-line-table.typ": three_line_table
#show: machine-learning-report.with(
  course: "机器学习",
  semester: "模板使用指南",
  class: "示例班级",
  student-id: "示例学号",
  name: "示例学生",
  teacher: "示例教师",
  date: "2026 年 10 月 14 日",
  toc-note: [本文件展示机器学习实验报告模板的常用写法。正文中的图、表和代码会按所属的一级标题分别编号。],
)

= 模板使用指南

本文件是操作指南，示例会实际排版出来。写报告时请编辑 `main.typ`，编译命令如下：

```sh
typst compile main.typ 实验报告.pdf
typst compile use.typ 使用指南.pdf
```

== 填写封面与目录说明

在 `main.typ` 顶部的 `#show: machine-learning-report.with(...)` 中填写课程、学期、班级、学号、姓名、教师和日期。日期使用普通文字，按需要修改即可。`toc-note` 中的段落会出现在目录页，每段自动首行缩进 2em。封面和目录的版式由模板生成。

```typ
#import "utilities/machine-learning-report.typ": machine-learning-report
#show: machine-learning-report.with(
  course: "机器学习",
  semester: "2025-2026 第二学期",
  class: "24 计算机科学与技术 1 班",
  student-id: "202211001",
  name: "张三",
  teacher: "刘老师",
  date: "2026 年 9 月 1 日",
  toc-note: [
    第一段目录说明。

    第二段目录说明。
  ],
)
```

== 标题、正文与分页

`=` 是实验标题，只有这一层会进入自动目录。`==` 是实验内的小节，`===`、`====` 可继续细分。标题样式、正文大小和行距均由模板控制，写作时不必手动设置。空一行开始新段落；`*文字*` 表示加粗，`_文字_` 表示斜体。

```typ
= 实验一 训练线性回归预测模型
== 实验目的
=== 数据准备
==== 缺失值处理

这是正文第一段。

这是正文第二段，*这里加粗*，_这里斜体_。

#pagebreak() // 从下一页继续
```

需要强制另起一页时，在新页内容前写 `#pagebreak()`。新增实验时继续写一个 `=` 标题，目录会自动更新；不要手工填写目录条目。

== 无序列表与有序列表

行首 `-` 创建无序列表，行首 `+` 创建有序列表。两种列表都可以嵌套；缩进下一层即可。实验目的常用有序列表。

```typ
- 准备数据
- 训练模型
  - 检查输入特征
  - 拟合参数

+ 理解数据分析过程。
+ 训练线性回归模型。
+ 评价预测结果。
```

无序列表示例：

- 准备数据
- 训练模型
  - 检查输入特征
  - 拟合参数

有序列表示例：

+ 理解数据分析过程。
+ 训练线性回归模型。
+ 评价预测结果。

#pagebreak()

== 单图与图片引用

把图片放进 `figures` 文件夹。用 `#figure` 插入图片并写图题；紧跟在图后的 `<fig:sample>` 是标签，正文用 `@fig:sample` 引用。图按当前一级标题编号，如实验一中的第一张图为“图 1-1”；标签名称可自行修改，但同一篇报告中不能重复。

```typ
如 @fig:sample 所示，图中展示了实验结果。

#figure(
  image("figures/示例图片1.png", width: 55%),
  caption: [实验结果示例],
)<fig:sample>
```

如 @fig:sample 所示，下图是单图示例。

#figure(
  image("figures/示例图片1.png", width: 45%),
  caption: [实验结果示例],
)<fig:sample>

#pagebreak()

== 双图并排与引用

将两个 `image` 放进两列 `grid`，再用一个 `figure` 包起来。`@fig:compare` 引用整组双图；图下的（a）、（b）说明左右图片。调整 `width` 可改变图片大小。

```typ
#figure(
  grid(
    columns: (1fr, 1fr),
    column-gutter: 8pt,
    row-gutter: 4pt,
    image("figures/示例图片2.png", width: 100%),
    image("figures/示例图片1.png", width: 100%),
    align(center)[（a）原始结果],
    align(center)[（b）对照结果],
  ),
  caption: [两种结果对比],
)<fig:compare>

正文写：见 @fig:compare。
```

如 @fig:compare 所示，可以把两张图放在同一图题下。

#figure(
  grid(
    columns: (1fr, 1fr),
    column-gutter: 8pt,
    row-gutter: 4pt,
    image("figures/示例图片2.png", width: 100%), image("figures/示例图片1.png", width: 100%),
    align(center)[（a）原始结果], align(center)[（b）对照结果],
  ),
  caption: [两种结果对比],
)<fig:compare>

#pagebreak()

== 代码块与代码引用

普通代码可用三个反引号包起来，并在开头注明语言，例如 `py`。模板会将代码排为 8pt 的 DejaVu Sans Mono 字体。需要代码题注和自动引用时，沿用模板的带边框代码框，将代码放进 `figure` 并设置 `kind: raw`；正文中写 `@code:linear`。代码按当前一级标题编号，如“代码 1-1”。

```typ
#block(breakable: false)[
  #figure(
    block(width: 100%, inset: 8pt, stroke: 0.5pt, radius: 3pt)[
      #align(left)[
        #raw(
          "from sklearn.linear_model import LinearRegression\nmodel = LinearRegression()\nmodel.fit(X, y)",
          lang: "python",
        )
      ]
    ],
    kind: raw,
    caption: [线性回归训练代码],
  )<code:linear>
]

训练过程见 @code:linear。
```

训练过程见 @code:linear。

#block(breakable: false)[
  #figure(
    block(width: 100%, inset: 8pt, stroke: 0.5pt, radius: 3pt)[
      #align(left)[
        #raw(
          "from sklearn.linear_model import LinearRegression\nmodel = LinearRegression()\nmodel.fit(X, y)",
          lang: "python",
        )
      ]
    ],
    kind: raw,
    caption: [线性回归训练代码],
  )<code:linear>
]

也可直接在代码框里使用围栏代码。下例的标签为 `<code:basic>`，与上一段的标签不同。

#figure(
  block(width: 100%, inset: 8pt, stroke: 0.5pt, radius: 3pt)[
    #align(left)[
      ```py
      from sklearn.linear_model import LinearRegression
      model = LinearRegression()
      model.fit(X, y)
      ```
    ]
  ],
  kind: raw,
  caption: [围栏代码示例],
)<code:basic>

#pagebreak()

== 公式与公式引用

行内公式写在 `$...$` 中，例如 $y = beta_0 + beta_1 x$。独占一行的公式在 `$` 与内容之间留空格或换行。公式后添加标签，再用 `@eq:linear` 引用；公式也按当前一级标题编号，如“公式(1.1)”。

```typ
线性回归模型见 @eq:linear。

$
  y = beta_0 + beta_1 x
$ <eq:linear>
```

线性回归模型见 @eq:linear。

$
  y = beta_0 + beta_1 x
$ <eq:linear>

再以带 $L_2$ 正则化的逻辑回归损失函数为例，`@eq:logistic-loss` 演示求和、对数与分式的组合。这里 $m$ 是样本数，$d$ 是特征数，$p_i$ 是第 $i$ 个样本被预测为正类的概率。

```typ
$
  J(theta) = -frac(1, m) sum_(i=1)^m
    [y_i ln(p_i) + (1 - y_i) ln(1 - p_i)]
    + frac(lambda, 2m) sum_(j=1)^d theta_j^2
$ <eq:logistic-loss>
```

带正则化的损失函数见 @eq:logistic-loss。

$
  J(theta) = -frac(1, m) sum_(i=1)^m
  [y_i ln(p_i) + (1 - y_i) ln(1 - p_i)]
  + frac(lambda, 2m) sum_(j=1)^d theta_j^2
$ <eq:logistic-loss>

== 表格与引用

表格可用 `table` 创建；放进 `figure` 后就能加题注和标签。正文使用 `@tab:metrics` 引用。表按当前一级标题编号，如“表 1.1”。

```typ
#figure(
  table(
    columns: (1fr, 1fr),
    inset: 6pt,
    [*指标*], [*数值*],
    [均方误差], [$0.12$],
  ),
  kind: table,
  caption: [模型评估指标],
)<tab:metrics>
```

评估结果见 @tab:metrics。

#figure(
  table(
    columns: (1fr, 1fr),
    inset: 6pt,
    [*指标*], [*数值*],
    [均方误差], [$0.12$],
  ),
  kind: table,
  caption: [模型评估指标],
)<tab:metrics>

#pagebreak()

=== 三线表

需要三线表时，先在 `main.typ` 顶部导入模板自带的 `three_line_table` 函数。第一行是表头，后面的每一行是数据；每行的列数应相同。将三线表放入 `figure` 后，可像普通表格一样添加题注和标签，并用 `@tab:three-line` 引用。

```typ
#import "utilities/three-line-table.typ": three_line_table

#figure(
  three_line_table((
    ("模型", "均方误差", "决定系数"),
    ("线性回归", "0.12", "0.91"),
    ("岭回归", "0.10", "0.93"),
  )),
  kind: table,
  caption: [模型评估结果],
)<tab:three-line>
```

结果见 @tab:three-line。

#figure(
  three_line_table((
    ("模型", "均方误差", "决定系数"),
    ("线性回归", "0.12", "0.91"),
    ("岭回归", "0.10", "0.93"),
  )),
  kind: table,
  caption: [模型评估结果],
)<tab:three-line>
