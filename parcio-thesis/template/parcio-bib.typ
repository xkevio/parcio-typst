#let wasm-bib = plugin("parcio_wasm_bib.wasm")
#let is-parcio-bib = state("is-parcio-bib", false)

#let _translation-file = toml("translations.toml")
#let translations(lang) = _translation-file.at(
  lang, 
  default: _translation-file.at(_translation-file.default-lang)
)

// Query through citations and collect all pages where citation has been used.
// Then, formats it accordingly (Cited on page x, cited on pages x and y, cited on pages x, y and z).
#let _cite-pages(cc) = context {
  let cite-group = (:)
  let citations = query(ref.where(element: none))
    
  for c in citations {
    if str(c.target) not in cite-group.keys() {
      cite-group.insert(str(c.target), (c.location(),))
    } else {
      cite-group.at(str(c.target)).push(c.location())
    }
  }
  
  if not cc in cite-group { return none }
  let locs = cite-group.at(cc)
    .map(l => link(l, str(counter(page).at(l).first())))
    .dedup(key: l => l.body)

  let cited-on = translations(text.lang).bibliography.cited-on-page
  let cited-on-pp = translations(text.lang).bibliography.cited-on-pages
  let cited-on-join = translations(text.lang).bibliography.join
  
  text(rgb("#606060"))[
    #if locs.len() == 1 [
      (#cited-on #locs.first())
    ] else if locs.len() == 2 [
      (#cited-on-pp #locs.at(0) and #locs.at(1))
    ] else [
      #let loc-str = locs.join(", ", last: " " + cited-on-join + " ")
      (#cited-on-pp #loc-str)
    ]
  ]
}

/* 
Create "fake" bibliography based on modified hayagriva output (Typst markup) with
more customization possibilities. This calls a WASM Rust plugin which in turn calls 
Hayagriva directly to generate the bibliography and its formatting.

Then, it sends over the bibliography information as JSON, including keys, prefix and so on.
This allows for introspection code to query through all citations to generate backrefs.
*/
#let parcio-bib(path, title: none, full: false, style: "ieee", enable-backrefs: false) = context {
  show bibliography: none
  bibliography("../" + path, title: title, full: full, style: "../" + style)

  is-parcio-bib.update(s => true)
  let bibliography-file = bytes(read("../" + path))
  let bib-format = bytes(if path.ends-with(regex("yml|yaml")) { "yaml" } else { "bibtex" })
  let bib-keys = str(wasm-bib.get_bib_keys(bibliography-file, bib-format)).split("%%%")

  let used-citations = query(ref.where(element: none)).filter(r => {
    bib-keys.contains(str(r.target))
  }).map(r => str(r.target))

  let (style, style-format) = if style.ends-with(".csl") {
    (read("../" + style), "csl")
  } else {
    (style, "text")
  }

  let rendered-bibliography = wasm-bib.parcio_bib(
    bibliography-file, 
    bib-format, 
    bytes(if full { "true" } else { "false" }),
    bytes(style),
    bytes(style-format),
    bytes(text.lang), 
    bytes(used-citations.join(","))
  )

  /* WASM plugin returns `Rendered` as a list of JSON representations of 
    (key, prefix, content) separated by "%%%" with `hanging-indent` 
    and `sort` at the end.
  */
  let rendered-bibliography-str = str(rendered-bibliography).split("%%%");
  let hanging-indent = eval(rendered-bibliography-str.last())

  let sorted-bib = rendered-bibliography-str.slice(0, -1)
  let is-grid = json.decode(rendered-bibliography-str.first()).prefix != none
  let title = if title == none { 
    translations(text.lang).bibliography.bibliography 
  } else { title }

  heading(title, numbering: none)
  if is-grid {
    grid(columns: 2, column-gutter: 0.65em, row-gutter: 1em,
      ..for citation in sorted-bib {
        let (key, prefix, content) = json.decode(citation)
        let backref = if enable-backrefs { _cite-pages(key) } else { none }
        let cite-location = query(ref.where(element: none)).filter(r => r.citation.key == label(key))

        let backlink = if cite-location.len() == 0 [
          #prefix#label("_" + key)
        ] else [
          #link(cite-location.first().location(), [#prefix#label("_" + key)])
        ]
        
        (
          backlink, 
          eval(content, mode: "markup") + backref
        )
      }
    )
  } else {
    set par(hanging-indent: 1.5em) if hanging-indent
    for citation in sorted-bib {
      let (key, prefix, content) = json.decode(citation)
      let backref = if enable-backrefs { _cite-pages(key) } else { none }
      [#eval(content, mode: "markup")#label("_" + key)#backref]
      v(1em, weak: true)
    }
  }
}