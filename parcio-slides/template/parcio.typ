#import "@preview/polylux:0.3.1": *
#import "@preview/subpar:0.1.1"

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
#let m-pages = counter("m-page")

#let m-progress-bar = context {
  let ratio = m-pages.get().first() / m-pages.final().first()
  grid(
    columns: (ratio * 100%, 1fr),
    m-cell(fill: ovgu-purple),
    m-cell(fill: m-lighter-brown),
  )
}

// --- THEMING: Start of theme rules. ---
#let parcio-theme(aspect-ratio: "16-9", body) = {
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

  set list(indent: 20pt)
  set footnote.entry(
    indent: 2.5em,
    separator: line(start: (2em, 0em), end: (40%, 0em), stroke: 0.5pt),
  )

  body
}

// Declare your title slide! OvGU logo to the right.
//
// title: Your presentation title.
// subtitle: (Optional) subtitle for more info.
// author: Consists of author.name and author.mail.
// date: (Optional) date of the presentation.
// extra: (Optional) info below the date, like your faculty.
#let title-slide(
  title: [], 
  subtitle: none, 
  author: (:), 
  date: none, 
  extra: none,
) = {
  let content = {
    set text(fill: m-dark-teal)
    show raw: set text(font: "Inconsolata", 1.15em)

    set align(horizon)

    v(-1em)
    block(width: 100%, inset: 2.5em, height: 100%, {
      table(
        columns: (auto, 1fr),
        align: (left, right),
        stroke: none,
        inset: 0pt,
        text(size: 1.3em, strong(title) + v(-0.25em) + text(0.85em, subtitle)),
        image("ovgu.svg", width: 9.8cm),
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
    grid(columns: 3 * (1fr,), 
    align(left, author.name), 
    align(center, title), 
    align(right)[#m-pages.display("1 / 1", both: true)]),
  )
  polylux-slide(content)
}

// Basic slide function.
//
// title: (Optional) title of the slide, will be shown on the left in the header.
// new-section: (Optional) marks a new topic, adds it to the outline & on the right in the header.
// show-current-section: (default: true) if the current section should be displayed.
// show-footer: (default: true): if the footer should be displayed.
#let slide(
  title: none,
  new-section: none,
  show-current-section: true,
  show-footer: true,
  _last: false,
  body,
) = {
  // Define header: [Subsection] --- [Section], incl. progress bar.
  let header = {
    set align(top)
    if title != none {
      // Register a new section if given.
      if new-section != none {
        utils.register-section(new-section)
      }

      // Step page counter when this is not set.
      // ONLY for special slides like outline or references.
      if not _last {
        counter("m-page").step()
      }

      show: m-cell.with(fill: ovgu-lightgray, inset: 1em)
      align(horizon)[
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

  // Define footer: [author] - [title] - [page / total]
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

  // Add line numbers to code block.
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

// ------ HELPER FUNCTIONS ------

// Simple table design, similar to the existing ParCIO template.
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

// Subfigures.
#let subfigure = subpar.grid

// Simple orange TODO box.
#let todo = rect.with(fill: ovgu-orange, stroke: black + 0.5pt, radius: 0.25em, width: 100%)

// Shorthand for `slide` with shorthands for `title` and `new-section`.
#let s(t: none, ns: none, body) = slide(title: t, new-section: ns, body)

// Creates a clickable outline with a customizable title
// for each `new-section` entry.
#let outline-slide(title: "Outline") = {
  slide(title: title, show-footer: false, _last: true)[
    #set enum(numbering: n => [], tight: false, spacing: 20%)
    #utils.polylux-outline()
  ]
}

// Creates a list of all references using the "apalike" style.
#let bib-slide(title: "References", bib) = slide(title: title, show-footer: false, show-current-section: false, _last: true)[
  #bibliography(
    bib,
    style: "../bibliography/apalike.csl",
    title: none,
    full: true,
  )
]

