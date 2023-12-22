#import "@preview/polylux:0.3.1": *
#import "@preview/tablex:0.0.7": *

#let extra-light-gray = rgb("#FFFFFF")
#let m-dark-teal = rgb("#23373b")
#let m-light-brown = rgb("#eb811b")
#let m-lighter-brown = rgb("#d6c6b7")
#let m-extra-light-gray = white.darken(2%)

#let ovgu-red = rgb("#D13F58")
#let ovgu-purple = rgb("#7A003F")
#let ovgu-blue = rgb("#0068B4")
#let ovgu-darkgray = rgb("#606060")
#let ovgu-lightgray = rgb("#C0C0C0").lighten(50%)
#let ovgu-orange = rgb("#F39100")

#let m-footer = state("m-footer", [])
#let m-cell = block.with(width: 100%, height: 120%, above: 0pt, below: 0pt, breakable: false)

#let parcio-table(columns, rows, ..tablec) = {
  let header-data = tablec.pos().slice(0, columns)
  let rest = tablec.pos().slice(columns)

  table(
    columns: 1,
    stroke: none,
    style(
      styles => {
        let header = table(columns: columns, rows: 1, stroke: 0.5pt, align: center, ..header-data)
        let hw = measure(header, styles).width / columns

        header
        v(-1em)
        tablex(
          columns: (hw,) * columns,
          rows: rows - 1,
          stroke: 0.5pt,
          align: center,
          auto-hlines: false,
          hlinex(),
          ..rest,
          hlinex(),
        )
      },
    ),
  )
}

// TODO box.
#let todo = rect.with(fill: ovgu-orange, stroke: black + 0.5pt, radius: 0.25em, width: 100%)

// Start of theme rules.
#let parcio-theme(aspect-ratio: "16-9", footer: [], body) = {
  set page(
    paper: "presentation-" + aspect-ratio,
    fill: extra-light-gray,
    margin: 0em,
    header: none,
    footer: none,
  )

  set text(font: "Libertinus Sans")

  // Make URLs use monospaced font.
  show link: l => {
    if type(l.dest) == "string" {
      set text(font: "Inconsolata", 0.9em)
      l
    } else {
      l
    }
  }

  set footnote.entry(
    indent: 2.5em,
    separator: line(start: (2em, 0em), end: (40%, 0em), stroke: 0.5pt),
  )

  set list(indent: 20pt)
  m-footer.update(footer)

  body
}

#let m-progress-bar = utils.polylux-progress(ratio => {
  grid(
    columns: (ratio * 100%, 1fr),
    m-cell(fill: ovgu-purple),
    m-cell(fill: m-lighter-brown),
  )
})

#let title-slide(title: [], subtitle: none, author: (:), date: none, extra: none) = {
  let content = {
    set text(fill: m-dark-teal)
    show raw: set text(font: "Inconsolata", 1.15em)

    set align(horizon)

    v(-1em)
    block(width: 100%, inset: 2.5em, height: 100%, {
      table(
        columns: (1fr, 1fr),
        align: (left, right),
        stroke: none,
        inset: 0pt,
        text(size: 1.3em, strong(title) + v(-0.25em) + text(0.85em, subtitle)),
        image("ovgu.svg", width: 75%),
      )

      v(-0.5em)
      line(length: 100%, stroke: 1pt + ovgu-purple)
      v(2em)

      set text(size: .9em)
      if author != none {
        block(spacing: 1em)[
          #author.name\
          #link("mailto:" + author.mail, raw(author.mail))
        ]
      }
      if date != none {
        block(spacing: 1em, date)
      }
      if extra != none {
        block(spacing: 1em, extra)
      }
    })
  }

  m-footer.update(
    [#author.name#h(1fr)#title#h(1fr)#logic.logical-slide.display() / #utils.last-slide-number],
  )
  polylux-slide(content)
}

#let slide(
  title: none,
  new-section: none,
  show-current-section: true,
  show-footer: true,
  body,
) = {
  let header = {
    set align(top)
    if title != none {
      if new-section != none {
        utils.register-section(new-section)
      }

      show: m-cell.with(fill: ovgu-lightgray, inset: 1em)
      set align(horizon)
      [
        #text(fill: ovgu-blue, size: 1.1em)[*#title*]
        #if show-current-section [
          #h(1fr)
          #text(fill: ovgu-blue, size: 1em)[*#utils.current-section*]
        ]
      ]
    } else {
      strong("Missing Headline")
    }

    block(height: 1pt, width: 100%, spacing: 0pt, m-progress-bar)
  }

  let footer = if show-footer {
    show: pad.with(bottom: .25em, rest: 0.5em)
    set text(size: 0.7em)
    set align(bottom)

    text(fill: m-dark-teal, m-footer.display())
  }

  // Applies a similar theme with the ovgu colors using the tmTheme format.
  // It is very limited; using Typst's own highlighting might be more expressive.
  set raw(theme: "ovgu.tmTheme")
  show raw: set text(font: "Inconsolata", 1.1em)
  show raw: set par(leading: 0.75em)

  show raw.where(block: true): r => {
    show raw.line: l => {
      box(table(
        columns: (-1.25em, 100%),
        stroke: 0pt,
        inset: 0em,
        column-gutter: 1em,
        align: (x, y) => if x == 0 { right } else { left },
        text(fill: ovgu-darkgray, str(l.number)),
        l.body,
      ))
    }

    set align(left)
    rect(width: 100%, stroke: gray + 0.5pt, inset: 0.75em, r)
  }

  // Display supplement in bold.
  show figure.caption: c => [
    *#c.supplement #counter(figure.where(kind: c.kind)).display(c.numbering)#c.separator*#c.body
  ]

  set page(
    header: header,
    footer: footer,
    margin: (top: 3em, bottom: 1em),
    fill: m-extra-light-gray,
  )

  let content = {
    show: align.with(horizon)
    show: pad.with(2em)
    set text(fill: m-dark-teal)
    body
  }

  polylux-slide(content)
}

#let outline-slide(title: "Outline") = {
  logic.logical-slide.update(0)
  slide(title: title, show-footer: false)[
    #set enum(numbering: n => [], tight: false, spacing: 20%)
    #utils.polylux-outline()
  ]
}

#let bib-slide(title: "References") = slide(title: title, show-footer: false, show-current-section: false)[
  #bibliography(
    "../bibliography/report.bib",
    style: "../bibliography/apalike.csl",
    title: none,
    full: true,
  )
]

#let s(t: none, ns: none, body) = slide(title: t, new-section: ns, body)

