run = (BasePresentation, exp) ->

  exp class Presentation extends BasePresentation

    store: new BasePresentation.Store
    urlRoot: "/"


if typeof exports is "undefined" # Browser
  define ["models/presentation-base"], (BasePresentation) ->
    run BasePresentation, (c) -> c

else # Node
  BasePresentation = require "#{ __dirname }/../../server/models/presentation"
  run BasePresentation, (c) -> module.exports = c
