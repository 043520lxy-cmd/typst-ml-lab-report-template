// 机器学习实验报告版式。封面、目录与页眉页脚均由模板生成。
#import "report-style.typ": report-style

#let cover-label(left, right) = text(size: 22pt)[#left#h(55pt)#right]
#let cover-value(value) = block(
  width: 100%,
  height: 100%,
  stroke: (bottom: 0.48pt),
  inset: (top: 2pt, bottom: 4pt),
)[
  #align(center + horizon)[#text(size: 22pt)[#value]]
]

#let cover-form(course, semester, class, student-id, name, teacher) = pad(left: 25pt)[
  #grid(
    columns: (122pt, 295.9pt),
    rows: 33.3pt,
    column-gutter: 0pt,
    row-gutter: 0pt,
    align: (center + horizon, center + horizon),
    cover-label([课], [程]), cover-value(course),
    cover-label([学], [期]), cover-value(semester),
    cover-label([班], [级]), cover-value(class),
    cover-label([学], [号]), cover-value(student-id),
    cover-label([姓], [名]), cover-value(name),
    cover-label([教], [师]), cover-value(teacher),
  )
]

#let machine-learning-report(
  course: "机器学习",
  semester: "",
  class: "",
  student-id: "",
  name: "",
  teacher: "",
  date: datetime.today().display("[year] 年 [month padding:none] 月 [day padding:none] 日"),
  toc-note: [],
  body,
) = {
  set document(title: course + " 实验报告")
  set text(font: ("SimSun", "Times New Roman"), size: 14pt)
  set page(paper: "a4", margin: (top: 49.3pt, bottom: 3cm, left: 79.4pt, right: 2.7cm), header: none, footer: none)
  set par(justify: true, leading: 1.3em)

  // 封面
  align(left)[#image("../figures/xinyu-university-logo.jpeg", width: 7cm)]
  v(1.95cm)
  pad(left: 19pt)[
    #align(center)[
      #text(font: "SimSun", size: 26pt, weight: "bold", stroke: 0.02857em)[数学与计算机学院]
      #v(0pt)
      #text(font: "SimSun", size: 26pt, weight: "bold", stroke: 0.02857em)[实验报告]
    ]
  ]
  v(3.97cm)
  cover-form(course, semester, class, student-id, name, teacher)
  v(1fr)
  align(center)[#text(size: 22pt)[#date]]

  pagebreak()

  // 目录：只收录一级实验标题，标题和条目都不写在 main.typ 中。
  counter(page).update(1)
  set page(margin: (top: 1.2cm, bottom: 80pt, left: 79.5pt, right: 55pt), footer: align(center)[#text(size: 9pt)[Ⅰ]])
  line(length: 100%, stroke: 0.45pt)
  v(0.3cm)
  align(center)[#text(size: 17pt)[目　录]]
  v(0.35cm)
  context {
    for head in query(heading.where(level: 1)) {
      block(width: 100%, inset: (top: 7pt, bottom: 7pt), stroke: (bottom: 0.45pt))[
        #grid(
          columns: (1fr, auto),
          column-gutter: 8pt,
          link(head.location())[#head.body], str(counter(page).at(head.location()).first()),
        )
      ]
    }
  }
  v(1fr)
  v(-9pt)
  {
    set text(size: 15pt)
    set par(first-line-indent: (amount: 2em, all: true), leading: 1.5em, spacing: 1.5em)
    toc-note
  }

  pagebreak()
  counter(page).update(1)

  // 正文：一级标题原样显示；二级标题自动加“一、二、……”编号。
  show: report-style
  // 每个实验分别统计图片、表格和代码；题注与交叉引用共用同一编号。
  show heading.where(level: 1): it => {
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    counter(math.equation).update(0)
    it
  }
  show figure.where(kind: image): set figure(
    supplement: [图],
    numbering: n => context numbering("1-1", counter(heading).get().first(), n),
  )
  show figure.where(kind: table): set figure(
    supplement: [表],
    numbering: n => context numbering("1.1", counter(heading).get().first(), n),
  )
  show figure.where(kind: raw): set figure(
    supplement: [代码],
    numbering: n => context numbering("1-1", counter(heading).get().first(), n),
  )
  set figure.caption(separator: "   ")
  show figure.where(kind: table): set figure.caption(position: top)
  set page(
    margin: (top: 65pt, bottom: 1.8cm, left: 78pt, right: 55pt),
    header: block(width: 100%, height: 40pt)[
      #place(top + center, dy: 17.6pt)[#text(font: "SimSun", size: 10.5pt)[#(course + "实验报告")]]
      #place(top + left, dy: 28pt)[#line(length: 100%, stroke: 0.9pt)]
      #place(top + left, dy: 29.9pt)[#line(length: 100%, stroke: 1pt)]
    ],
    footer: align(center)[#text(size: 9pt)[#context counter(page).display("1")]],
  )
  set enum(numbering: "（1）")
  body
}
