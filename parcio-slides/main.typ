#import "parcio_template/parcio.typ": *
#import themes.metropolis: metropolis-outline

#show: parcio-theme.with()
#set text(size: 25pt)



#title-slide(
    title: "Title",
    subtitle: "Never gonna give you up",
    author: lorem(5),
    date: datetime.today().display("[month repr:long] [day], [year]")
)

#slide(title: "Table of Contents")[
   #metropolis-outline
]

#slide(title: "#lorem(2)")[
    #section("Sektion 1")
    = Headline
    #lorem(40)
]

#slide(title: "testing")[
    #section("Sektion 2")
    = testing 
    this is some text 

    - bullet point
        - bullet point in a bullet point
    - #lorem(4)
        - better

    #src[
        ```java
        public static void main(String[] args) {
            System.out.println("Hello World");
        }
        ``` 
    ]
]

#slide(title: "testing1")[
    = Hello World
    == Hello World
    === Hello World
    #lorem(20)
]

#slide(title: "math test")[
    #section("Sektion 3")
    #set align(center)
    #figure(caption: "Beweis für nichts")[
        $&sum_(k = 0)^n pi dot k \
        <=> &sum_(k = 1)^n pi dot k \
        <=> &sum_(k = 2)^n (pi dot k) + pi
        $
    ]
]

#slide(title: "table test")[
    #set align(center)
    #parcio-table(
        3, 3, 
    [*Header 1*], [*Header 2*], [*Header 3*],
    [Row 1],[Row 1],[Row 1],
    [Row 2],[Row 2],[Row 2],
    )

    #set align(top)
    #lorem(5)
]

#s(t: "shorter and quicker")[
    Normally you create slides while using 
    #src[
        ```typ 
        #slide(title: _)[
            ....
        ]
        ```
    ]
    We can now simplify it as
    #src[
        ```typ 
        #s(t: _)[
            ....
        ]
        ```
    ]
]

#s(t: "ToDo Test")[
    ToDos are great for annotating things while coding
    #todo[
        ToDo: fix something
    ]
]

#s(t: "Bullet Point tests")[
    - #lorem(2)
        - #lorem(5)

    #list()[
        "thelp"
    ]
]
