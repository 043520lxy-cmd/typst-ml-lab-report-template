// 图表编号与题注样式。
// 编号逻辑参考 typst-template 的 i-figured 实现。

#let figure-table-numbering(body) = {
  let numbered-kind-prefix = "ml-report-numbered-"
  let numbered-label-prefix = "ml-report-numbered-label-"
  let caption-font = ("Times New Roman", "Heiti SC", "Heiti TC", "SimHei")

  // 将原生 figure 复制为带独立计数器的 figure。
  // 标签由 Typst 自动保留，因此 <fig:...>、<tab:...> 及其引用无需改动。
  let number-figure(it) = {
    if (
      type(it.kind) == str and it.kind.starts-with(numbered-kind-prefix)
      or it.kind != image and it.kind != table
    ) {
      it
    } else {
      let heading-numbers = counter(heading).at(it.location())
      let chapter = heading-numbers.at(0, default: 0)
      // 用当前位置与本章一级标题处的原生计数器之差，得到本章序号。
      // 这样不会受嵌套 show 规则中计数器重置顺序的影响。
      let headings = query(heading.where(level: 1).before(it.location()))
      let before-chapter = if headings.len() == 0 {
        0
      } else {
        counter(figure.where(kind: it.kind)).at(headings.last().location()).first()
      }
      let current = counter(figure.where(kind: it.kind)).at(it.location()).first()
      let chapter-index = current - before-chapter
      let number-format = if it.kind == table { "1.1" } else { "1-1" }
      let fields = it.fields()
      let _ = if "body" in fields { fields.remove("body") }
      let _ = if "label" in fields { fields.remove("label") }
      let _ = if "counter" in fields { fields.remove("counter") }

      let result = figure(
        it.body,
        ..fields + (
          numbering: _ => numbering(number-format, chapter, chapter-index),
          supplement: if it.kind == image { [图] } else { [表] },
          kind: numbered-kind-prefix + repr(it.kind),
        ),
      )
      if it.has("label") {
        [#result #label(numbered-label-prefix + str(it.label))]
      } else {
        result
      }
    }
  }

  // 先为原图表设置题注属性，确保交叉引用也沿用“图”或“表”。
  show figure.where(kind: image): set figure(supplement: [图])
  show figure.where(kind: table): set figure(supplement: [表])
  show figure.where(kind: raw): set figure(supplement: [代码])
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption: set text(font: caption-font)
  set figure.caption(separator: " ")

  show figure: number-figure
  show ref: it => context {
    let target = str(it.target)
    let numbered-target = label(numbered-label-prefix + target)
    if query(numbered-target).len() > 0 {
      ref(numbered-target)
    } else {
      it
    }
  }

  body
}
