// 机器学习实验报告的正文样式。
// 改编自 cumcm-muban 0.4.0（Apache-2.0）：
// https://github.com/a-kkiri/CUMCM-typst-template
#import "@preview/cuti:0.3.0": show-cn-fakebold

#let songti = ("Times New Roman", "Songti SC", "Songti TC", "SimSun")
#let heiti = ("Times New Roman", "Heiti SC", "Heiti TC", "SimHei")
#let code-font = "DejaVu Sans Mono"

#let report-style(body) = {
  set text(font: songti, size: 12pt)
  show: show-cn-fakebold
  show raw: set text(font: code-font, 8pt)

  let heading-font = heiti
  let subheading-font = songti
  set heading(numbering: "1.1.1.1")
  set heading(supplement: [节])
  show heading: it => {
    if it != none {
      set par(first-line-indent: 0em)
      if it.level >= 3 {
        set text(weight: "bold", font: subheading-font, size: 12pt)
        set block(above: 1.5em, below: 1.5em)
      }
      if it.level == 1 {
        // 实验标题已经包含“实验一”等文字。
      } else if it.level == 2 {
        numbering("一、", counter(heading).at(it.location()).last())
      } else if it.has("numbering") and it.numbering != none {
        numbering(it.numbering, ..counter(heading).at(it.location()))
        []
      }
      it.body
    } else {
      ""
    }
  }
  show heading.where(level: 1): it => {
    set align(center)
    set text(weight: "bold", font: heading-font, size: 14pt)
    set block(spacing: 1.5em)
    it
  }
  show heading.where(level: 2): it => {
    set text(weight: "bold", font: heading-font, size: 13pt)
    set block(above: 1.5em, below: 1.5em)
    it
  }

  set math.equation(numbering: n => context numbering("(1.1)", counter(heading).get().first(), n))
  set math.equation(supplement: [公式])
  show math.equation: eq => {
    set block(spacing: 0.65em)
    eq
  }
  show math.equation: it => {
    show regex("[\\p{hani}\\s]+"): set text(font: songti)
    it
  }
  show ref: it => context {
    let targets = query(it.target)
    if targets.len() > 0 and targets.first().func() == math.equation {
      let target = targets.first()
      let numbers = counter(math.equation).at(target.location())
      let chapter = counter(heading).at(target.location()).first()
      link(it.target)[公式#numbering("(1.1)", chapter, ..numbers)]
    } else if targets.len() > 0 and targets.first().func() == figure {
      let target = targets.first()
      let chapter = counter(heading).at(target.location()).first()
      let number = counter(figure.where(kind: target.kind)).at(target.location()).first()
      if target.kind == image {
        link(it.target)[图#numbering("1-1", chapter, number)]
      } else if target.kind == table {
        link(it.target)[表#numbering("1.1", chapter, number)]
      } else if target.kind == raw {
        link(it.target)[代码#numbering("1-1", chapter, number)]
      } else {
        it
      }
    } else {
      it
    }
  }
  show figure.where(kind: raw): it => {
    set block(width: 100%, breakable: true)
    it
  }
  set par(
    first-line-indent: (amount: 2em, all: true),
    justify: true,
    leading: 1.24em,
  )
  set par(spacing: 1.24em)
  set list(tight: false, indent: 1em, marker: ([•], [◦], [•], [◦]))
  show list: set text(top-edge: "ascender")
  set enum(tight: false, indent: 1em)
  show enum: set text(top-edge: "ascender")

  body
}
