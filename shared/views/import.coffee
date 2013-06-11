run = (mvc, tmpl, decorate, exp) ->

  exp decorate class ImportView extends mvc.View

    template: tmpl

    render: ->
      @renderer @template()


if typeof exports is "undefined" # Browser
  define [
    "core/mvc"
    "templates/import"
    "ext/mvc/view-from-server"
    "ext/mvc/view-renderer"
  ], (mvc, tmpl, viewFromServer, viewRenderer) ->
    decorate = viewFromServer viewRenderer
    run mvc, Presentation, tmpl, decorate, (c) -> c

else # Node
  {framework} = require "slob"
  tmpl = framework.template.load "#{ __dirname }/../templates/import.htm"
  decorate = (c) -> c
  run framework.mvc, tmpl, decorate, (c) -> module.exports = c
