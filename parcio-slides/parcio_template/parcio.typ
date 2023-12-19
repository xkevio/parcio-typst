#import "@preview/codelst:1.0.0": sourcecode
#import "@preview/polylux:0.3.1": *
#import "@preview/tablex:0.0.5": *

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
#let total_slide_count = counter("total_slide_count")

#let m-cell = block.with(
  width: 100%,
  height: 120%,
  above: 0pt,
  below: 0pt,
  breakable: false
)

// ~~stolen~~ migrated from github.com/xkevio/parcio-typst
#let src = sourcecode.with(
  gutter: 0em,
  frame: block.with(
    stroke: 0.5pt + gray, 
    inset: (x: 0.5em, y: 0.5em), 
    width: 100%,
  ),
  numbers-style: n => {
    set text(fill: ovgu-darkgray, font: "Inconsolata", 20pt)
    h(-1.5em) + n
  }
)

// ~~stolen~~ migrated from github.com/xkevio/parcio-typst
#let parcio-table(columns, rows, ..tablec) = {
  let header-data = tablec.pos().slice(0, columns)
  let rest = tablec.pos().slice(columns)
  
  table(columns: 1, stroke: none,
    style(styles => {
      let header = table(columns: columns, rows: 1, stroke: 0.5pt, align: center,
        ..header-data
      )
      let hw = measure(header, styles).width / columns

      header
      v(-1em)
      tablex(columns: (hw,) * columns, rows: rows - 1, stroke: 0.5pt, align: center,
          auto-hlines: false,
          hlinex(),
          ..rest,
          hlinex()
        )
    })
  )
}

// TODO box.
#let todo = rect.with(
    fill: ovgu-orange,
    stroke: black + 0.5pt,
    radius: 0.25em,
    width: 100%,
)

// Start of theme rules.
#let parcio-theme(
    aspect-ratio: "4-3",
    footer: [],
    body
) = {
    set page(
        paper: "presentation-" + aspect-ratio,
        fill: extra-light-gray,
        margin: 0em,
        header: none,
        footer: none,
    )
    
    set text(font: "Libertinus Sans")
    m-footer.update(footer)

    set list( indent: 20pt)

    body
}

#let m-progress-bar = utils.polylux-progress( ratio => {
  let d-progress = ratio
  grid(
    columns: (ratio * 100%, 1fr),
    m-cell(fill: ovgu-purple),
    m-cell(fill: m-lighter-brown)
  )
})

#let title-slide(
  title: [],
  subtitle: none,
  author: none,
  date: none,
  extra: none,
) = {
  let content = {
    set text(fill: m-dark-teal)
    set align(horizon)
    
    block(width: 100%, inset: 2em, {
      text(size: 1.3em, strong(title))
      if subtitle != none {
        linebreak()
        text(size: 0.9em, subtitle)
      }
      
      line(length: 100%, stroke: 1.1pt + ovgu-purple)
      set text(size: .8em)
      
      if author != none {
        block(spacing: 1em, author)
      }
      if date != none {
        block(spacing: 1em, date)
      }
      if extra != none {
        block(spacing: 1em, extra)
      }
    })
  }
   
  m-footer.update([#title | #utils.current-section])
  counter("total_slide_count").update(n => n + 2)
  polylux-slide(content)
}

#let slide(
    title: none,
    body
) = {
    let header = {
        set align(top)
        if title != none {
            show: m-cell.with(fill: ovgu-lightgray, inset: 1em)
            set align(horizon)
            text(fill: ovgu-blue, size: 1.2em)[*#title*]
        } else { 
            strong("Missing Headline")
        }
         
        block(height: 1pt, width: 100%, spacing: 0pt, m-progress-bar)
    }

    let footer = {
        show: pad.with(.5em)
        set text(size: 0.8em)
        set align(bottom)
        
        text(fill: m-dark-teal.lighten(40%), m-footer.display())
        h(1fr)
        
        counter("total_slide_count").update(n => n + 1)
        text(fill: m-dark-teal, logic.logical-slide.display()
        + [/] + utils.last-slide-number)
    }

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

#let s(t: none, body) = slide(title: t, body)

#let section(name) = {
  utils.register-section(name)
}

#let parcio-list = list.with(marker: [▪], indent: 2pt)

