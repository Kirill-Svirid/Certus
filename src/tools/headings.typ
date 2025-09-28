#let structural-heading-titles = (
  intro: [Введение],
  abstract: [Реферат],
  conclusion: [Заключение],
  content-list-ver-1: [Содержание],
  content-list-ver-2: [Оглавление],
  term-list-var-1: [Термины и определения],
  term-list-var-2: [Обозначения и сокращения],
  abbreviation-list-ver-1: [Перечень сокращений и обозначений],
  abbreviation-list-ver-2: [Обозначения и сокращения],
  performer-list: [Список исполнителей],
  reference-list-gen: [Список использованных источников],
  reference-list-docs: [Ссылочные документы],
  reference-list-legislation-docs: [Ссылочные нормативные документы],
  reference-list-bibliography: [Библиография],
  test: [Закл],
)

#let is-heading-in-structural(heading) = {
  if structural-heading-titles.values().position(it => it == heading.body) != none and heading.level == 1 {
    return true
  } else {
    return false
  }
}
