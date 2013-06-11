define [
  "core/dom"
], (dom) ->

  toJSON = (html) ->
    slides = []
    for section in dom.find "> section", dom.parse html
      subsections = dom.find "section", section
      if subsections.length then slides.push slides: (html: slide.outerHTML for slide in subsections)
      else slides.push slides: [html: section.outerHTML]
    slides

  toJSON
