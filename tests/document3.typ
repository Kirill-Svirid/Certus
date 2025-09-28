#import "../src/tools/utils.typ": *
#import "../src/tools/enums.typ": *
#import "../src/tools/numbering.typ": *
#import "../src/style/style.typ": *

#import "@preview/codly:1.3.0": *
#import "@preview/zero:0.4.0": num, set-num, set-round, set-unit, zi


#show: style-tech-1.with()

#set-unit(
  unit-separator: sym.space.thin,
  fraction: "inline",
  breakable: false,
)

#set-num(
  product: math.dot,
  tight: true,
  decimal-separator: ",",
  group: none,
)


#set page(
  numbering: "1",
  number-align: right,
  margin: (top: 2cm, right: 1.5cm),
)


#show: enable-referenceable-enums.with()
#show: codly-init.with()



#outline()

= Введение


= Разработка текстовой документации #lorem(15)

== Подробнее  #lorem(15)

*Пример*

#set-round(precision: 2, mode: none)

Что бы определить функцию, которая вычисляет свойство свинца по формуле $rho_op("pb") (t)
= #num(11200.23)
- num(66.285) 10^(-2) dot t
- num(55.397) 10^(-5) dot t^2
+ num(17.453) 10^(-8) dot t^3$ в отдельном модуле (файле, например в `lead.typ`) внедрите следующий код:

To change the way a picture fits in your document, click it and a button for layout options appears next to it. When you work on a table, click where you want to add a row or a column, and then click the plus sign. Reading is easier, too, in the new Reading view. You can collapse parts of the document and focus on the text you want. If you need to stop reading before you reach the end, Word remembers where you left off - even on another device. Video provides a powerful way to help you prove your point.

When you click Online Video, you can paste in the embed code for the video you want to add. You can also type a keyword to search online for the video that best fits your document. To make your document look professionally produced, Word provides header, footer, cover page, and text box designs that complement each other. For example, you can add a matching cover page, header, and sidebar. Click Insert and then choose the elements you want from the different galleries.

Themes and styles also help keep your document coordinated. When you click Design and choose a new Theme, the pictures, charts, and SmartArt graphics change to match your new theme. When you apply styles, your headings change to match the new theme. Save time in Word with new buttons that show up where you need them. To change the way a picture fits in your document, click it and a button for layout options appears next to it. When you work on a table, click where you want to add a row or a column, and then click the plus sign.

Reading is easier, too, in the new Reading view. You can collapse parts of the document and focus on the text you want. If you need to stop reading before you reach the end, Word remembers where you left off - even on another device. Video provides a powerful way to help you prove your point. When you click Online Video, you can paste in the embed code for the video you want to add. You can also type a keyword to search online for the video that best fits your document. To make your document look professionally produced, Word provides header, footer, cover page, and text box designs that complement each other. For example, you can add a matching cover page, header, and sidebar. Click Insert and then choose the elements you want from the different galleries. Themes and styles also help keep your document coordinated.

When you click Design and choose a new Theme, the pictures, charts, and SmartArt graphics change to match your new theme. When you apply styles, your headings change to match the new theme. Save time in Word with new buttons that show up where you need them. To change the way a picture fits in your document, click it and a button for layout options appears next to it. When you work on a table, click where you want to add a row or a column, and then click the plus sign. Reading is easier, too, in the new Reading view.

You can collapse parts of the document and focus on the text you want. If you need to stop reading before you reach the end, Word remembers where you left off - even on another device. Video provides a powerful way to help you prove your point. When you click Online Video, you can paste in the embed code for the video you want to add. You can also type a keyword to search online for the video that best fits your document. To make your document look professionally produced, Word provides header, footer, cover page, and text box designs that complement each other. For example, you can add a matching cover page, header, and sidebar. Click Insert and then choose the elements you want from the different galleries.



```typst
// Плотность свинца [кг/м^3], температура - К
#let rho(t) = {
  assert(t > 0, message: "Допускается только температура выше абсолютного нуля!")
  let value = (
    11200.23
            - 66.285 * calc.pow(10, -2) * calc.pow(t, 1)
            - 55.397 * calc.pow(10, -5) * calc.pow(t, 2)
            + 17.453 * calc.pow(10, -8) * calc.pow(t, 3)
  )
  return value
}
```
Тогда применить функцию в другом документе можно следующим образом:
- Импортировать функцию из модуля `lead.typ`
- Вызвать функцию с аргументом #sym.dash.en температурой в К, например 700 К.

#figure(
  caption: [Объявление и вызов функции],
  supplement: "Блок",
  ```typst
  // Импорт модуля
  #import "lead.typ"
  // Вызов в теле документа
  #lead.rho(700)
  ```,
)

= Редактирование

#show: enum-heading-numbering

+ Заметьте, что имя функции не включает в себя информацию о том, плотность какого материала она вычисляет.
+ Эта задача решается именем модуля.
+ Это удобно, потому что обеспечивается однообразие синтаксиса обращения к разрабатываемому функционалу.
+ Можно иметь набор функций для вычисления свойств различных материалов в соответствующих модулях, например в `sodium.typ`, `potassium.typ`, `mercury.typ` и тд и обращаться к ним одним образом.

= Заключение


= Библиография

