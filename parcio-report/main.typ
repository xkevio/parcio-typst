#import "template/template.typ": *
#import "template/tablex.typ": *

#show: project.with("Title", "Subtitle", authors: (
    (
      name: "First Author",
      mail: "first.author@ovgu.de"
    ),
    (
      name: "Second Author",
      mail: "second.author@ovgu.de"
    )
  ),
  [
    #ipsum\
    #h(1em)This report template is available at #link("https://github.com/parcio/templates")[`https://github.com/parcio/templates`] and consists of Sections @intro[] to @conc[].
  ]
)

// temp test for cite customization
// changes every citation that has (...et al.) in it to use square brackets
#show regex("[(].*(et al.).*[)]"): r => {
  r.text.replace("(", "[").replace(")", "]").replace(".", ".,")
}

// -------------------------------

#parcio-outline()
#pagebreak()

= Introduction<intro>
// subfigures, needs "kind" of "sub" and a grid rn
#figure(caption: "Caption")[
  #grid(columns: 2)[
    #figure(caption: "Left", kind: "sub", supplement: none, numbering: "a")[
      #image(alt: "Blue OVGU logo", width: 75%, "template/ovgu.jpg")  
    ]<fig1a>  
  ][      
    #figure(caption: "Right", kind: "sub", supplement: none, numbering: "a")[
      #image(alt: "Blue OVGU logo", width: 75%, "template/ovgu.jpg")  
    ]<fig1b>
  ]
]<fig1>

You can refer to  the subfigures (Figures 1@fig1a and 1@fig1b) or the figure (@fig1).

= Background<bg>
You can comfortably reference literature #cite("DBLP:journals/superfri/DuweLMSF0B020").#footnote[This is a footnote.]

#figure(caption: "Caption")[
  // alignment change currently only for 3 columns, can be changed tho
  // scaling also dependent on header size
  // normal typst #table function works just fine in that regard but is less customizable rn
  #parcio-table(3, 3, 
    [*Header 1*], [*Header 2*], [*Header 3*],
    [Row 1],[Row 1],[Row 1],
    [Row 2],[Row 2],[Row 2],
  )
]<tb1>

You can also refer to tables (@tb1).

== Math<m>
$ E = m c^2 $<eq1>
You can also refer to _(numbered)_#footnote[Referable things *need* a numbering] equations (@eq1).

= Evaluation<eval>
#align(left)[
  #figure(caption: "Caption")[
  ```c
  printf("Hello world!\n");
  
  // Comment
  for (int i = 0; i < m; i++) {
    for (int j = 0; j < n; j++) {
      sum += 'a';
    }
  }
  ```
  ]<code1>
]

You can also refer to listings (@code1).

#pagebreak()
= Conclusion<conc>
#todo[FIXME]

#lorem(100)

#lorem(100)

#lorem(100)
#inline-todo[FIXME:\ remove\ this]

// -------------------------
#pagebreak()
#bibliography("report.bib", style: "apa", title: "References")
