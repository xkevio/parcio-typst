#import "template/template.typ": *
#import "@preview/codelst:1.0.0": *

// Title, Author, Abstract.
#show: project.with(
  "Title", 
  (
    name: "Author",
    mail: "author@ovgu.de"
  ),
  [
    #ipsum
    
    This thesis template is available at #link("https://github.com/parcio/templates") and consists of Chapters @intro[] to @conc[]. It also contains Appendix A.
  ]
)

// OUTLINE (TOC) & NUMBERING CHANGES FROM ROMAN TO LATIN
#set page(
  numbering: (p, _) => locate(loc => {
    let c-page = query(heading.where(body: [Contents]), loc).at(0)
    if c-page != none and c-page.location().page() == loc.page() {
      counter(page).display("i")
    }
  }
  ),
  margin: (top: 5cm, rest: 2.5cm)
)
#outline(depth: 3)
#set page(numbering: (p, ..) => if calc.odd(p) {p})
#counter(page).update(0)

// ACTUAL CONTENT OF THESIS
= Introduction<intro>

\ _In this chapter, ..._ \ \

== Motivation

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
\
You can refer to  the subfigures (Figures 1.1@fig1a and 1.1@fig1b) or the figure (@fig1).
\ \

#section[Summary]
Nam dui ligula, fringilla a, euismod sodales, sollicitudin vel, wisi. Morbi auctor lorem non justo. Nam lacus libero, pretium at, lobortis vitae, ultricies et, tellus. Donec aliquet, tortor sed accumsan bibendum, erat ligula aliquet magna, vitae ornare odio metus a mi. Morbi ac orci et nisl hendrerit mollis. Suspendisse ut massa. Cras nec ante. Pellentesque a nulla. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aliquam tincidunt urna. Nulla ullamcorper vestibulum turpis. Pellentesque cursus luctus mauris.

= Background<bg>

_In this chapter, ..._\ \


== Citations
You can comfortably reference literature #cite("DBLP:journals/superfri/DuweLMSF0B020").#footnote[This is a footnote.] BibTeX entries for a large number of publications can be found at https://dblp.org/.

== Tables
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
\
#section[Summary]
Nam dui ligula, fringilla a, euismod sodales, sollicitudin vel, wisi. Morbi auctor lorem non justo. Nam lacus libero, pretium at, lobortis vitae, ultricies et, tellus. Donec aliquet, tortor sed accumsan bibendum, erat ligula aliquet magna, vitae ornare odio metus a mi. Morbi ac orci et nisl hendrerit mollis. Suspendisse ut massa. Cras nec ante. Pellentesque a nulla. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aliquam tincidunt urna. Nulla ullamcorper vestibulum turpis. Pellentesque cursus luctus mauris.

= Evaluation<eval>
_In this chapter, ..._\ \

== Listings
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

You can also refer to listings (@code1).\ \

#section[Summary]
Nam dui ligula, fringilla a, euismod sodales, sollicitudin vel, wisi. Morbi auctor lorem non justo. Nam lacus libero, pretium at, lobortis vitae, ultricies et, tellus. Donec aliquet, tortor sed accumsan bibendum, erat ligula aliquet magna, vitae ornare odio metus a mi. Morbi ac orci et nisl hendrerit mollis. Suspendisse ut massa. Cras nec ante. Pellentesque a nulla. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aliquam tincidunt urna. Nulla ullamcorper vestibulum turpis. Pellentesque cursus luctus mauris.

#pagebreak()
= Conclusion<conc>
_In this chapter, ..._\ \

== Todos
#todo[FIXME]

#lorem(100)

Nam dui ligula, fringilla a, euismod sodales, sollicitudin vel, wisi. Morbi auctor lorem non justo. Nam lacus libero, pretium at, lobortis vitae, ultricies et, tellus. Donec aliquet, tortor sed accumsan bibendum, erat ligula aliquet magna, vitae ornare odio metus a mi. Morbi ac orci et nisl hendrerit mollis. Suspendisse ut massa. Cras nec ante. Pellentesque a nulla. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aliquam tincidunt urna. Nulla ullamcorper vestibulum turpis. Pellentesque cursus luctus mauris.

#section[Summary]
Nam dui ligula, fringilla a, euismod sodales, sollicitudin vel, wisi. Morbi auctor lorem non justo. Nam lacus libero, pretium at, lobortis vitae, ultricies et, tellus. Donec aliquet, tortor sed accumsan bibendum, erat ligula aliquet magna, vitae ornare odio metus a mi. Morbi ac orci et nisl hendrerit mollis. Suspendisse ut massa. Cras nec ante. Pellentesque a nulla. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aliquam tincidunt urna. Nulla ullamcorper vestibulum turpis. Pellentesque cursus luctus mauris.

// -------------------------
#pagebreak(to: "odd")
#bibliography("report.bib", style: "apa", title: "Bibliography")

#heading(numbering: "A.")[Appendix]
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
  ]
]

#pagebreak(to: "odd")
#heading(numbering: none, outlined: false)[Statement of Authorship]

I herewith assure that I wrote the present thesis independently, that the thesis has not been partially or fully submitted as graded academic work and that I have used no other means than the ones indicated. I have indicated all parts of the work in which sources are used according to their wording or to their meaning.

I am aware of the fact that violations of copyright can lead to injunctive relief and claims for damages of the author as well as a penalty by the law enforcement agency.

\
Magdeburg, #datetime.today().display("[month repr:long] [day], [year]")
#v(3em)

#line(stroke: 0.5pt, length: 50%)
#v(-0.5em)
~Signature