#set math.equation(numbering: "(1)" )
#set text(font: "Arial")

// Front page
#include "coverpage.typ"

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
#set page(numbering: "1")
#counter(page).update(1)
#include "introduction.typ"

#bibliography("references.yml", style: "ieee")