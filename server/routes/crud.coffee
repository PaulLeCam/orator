debug = require("debug") "routes:crud"
Router = require "../components/routers/base"
Model = require "../models/presentation"

class CrudRouter extends Router

  constructor: (app, @io) ->
    super app

  defineRoutes: ->
    @io.on "connection", (socket) =>
      socket.on "create", => @create.apply @, arguments
      socket.on "read", => @read.apply @, arguments
      socket.on "update", => @update.apply @, arguments
      socket.on "delete", => @delete.apply @, arguments

  create: (data = {}, next) ->
    if data.slides?.length
      new Model(data).save()
        .fail((err) -> next err)
        .done (data) -> next null, data
    else next new Error "No slides"

  read: (data = {}, next) ->
    new Model(data).fetch()
      .fail((err) -> next err)
      .done (data) -> next null, data

  update: (data = {}, next) ->
    new Model(data).save()
      .fail((err) -> next err)
      .done (data) -> next null, data

  delete: (data = {}, next) ->
    new Model(data).destroy()
      .fail((err) -> next err)
      .done (data) -> next null, data


module.exports = (app, io) -> new CrudRouter app, io
