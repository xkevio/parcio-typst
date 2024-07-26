#import "../../template/template.typ": subfigure, section

= Introduction<intro>

_In this chapter, #lorem(50)_

== Motivation

// Subfigures.
#subfigure(
  caption: "Caption", 
  columns: 2, 
  label: <fig:main>,
  figure(caption: "Left")[
    #image(alt: "Blue OVGU logo", width: 75%, "../../template/ovgu.jpg")  
  ], <fig:main-a>,
  figure(caption: "Right")[
    #image(alt: "Blue OVGU logo", width: 75%, "../../template/ovgu.jpg")  
  ], <fig:main-b>
)

You can refer to the subfigures (Figures @fig:main-a[] and @fig:main-b[]) or the figure (@fig:main).
\ \

#section[Summary]
#lorem(80)