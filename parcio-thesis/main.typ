#import "template/template.typ": *

// Title, Author, Abstract,
// optional: thesis-type to specify "Bachelor", "Master", "PhD", etc.,
// optional: reviewers to specify "first-reviewer", "second-reviewer" and (if needed) "supervisor".
#show: project.with(
  "Title", 
  (
    name: "Author",
    mail: "author@ovgu.de"
  ),
  include "chapters/abstract.typ",
  thesis-type: "Bachelor/Master",
  reviewers: ("Prof. Dr. Musterfrau", "Prof. Dr. Mustermann", "Dr. Evil")
)

// Set lower roman numbering for ToC and abstract (template hides numbering).
#set page(margin: (top: 5cm, rest: 2.5cm), footer: none)
#outline(depth: 3)

// Set arabic numbering for everything else and reset page counter.
#set page(numbering: "1")
#counter(page).update(1)

// ACTUAL CONTENT OF THESIS (use \ for additional line breaks)
= Introduction<intro>

\ _In this chapter, #lorem(50)_ \

== Motivation

// Subfigures, needs "kind" of "sub" and a grid currently.
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
You can refer to  the subfigures (Figures @fig1a and @fig1b) or the figure (@fig1).
\ \

#section[Summary]
#lorem(80)

= Background<bg>

_In this chapter, ..._\ \


== Citations
You can comfortably reference literature @DuweLMSF0B020.#footnote[This is a footnote.] BibTeX entries for a large number of publications can be found at https://dblp.org/.

== Tables
#figure(caption: "Caption")[
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
#lorem(80)

= Evaluation<eval>
_In this chapter, ..._\ \

== Listings
#figure(caption: "Caption")[
  // Supports highlighting with the `highlighted` parameter,
  // e.g. #src(highlighted: (1,))[...]
  #src[
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
]<code1>

You can also refer to listings (@code1).\ \

#section[Summary]
#lorem(80)

#pagebreak()
= Conclusion<conc>
_In this chapter, ..._\ \

== Todos
#todo(inline: true)[FIXME]

#lorem(100)#todo[FIXME: remove this]

#lorem(80)

#section[Summary]
#lorem(80)

// -------------------------
#pagebreak()
#pagebreak()

#bibliography("bibliography/report.bib", style: "bibliography/apalike.csl")

#pagebreak()
#pagebreak()

#counter(heading).update(0)
#heading(numbering: "A.", supplement: "Appendix")[Appendix]<appendix>
#figure(caption: "Caption")[
  // Supports highlighting with the `highlighted` parameter,
  // e.g. #src(highlighted: (1,))[...]
  #src(highlighted: (1, 6))[
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