#let parcio-slides-html(body) = {
  show math.equation.where(block: true): html.frame
  show math.equation.where(block: false): eq => box(html.frame(eq))

  html.html({
    html.head({
      html.meta(charset: "utf-8")
      html.meta(
        name: "viewport",
        content: "width: device-width, initial-scale=1.0",
      )
      html.style(read("slides.css").replace(regex("[\n|\t]"), ""))
      html.script(read("controls.js"))
    })
    html.body({
      html.main({
        body
      })
    })
  })
}

#let slide-counter = counter("slide-counter")
#let slide(body) = {
  slide-counter.step()
  context html.div(id: str(slide-counter.get().first()), class: "slide", {
    html.div(class: "header")[
      test
    ]
    body
    html.div(class: "slide-num", slide-counter.display())
  })
}
