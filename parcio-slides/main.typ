#import "template/parcio.typ": *

// See template file > Helper Functions for extra stuff!
#show: parcio-theme.with()
#set text(size: 20pt)

#title-slide(
  title: "Title",
  subtitle: "Subtitle",
  author: (name: "Author", mail: "author@ovgu.de"),
  date: datetime.today().display("[month repr:long] [day], [year]"),
  extra: [
    #set text(0.825em)
    Faculty of Computer Science\
    Otto von Guericke University Magdeburg
  ],
)

#outline-slide()

#slide(title: "Template", new-section: "Introduction")[
  - This presentation template is available at
    https://github.com/xkevio/parcio-typst and consists of Sections 1 to 4.
]

#slide(
  title: "Figures",
)[
  #subfigure("Test", lbl: "fig1")[
    #figure(caption: "Left", kind: "sub", supplement: none, numbering: "(a)")[
      #image(alt: "Blue OVGU logo", width: 75%, "template/ovgu.svg")
    ]<fig1a>
  ][
    #figure(caption: "Right", kind: "sub", supplement: none, numbering: "(a)")[
      #image(alt: "Blue OVGU logo", width: 75%, "template/ovgu.svg")
    ]<fig1b>
  ]
  \
  - You can refer to the subfigures (Figures @fig1a[1#h(-0.3em)] and
    @fig1b[1#h(-0.3em)]) or the figure (@fig1).
]

#slide(
  title: "References",
  new-section: "Background",
)[
  - You can comfortably reference literature @DuweLMSF0B020 #footnote[This is a footnote.]
]

#slide(title: "Tables")[
  // You can also create normal tables with `#table`,
  // this one just has some styling preapplied.
  #figure(caption: "Caption", parcio-table(
    3, 3,
    [*Header 1*], [*Header 2*], [*Header 3*],
    [Row 1], [Row 1], [Row 1],
    [Row 2], [Row 2], [Row 2],
  ))<tbl>

  - You can also refer to tables (@tbl)
]

#slide(
  title: "Math",
)[
  $ (diff T) / (diff x)(0, t) = (diff T) / (diff x)(L, t) = 0\ "where" forall t > 0 "with" L = "length". $

  \

  #figure(caption: "Lots of fun math!")[
    $&sum_(k = 0)^n pi dot k \
    <=> &sum_(k = 1)^n pi dot k \
    <=> &sum_(k = 2)^n (pi dot k) + pi
    $
  ]
]

#s(t: "Listings", ns: "Evaluation")[
  #figure(caption: "Caption")[
    ```c
    printf("Hello World\n");

    // Comment
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            sum += 'a';
        }
    }
    ```
  ]<lst>

  - You can also refer to listings (@lst)
]

#s(t: "Columns")[
  #grid(columns: (1fr, 1fr), column-gutter: 1em)[
    - Slides can be split into columns
  ][
    ```c
    printf("Hello World\n");

    // Comment
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            sum += 'a';
        }
    }
    ```
  ]
]

#slide(title: "Todos", new-section: "Conclusion")[
  #todo("FIXME")
  #lorem(125)
]

#bib-slide("../bibliography/report.bib")