#set math.equation(numbering: "(1)" )
#set text(font: "Arial", size: 11pt)

// Front page
#include "coverpage.typ"

#set par(justify: true, leading: 2em, spacing: 2.5em)
#show heading: it => [
  #set par(leading: 0.5em, spacing: 0.5em)
  #it.body
]

#show figure.caption: it => {
  set align(left)
  set par(justify: true)
  it
}
#let in-outline = state("in-outline", false)
#show outline: it => {
  in-outline.update(true)
  it
  in-outline.update(false)
}
#let flex-caption(long, short) = context if in-outline.get() { short } else { long }

// Preface (Abstract + Acknowledgements)
#set page(numbering: "i")
#counter(page).update(1)
#include "abstract.typ"
// #include "acknowledgements.typ"
#outline(indent: auto, depth: 2)

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
#counter(page).update(1)
#include "introduction.typ" // 2 pages
#include "lit-review.typ" // 8 - 10 pages
#include "methodology.typ" // 15 - 20 pages
#include "simulations.typ" // 8 - 10 pages

#counter(heading).update(7)
#bibliography("references.yml", style: "institute-of-electrical-and-electronics-engineers")