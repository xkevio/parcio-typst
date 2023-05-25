#import "tablex.typ": *

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

// Typst has its own `#lorem()` function but I wanted to make this comparable
// to the LaTeX template which uses a different variant of this placeholder text.
#let ipsum = [
  #h(1em)Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut purus elit, vestibu-
  lum ut, placerat ac, adipiscing vitae, felis. Curabitur dictum gravida mauris. Nam
  arcu libero, nonummy eget, consectetuer id, vulputate a, magna. Donec vehic-
  ula augue eu neque. Pellentesque habitant morbi tristique senectus et netus et
  malesuada fames ac turpis egestas. Mauris ut leo. Cras viverra metus rhoncus
  sem. Nulla et lectus vestibulum urna fringilla ultrices. Phasellus eu tellus sit amet
  tortor gravida placerat. Integer sapien est, iaculis in, pretium quis, viverra ac, nunc.
  Praesent eget sem vel leo ultrices bibendum. Aenean faucibus. Morbi dolor nulla,
  malesuada eu, pulvinar at, mollis ac, nulla. Curabitur auctor semper nulla. Donec
  varius orci eget risus. Duis nibh mi, congue eu, accumsan eleifend, sagittis quis,
  diam. Duis eget orci sit amet orci dignissim rutrum.
]

// ----------------------
// Custom outline function 
// since outline customization 
// is still limited
// ----------------------
#let parcio-outline(title: [Contents]) = {
  locate(loc => {
    heading(outlined: false, numbering: none)[#title]
    let headings = query(heading, loc)
    let h-counter = counter("h")
    let toc = ()

    // remove "Contents" heading from ToC
    let _ = headings.remove(0)
    
    for h in headings {
      let formatted-heading = if h.level > 1 {
        text(font: "Libertinus Serif")[#h.body]
      } else {
        text(font: "Libertinus Sans")[*#h.body*]
      }

      let page = counter(page).at(h.location()).join()
      let formatted-page = if h.level == 1 {
        set text(font: "Libertinus Sans")
        strong[#page]
      } else {
        page
      }
      let formatted-counter = if h.level == 1 {
        if h.body != [References] {
          set text(font: "Libertinus Sans")
          box[#pad(right: 0.75em)[
            #strong[#h-counter.display("1.1.")]
          ]]
        }
      } else {
        box[#pad(right: 0.75em)[
          #h-counter.display("1.1.")
        ]]
      }

      let h-pad = if h.level == 1 {
        0em
      } else {
        h.level * 0.75em
      }
      let v-pad = if h.level == 1 [
        #if headings.first() != h [
          #v(0.5em)
        ]
      ] else [
        #v(-0.5em)
      ]
      
      let linked-heading = box[#pad(left: h-pad)[
        #h-counter.step(level: h.level)
        #link(h.location())[#formatted-counter#formatted-heading]
      ]]
      
      toc.push(
        v-pad + 
        linked-heading +
        box(width: 1fr)[
          #if h.level != 1 [
            #repeat[~~.]
          ]
        ] +
        [~~#formatted-page]
      )
    }

    stack(dir: ttb, spacing: 1em, ..toc)
  })
}

// ----------------------
//   TODO BOX UTILITY
// ----------------------
#let todo(content) = [
  #rect(fill: ovgu-orange, stroke: 0.75pt, radius: 0.35em, width: 100%)[#content]
]
#let inline-todo(content) = locate(l => {
  let offset = 21cm - l.position().x - 2.5cm * 0.9
  box(width: 0pt, {
    place(dy: 0.25em, line(stroke: ovgu-orange, length: offset))
    place(dx: offset, dy: -1em,
      rect(fill: ovgu-orange, stroke: 0.75pt, radius: 0.35em, width: 0.8 * 2.5cm)[
        #text(black, content)
      ]
    )
  })
})

// ----------------------
//   CUSTOM PARCIO TABLE
//  (uses tablex & nested tables)
// ----------------------
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
      tablex(columns: (hw,) * columns, rows: rows - 1, stroke: 0.5pt, align: (x, y) => 
          (left, center, right).at(x),
          auto-hlines: false,
          hlinex(),
          ..rest,
          hlinex()
        )
    })
  )
}

// ----------------------
//   ACTUAL TEMPLATE
// ----------------------
#let project(title, subtitle, authors: (), abstract, body) = {
  set document(title: title, author: authors.map(a => a.name))
  set page("a4", margin: 2.5cm, numbering: "1") // todo: footskip
  set text(font: "Libertinus Serif", 12pt, lang: "en")
  set heading(numbering: "1.1.")
  set par(justify: true)
  set math.equation(numbering: "(1)")

  // not a lot of customization regarding syntax yet
  show raw: set text(font: "Inconsolata")
  // custom line numbering, not native yet
  show raw.where(block: true): r => [
    #grid(columns: 2, column-gutter: -1em)[
      #v(1em)
      #set text(fill: ovgu-darkgray, font: "Inconsolata", 0.95 * 12pt)
      #set par(leading: 0.65em)
      #move(dx: -1.35em)[
        #for (i, l) in r.text.split("\n").enumerate() [
          #box[#align(right)[#{i + 1}]]
          #linebreak()
        ]
      ]
    ][    
      #block(stroke: 0.5pt + gray, inset: 1em, width: 100%)[
        #align(left)[#r]
      ]
    ]
  ]

  // custom subfigure counter ((a), (b), ...)
  show figure.where(kind: "sub"): f => {
    f.body
    v(-0.65em)
    counter(figure.where(kind: "sub")).display("(a)") + " " + f.caption
  }
  
  show heading: set text(font: "Libertinus Sans", Large)
  show heading: it => it + v(1em)

  set footnote.entry(separator: line(length: 40%, stroke: 0.5pt))

  // can't import pdf yet (svg mostly works)
  align(center)[
    #image(alt: "Blue OVGU logo", width: 66%, "ovgu.jpg")  
  ]

  v(3.2em)

  align(center)[
    #text(huge, font: "Libertinus Sans")[*#title*]\
    
    #text(large, font: "Libertinus Sans")[*#subtitle*]
    #v(0.5em)

    #grid(columns: 2, column-gutter: 3.25em)[
      #set text(Large)
      #show raw: set text(large * 0.95)
      #align(center)[
        #authors.at(0).name\
        #v(0.75em, weak: true)#link("mailto:" + authors.at(0).mail)[#raw(authors.at(0).mail)]
      ]
    ][
      #set text(Large)
      #show raw: set text(large * 0.95)
      #align(center)[
        #authors.at(1).name\
        #v(0.75em, weak: true)#link("mailto:" + authors.at(1).mail)[#raw(authors.at(1).mail)]
      ]
    ]

    #v(0.5em)
    #text(Large)[January 17, 2023] // date function in next release (0.5.0)
    #v(-0.5em)
  ]

  show raw: set text(0.95 * 12pt)
  box(inset: 1cm)[
    #set par(leading: 0.55em)
    #abstract
  ]
  pagebreak()
  
  body
}