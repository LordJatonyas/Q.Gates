#set math.equation(numbering: "(1)" )
#set text(font: "Arial", size: 11pt)

// Front page
#include "coverpage.typ"

#set par(justify: true, leading: 2em, spacing: 2.5em)
#show heading: it => [
  #set par(leading: 0.5em, spacing: 0.5em)
  #it.body
]

// Figure captions
#show figure.caption: it => {
  set par(justify: true)
  it
}

// Preface (Abstract + Acknowledgements)
#set page(numbering: "i")
#counter(page).update(1)
#include "abstract.typ"
#include "acknowledgements.typ"

#outline(indent: auto, depth: 2)
#pagebreak()
#outline(
  title: [List of Figures],
  target: figure,
)

#set heading(numbering: "1.1")
#show heading: it => [
  #set par(leading: 0.5em, spacing: 1.5em)
  #counter(heading).display()
  #it.body
]
#set page(numbering: "1")
#set math.equation(numbering: "(1.1)")
#counter(page).update(1)



#include "introduction.typ" // 1 - 2 pages
#include "lit-review.typ" // 12 - 14 pages
#include "methodology.typ" // 12 - 15 pages
#include "simulations.typ" // 8 - 10 pages
#include "discussion.typ" // 6 - 8 pages
#include "conclusion.typ" // 2 - 3 pages

#pagebreak()
#counter(heading).update(5)
#bibliography("references.yml", style: "institute-of-electrical-and-electronics-engineers")