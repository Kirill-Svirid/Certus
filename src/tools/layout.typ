#import "utils.typ": is-empty

// Позволяет разорвать содержание (outline) по указанным позициям в случае налегания содержимого на элементы документа, например, на рамку.
#let outline-break-by-enum(break-points, entry) = {
  let loc = entry.element.location()
  let c = counter("header-all").at(loc).at(0)
  if type(break-points) == int { break-points = (break-points,) }
  if break-points.contains(c) {
    pagebreak(weak: true) + entry
  } else {
    entry
  }
}

// Позволяет расположить таблицу с разрывом по листам с учётом названия и продолжения.
#let table-multi-page(continue-header-label: [], continue-footer-label: [], ..table-args) = context {
  // TODO: Check for remove
  // let columns = table-args.named().at("columns", default: 1)
  // let column-amount = if type(columns) == int {
  //   columns
  // } else if type(columns) == array {
  //   columns.len()
  // } else {
  //   1
  // }

  // Check as show rule for appearance of a header or a footer in grid if value is specified
  let label-has-content = value => value.has("children") and value.children.len() > 0 or value.has("text")

  // Counter of tables so we can create a unique table-part-counter for each table
  let table-counter = counter("table")
  table-counter.step()

  // Counter for the amount of pages in the table
  let table-part-counter = counter("table-part" + str(table-counter.get().first()))

  show <table-footer>: footer => {
    table-part-counter.step()
    context if table-part-counter.get() != table-part-counter.final() and not is-empty(continue-footer-label) {
      footer
    }
  }

  show <table-header>: header => {
    table-part-counter.step()
    context if (table-part-counter.get().first() != 1) and not is-empty(continue-header-label) {
      header
    }
  }

  grid(
    inset: 0mm,
    row-gutter: 2mm,
    grid.header(grid.cell(align(left + bottom)[ #continue-header-label <table-header> ])),
    ..table-args,
    grid.footer(grid.cell(align(right + top)[#continue-footer-label <table-footer> ]))
  )
}
