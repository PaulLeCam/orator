debug = require("debug") "routes:crud"
Router = require "../components/routers/base"
Model = require "../models/presentation"

class CrudRouter extends Router

  constructor: (app, @io) ->
    super app
    @defineIO()

  defineRoutes: ->
    @app.post "/create", => @create.apply @, arguments

  defineIO: ->
    @io.on "connection", (socket) =>
      socket.on "create", => @_create.apply @, arguments

  _create: (data = {}, next) ->
    if data.slides?.length
      new Model(data).save()
        .fail(-> next new Error "Could not save data")
        .done (saved_data) -> next null, saved_data
    else next new Error "No slides"

  create: (req, res) ->
    @_create req.body, (err, data) ->
      if err
        if err.message is "No slides" then res.json 400
        else res.json 500
      else res.json data

module.exports = (app, io) -> new CrudRouter app, io
