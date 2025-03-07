#set math.equation(numbering: "(1)" )
#set text(font: "Arial", size: 11pt)

// Front page
#include "coverpage.typ"

#set par(justify: true, leading: 2em, spacing: 2.5em)
#show heading: it => [
  #set par(leading: 0.5em, spacing: 0.5em)
  #it.body
]

// Preface (Abstract + Acknowledgements)
#set page(numbering: "i")
#counter(page).update(1)
#include "abstract.typ"
// #include "acknowledgements.typ"
#outline(indent: auto, depth: 2)

= List of Figures
#outline(
  title: none,
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
#include "introduction.typ"

#bibliography("references.yml", style: "institute-of-electrical-and-electronics-engineers")