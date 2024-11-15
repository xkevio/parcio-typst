#import "@preview/drafting:0.2.0": margin-note, set-page-properties
#import "@preview/subpar:0.1.1"

#let ovgu-blue = rgb("#0068B4")
#let ovgu-darkgray = rgb("#606060")
#let ovgu-lightgray = rgb("#C0C0C0")
#let ovgu-orange = rgb("#F39100")
#let ovgu-purple = rgb("#7A003F")
#let ovgu-red = rgb("#D13F58")

#let large = 14.4pt
#let Large = 17.28pt 
#let LARGE = 20.74pt
#let huge = 24.88pt

/* ---- Convencience functions ---- */

#let if-none(x, other) = if other == none { x } else { other }
#let roman-numbering(doc, reset: true) = {
  if reset { counter(page).update(1) }
  set page(footer: auto, numbering: "i")
  doc
}

#let arabic-numbering(doc, alternate: true, reset: true) = {
  if reset { counter(page).update(1) }

  let footer = if alternate {
    context {
      let page-count = counter(page).get().first()
      let page-align = if calc.odd(page-count) { right } else { left } 
      align(page-align, counter(page).display("1"))
    }
  } else {
    auto
  }

  set page(footer: footer, numbering: "1")
  doc
}

/* ------------------------------- */

// TODO box (default: no inline).
#let todo(inline: false, body) = if inline {
  rect(
    fill: ovgu-orange,
    stroke: black + 0.5pt,
    radius: 0.25em,
    width: 100%,
    body
  )
} else {
  set rect(fill: ovgu-orange)
  margin-note(stroke: ovgu-orange, body)
}

// Like \section* (unnumbered level 2 heading, does not appear in ToC).
#let section = heading.with(level: 2, outlined: false, numbering: none)

// Neat inline-section in smallcaps and sans font.
#let inline-section(title) = smallcaps[*#text(font: "Libertinus Sans", title)*] 

// Fully empty page, no page numbering.
#let empty-page = page([], footer: [])

// Subfigures.
#let subfigure = subpar.grid.with(
  numbering: (num) => {
    numbering("1.1", counter(heading).get().first(), num)
  },
  numbering-sub-ref: (sup, sub) => { 
    numbering("1.1a", counter(heading).get().first(), sup, sub)
  },
)

// Custom ParCIO table as illustrated in the template.
#let parcio-table(max-rows, ..args) = table(
  ..args,
  row-gutter: (2.5pt, auto),
  stroke: (x, y) => (
    left: 0.5pt,
    right: 0.5pt,
    top: if y <= 1 { 0.5pt },
    bottom: if y == 0 or y == max-rows - 1 { 0.5pt }
  )
)