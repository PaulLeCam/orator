define [
  "sandbox/service"
], (sandbox) ->

  class Router extends sandbox.routing.Router

    routes:
      "": "home"

    home: ->
      @loadPage "home"

  new Router