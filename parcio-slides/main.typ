#import "template/parcio.typ": *
#import themes.metropolis: metropolis-outline

#show: parcio-theme.with()
#set text(size: 20pt)

#title-slide(
    title: "Title",
    subtitle: "Subtitle",
    author: (
        name: "Author",
        mail: "author@ovgu.de"
    ),
    date: datetime.today().display("[month repr:long] [day], [year]"),
    extra: [
        #set text(0.825em)
        Faculty of Computer Science\
        Otto von Guericke University Magdeburg
    ]
)

#outline-slide

#slide(title: "Template", new-section: "Introduction")[
    - This presentation template is available at ... and consists of Sections 1 to 4.
]


#slide(title: "Figures")[
    subfigures...
]

#slide(title: "References", new-section: "Background")[
    - You can comfortably reference literature...#footnote[This is a footnote.]
]

#slide(title: "Tables")[
    #figure(caption: "Caption", parcio-table(3, 3, 
        [*Header 1*], [*Header 2*], [*Header 3*],
        [Row 1],[Row 1],[Row 1],
        [Row 2],[Row 2],[Row 2],
    ))<tbl>

    - You can also refer to tables (@tbl)
]

#slide(title: "Math")[
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

#s(t: "Todos", ns: "Conclusion")[
    #todo("FIXME")
    #lorem(125)
]

#bib-slide()
