define [
  "sandbox/component"
], (sandbox) ->

  toJSON = (html) ->
    slides = []
    for section in sandbox.dom.find "> section", sandbox.dom.parse html
      subsections = sandbox.dom.find "section", section
      if subsections.length then slides.push slides: (html: slide.outerHTML for slide in subsections)
      else slides.push slides: [html: section.outerHTML]
    slides

  toJSON
