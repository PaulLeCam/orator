debug = require("debug") "routes:default"
Router = require "../components/routers/base"

class DefaultRouter extends Router

  constructor: (app, @io) ->
    super app

  defineRoutes: ->
    @app.get "/", => @home.apply @, arguments

  home: (req, res) ->
    res.render "default/home"

module.exports = (app, io) -> new DefaultRouter app, io
