#import "../tools/headings.typ": *
#import "../tools/annexes.typ": *
#import "../tools/utils.typ": is-empty

#let default = state("default-settings", (:))


#let set-indenting-for-list-and-enum-items(doc) = {
  let first-line-indent() = if type(par.first-line-indent) == dictionary {
    par.first-line-indent.amount
  } else {
    par.first-line-indent
  }

  show list: li => {
    for (i, it) in li.children.enumerate() {
      let nesting = state("list-nesting", 0)
      let indent = context h((nesting.get() + 1) * li.indent)
      let marker = context {
        let n = nesting.get()
        if type(li.marker) == array {
          li.marker.at(calc.rem-euclid(n, li.marker.len()))
        } else if type(li.marker) == content {
          li.marker
        } else {
          li.marker(n)
        }
      }
      let body = {
        nesting.update(x => x + 1)
        it.body + parbreak()
        nesting.update(x => x - 1)
      }
      let content = {
        marker
        h(li.body-indent)
        body
      }
      context pad(left: int(nesting.get() != 0) * li.indent, content)
    }
  }

  show enum: en => {
    let start = if en.start == auto {
      if en.children.first().has("number") {
        if en.reversed { en.children.first().number } else { 1 }
      } else {
        if en.reversed { en.children.len() } else { 1 }
      }
    } else {
      en.start
    }
    let number = start
    for (i, it) in en.children.enumerate() {
      number = if it.has("number") { it.number } else { number }
      if en.reversed { number = start - i }
      let parents = state("enum-parents", ())
      let indent = context h((parents.get().len() + 1) * en.indent)
      let num = if en.full {
        context numbering(en.numbering, ..parents.get(), number)
      } else {
        numbering(en.numbering, number)
      }
      let max-num = if en.full {
        context numbering(en.numbering, ..parents.get(), en.children.len())
      } else {
        numbering(en.numbering, en.children.len())
      }
      num = context box(
        width: measure(max-num).width,
        align(right, text(overhang: false, num)),
      )
      let body = {
        parents.update(arr => arr + (number,))
        it.body + parbreak()
        parents.update(arr => arr.slice(0, -1))
      }
      if not en.reversed { number += 1 }
      let content = {
        num
        h(en.body-indent)
        body
      }
      context pad(left: int(parents.get().len() != 0) * en.indent, content)
    }
  }
  doc
}


// Стиль документа по умолчанию.
// Применяется для документов типа ПЗ, ТУ, ТЗ, РР и др.
#let style-tech-1(doc) = {
  let header-counter = counter("header-all")
  set page(margin: (left: 30mm, rest: 20mm))
  set text(font: "Times New Roman",lang: "ru")
  set heading(numbering: "1.1.1", supplement: none)
  set list(marker: sym.dash.en)
  set ref(supplement: none)

  set figure.caption(separator: [ ] + sym.dash.en + [ ])

  set par(
    first-line-indent: (
      amount: 1.25cm,
      all: true,
    ),
    justify: true,
  )


  show outline.entry: it => {
    show linebreak: none
    show par: set par(first-line-indent: 0cm, justify: true)
    if is-heading-in-annex(it.element) {
      link(
        it.element.location(),
        block(context par(
          hanging-indent: measure(it.element.supplement).width + 0.5cm,
          ..(
            it.element.supplement,
            it.prefix(),
            it.element.body,
            sym.space,
            box(width: 1fr, it.fill),
            sym.space,
            sym.wj,
            it.page(),
          ),
        )),
      )
    } else {
      link(it.element.location(), it)
    }
  }


  show figure.where(kind: table): it => {
    set figure.caption(position: top)
    set align(left)
    it
  }

  show figure.caption.where(kind: image): it => {
    v(0.5em)
    it
  }

  set figure(
    numbering: n => context {
      let appx = state("annexes", false).get()
      let hdr = counter(heading).get()
      let h = query(heading.where(level: 1).before(here())).last()
      if appx {
        numbering(heading-numbering-ru, hdr.first(), n)
      } else if h.numbering != none {
        numbering("1.1", hdr.first(), n)
      } else {
        numbering("1", n)
      }
    },
  )
  show figure: set block(breakable: true)


  // Selects headings of level 1 and body of special list of content to disable enumeration for them (GOST requirements)
  let folder-func(sel, item) = sel.or(heading.where(body: item, level: 1))
  let selector-structural-heading = structural-heading-titles.values().fold(selector, folder-func)
  show selector-structural-heading: set align(center)
  show selector-structural-heading: set heading(numbering: none)

  // show heading.where(): it => [#set heading(numbering: none)]


  show: set-indenting-for-list-and-enum-items

  show heading: it => {
    if not is-empty(it.numbering) {
      counter(heading).display(it.numbering) + [ ] + [#it.body]
    } else {
      it.body
    }
  }

  show heading: it => {
    set pad(left: 1cm)

    if it.level == 1 {
      pagebreak(weak: true)
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
      it
      v(2em)
    } else if it.level > 1 {
      set text(size: 13pt)
      v(1em)
      it
      v(1em)
    }
    header-counter.step()
  }
  doc
}
