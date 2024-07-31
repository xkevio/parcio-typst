#let _bib-wasm = plugin("./hello.wasm")

#let _extract-authors(bib-file, key) = {
  let bib-content = bytes(read(bib-file))
  let key-bytes = bytes(key)
  let authors = _bib-wasm.extract_author(bib-content, key-bytes)
  str(authors).split("%")
}

#let _cite-pages(cc) = context {
  let cite-group = (:)
  let citations = query(ref).filter(r => r.has("citation") and r.element == none)
    
  for c in citations {
    if str(c.target) not in cite-group.keys() {
      cite-group.insert(str(c.target), (c.location(),))
    } else {
      cite-group.at(str(c.target)).push(c.location())
    }
  }
  
  let locs = cite-group.at(str(cc))
    .map(l => link(l, str(counter(page).at(l).first())))
    .dedup(key: l => l.body)
  
  text(rgb("#606060"))[
    #if locs.len() == 1 [
      (Cited on page #locs.first())
    ] else if locs.len() == 2 [
      (Cited on pages #locs.at(0) and #locs.at(1))
    ] else [
      #let loc-str = locs.join(", ", last: " and ")
      (Cited on pages #loc-str)
    ]
  ]
}

#let parcio-bib(..args) = context {
  show bibliography: none
  bibliography(..args)

  let title = args.named().at("title", default: [Bibliography])
  heading(numbering: none, title)

  let bib-file = args.pos().first()
  let citations = query(ref)
    .filter(r => r.has("citation") and r.element == none)
    .sorted(key: r => {
      if bib-file.ends-with(".yml") or bib-file.ends-with(".yaml") {
        let yml-bib-file = yaml.decode(read("../" + bib-file))
        let authors = if type(yml-bib-file.at(str(r.target)).author) == str {
          lower(yml-bib-file.at(str(r.target)).author)
        } else if type(yml-bib-file.at(str(r.target)).author) == dictionary {
          lower(yml-bib-file.at(str(r.target)).author.name)
        } else {
          lower(yml-bib-file.at(str(r.target)).author.join(","))
        }
        
        let date = str(yml-bib-file.at(str(r.target)).at("date", default: ""))
        (authors, date)
      } else {
          assert(bib-file.ends-with(".bib"), message: "Your bibliography should either be a .bib BibTeX file or a hayagriva yaml file!")
          _extract-authors("../" + bib-file, str(r.target))
      }
    })
  
  par(justify: true, hanging-indent: 1.5em)[
    #for c in citations {
      cite(c.citation.key, form: "full")
      _cite-pages(c.citation.key)
      v(0em)
    }
  ]
}