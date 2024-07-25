#import "template/template.typ": *

// Title, Author, Abstract,
// optional: thesis-type to specify "Bachelor", "Master", "PhD", etc.,
// optional: reviewers to specify "first-reviewer", "second-reviewer" and (if needed) "supervisor".
// optional: lang to specify the language for text features like "" or hyphenation (specify as ISO 639-1/2/3 code, default: "en")
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
#set page(margin: 2.5cm, footer: none)
#outline(depth: 3)

#empty-page

// Set arabic numbering for everything else and reset page counter.
// TODO: ALWAYS START CHAPTERS ON "LEFT" PAGE (SO NOT BACKSIDE)!
#set page(numbering: "1", footer: context {
  if calc.odd(counter(page).get().first()) {
    align(right, counter(page).display("1"))
  } else {
    align(left, counter(page).display("1"))
  }
})
#counter(page).update(1)

// ACTUAL CONTENT OF THESIS (use \ for additional line breaks)
= Introduction<intro>

_In this chapter, #lorem(50)_

== Motivation

// Subfigures.
#subfigure(
  caption: "Caption", 
  columns: 2, 
  label: <fig:main>,
  figure(caption: "Left")[
    #image(alt: "Blue OVGU logo", width: 75%, "template/ovgu.jpg")  
  ], <fig:main-a>,
  figure(caption: "Right")[
    #image(alt: "Blue OVGU logo", width: 75%, "template/ovgu.jpg")  
  ], <fig:main-b>
)

You can refer to the subfigures (Figures @fig:main-a[] and @fig:main-b[]) or the figure (@fig:main).
\ \

#section[Summary]
#lorem(80)

= Background<bg>

_In this chapter, ..._

== Citations
You can comfortably reference literature @DuweLMSF0B020.#footnote[This is a footnote.] BibTeX entries for a large number of publications can be found at https://dblp.org/.

== Tables

// Either use `parcio-table` for special tables (with an extra argument at the start, max-rows) or just use the normal `table` function and style it however you like.
#figure(caption: "Caption")[
  #parcio-table(3, columns: 3, align: (left, center, right), 
    [*Header 1*], [*Header 2*], [*Header 3*],
    [Row 1],[Row 1],[Row 1],
    [Row 2],[Row 2],[Row 2],
  )
]<tbl:tb1>

You can also refer to tables (@tbl:tb1).

== Math<m>

$ E = m c^2 $<eq:eq1>

\

#section[Summary]
#lorem(80)

= Evaluation<eval>
_In this chapter, ..._ \ \

== Listings

#figure(caption: "Caption")[
```c
printf("Hello World!\n");

// Comment
for (int i = 0; i < m; i++) {
  for (int j = 0; j < n; j++) {
    sum += 'a';
  }
}
```
]<lst:hello-world>

You can also refer to listings (@lst:hello-world). \ \

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

#empty-page

#bibliography("bibliography/report.bib", style: "bibliography/apalike.csl")

#empty-page

#counter(heading).update(0)
#heading(numbering: "A.", supplement: "Appendix")[Appendix]<appendix>

#figure(
  caption: "Caption", 
  numbering: n => numbering("A.1", counter(heading).get().first(), n))[
  ```c
  printf("Hello World!\n");

  // Comment
  for (int i = 0; i < m; i++) {
    for (int j = 0; j < n; j++) {
      sum += 'a';
    }
  }
  ```
]

#empty-page
#heading(numbering: none, outlined: false)[Statement of Authorship]

I herewith assure that I wrote the present thesis independently, that the thesis has not been partially or fully submitted as graded academic work and that I have used no other means than the ones indicated. I have indicated all parts of the work in which sources are used according to their wording or to their meaning.

I am aware of the fact that violations of copyright can lead to injunctive relief and claims for damages of the author as well as a penalty by the law enforcement agency.

\
Magdeburg, #datetime.today().display("[month repr:long] [day], [year]")
#v(3em)

#line(stroke: 0.5pt, length: 50%)
#v(-0.5em)
~Signature