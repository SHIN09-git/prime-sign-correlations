#let ink = rgb("#202a30")
#let accent = rgb("#155761")
#let muted = rgb("#52666c")
#let lead(label, body) = block(width:100%, inset:(x:8pt,y:6pt), fill:rgb("#edf4f4"), stroke:(left:1.3pt+accent),
  [#text(weight:"bold",fill:accent)[#label] #h(.3em) #body])
#let sub(t) = block(sticky:true,above:.6em,below:.22em,text(fill:accent,weight:"bold")[#t])
#let dd = math.dif
#let layout(lang, title, running, body) = {
  set document(title:title,author:("GPT-6.2 Astra","JIN HANZHE"),
    description: if lang=="zh" {"短区间素数计数的首次反转、仿射素数对与符号密度"} else {"First reversal of prime sign correlations, affine prime pairs and finite-height observations"})
  set page(width: if lang=="zh" {177mm} else {187mm},height: if lang=="zh" {205mm} else {229mm},
    margin:(x:16mm,top:18mm,bottom:17mm),
    header:context if counter(page).get().first()>1 {text(size:8pt,fill:muted)[#running #h(1fr) GPT-6.2 Astra · JIN HANZHE]},
    footer:context align(right,text(size:8pt,fill:muted,counter(page).display("1"))))
  set text(font: if lang=="zh" {("Libertinus Serif",sys.inputs.at("cjk",default:"SimSun"))} else {"Libertinus Serif"},
    lang:lang,size:if lang=="zh" {10.6pt}else{11.2pt},fill:ink)
  set par(justify:true,leading:.59em,spacing:.50em)
  set heading(numbering:"1.")
  show heading.where(level:1): set text(size:16pt,weight:"bold")
  show heading.where(level:1): set block(above:.6em,below:.5em)
  set math.equation(numbering:"(1)")
  show math.equation.where(block:true): set block(above:.50em,below:.45em)
  text(size:8.4pt,fill:muted)[#if lang=="zh" [解析数论 · 研究预印本] else [ANALYTIC NUMBER THEORY · PREPRINT] #h(1fr) #if lang=="zh" [2026 年 11 月 22 日] else [22 November 2026]]
  v(3.5mm)
  block(width:100%, {
    set par(justify:false)
    text(size:if lang=="zh"{21pt}else{22pt},weight:"bold",hyphenate:false)[#title]
  })
  v(2.6mm)
  text(size:12.5pt,fill:accent)[GPT-6.2 Astra #h(1.25em) JIN HANZHE]
  v(2.8mm)
  body
}
