#set math.equation(numbering: "(1)" )
#set text(font: "Arial", size: 11pt)

// Front page
#include "coverpage.typ"

#set par(justify: true, leading: 2em, spacing: 2.5em)
#show heading: it => [
  #set par(leading: 0.5em, spacing: 0.5em)
  #it.body
]

// Figure
#show figure.caption: it => {
  set par(justify: true)
  it
}
#show figure: it => [
  #set par(leading: 1em)
  #it
]
#set table(inset: 8pt)
#show figure.where(kind : table): set figure.caption(position: top)
#show figure.where(kind : "algorithm"): set figure.caption(position: top)

// Preface (Abstract + Acknowledgements)
#set page(numbering: "i")
#counter(page).update(1)
#include "abstract.typ"
//#include "acknowledgements.typ"

#outline(indent: auto, depth: 2)
#pagebreak()
#outline(
  title: [List of Figures],
  target: figure.where(kind: image),
)
#outline(
  title: [List of Tables],
  target: figure.where(kind: table),
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



#include "introduction.typ" // 2 pages
#include "lit-review.typ" // 12 pages
#include "methodology.typ" // 13 pages
#include "results.typ" // 6 pages
#include "discussion.typ" // 5 pages
#include "conclusion.typ" // 6 pages (add economic analysis here)

#pagebreak()
#counter(heading).update(7)
#bibliography("references.yml", style: "institute-of-electrical-and-electronics-engineers") // 5 pages