#import "/parcio-thesis/src/parcio.typ": *

/* 
  Your ParCIO thesis template requires the following setup (3 required, 4 optional):
  
  required: title, author, abstract (specify in order!)
  optional: thesis-type to specify "Bachelor", "Master", "PhD", etc.,
  optional: reviewers to specify "first-reviewer", "second-reviewer" and (if needed) "supervisor".
  optional: date to specify your deadline (default: datetime.today())
  optional: lang to specify the text language for smartquotes & hyphenation (specify as ISO 639-1/2/3 code, default: "en")
*/
#show: parcio.with(
  "Title", 
  (
    name: "Author",
    mail: "author@ovgu.de"
  ),
  include "chapters/abstract.typ",
  thesis-type: "Bachelor/Master",
  reviewers: ("Prof. Dr. Musterfrau", "Prof. Dr. Mustermann", "Dr. Evil"),
  header-logo: image("images/ovgu.svg", width: 66%)
)

#show: roman-numbering.with(reset: false)
#outline(depth: 3)

/* ---- Main matter of your thesis ---- */

#empty-page

// Set arabic numbering and alternate page number position.
#show: arabic-numbering

#include "chapters/introduction/intro.typ"

#include "chapters/background/background.typ"

#include "chapters/eval/eval.typ"

#include "chapters/conclusion/conc.typ"

/* ---- Back matter of your thesis ---- */

#empty-page

#bibliography("bibliography/refs.bib", style: "bibliography/apalike.csl")

#empty-page

#include "appendix.typ"

#empty-page

#include "legal.typ"