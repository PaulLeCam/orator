define [
  "sandbox/widget"
], (sandbox) ->

  (previousPage) ->
    if previousPage?
      sandbox.dom.find("#content").load "/"


