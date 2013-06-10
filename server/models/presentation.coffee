debug = require("debug") "models:presentation"
fs = require "fs"
_ = require "lodash"
uuid = require "node-uuid"
promises = require "underscore.deferred"
{framework} = require "slob"

uid = -> uuid.v4().split("-").join ""

module.exports = class Presentation extends framework.mvc.Model

  sync: (method) ->
    dfd = promises.Deferred()

    switch method
      when "create" then @_create dfd, @toJSON()
      when "read" then @_read dfd, @id
      when "update" then @_update dfd, @toJSON()
      when "delete" then @_delete dfd, @id, @get "key"
      else dfd.reject new Error "Invalid method"

    dfd.promise()

  fetch: ->
    @sync "read"

  destroy: ->
    @sync "delete"

  _load: (id, cb) ->
    file = "#{ __dirname }/../slides/#{ id }"
    fs.exists file, (exists) ->
      if exists then fs.readFile file, (err, data) ->
        if err then cb err
        else cb null, JSON.parse data
      else cb new Error "Not Found"

  _save: (dfd, data) ->
    fs.writeFile "#{ __dirname }/../slides/#{ data.id }", JSON.stringify(data), (err) ->
      if err then dfd.reject new Error "Error saving data"
      else dfd.resolve data

  _create: (dfd, data) ->
    data.id = uid()
    data.key = uid()
    @_save dfd, data

  _read: (dfd, id) ->
    @_load id, (err, data) ->
      if err then dfd.reject err
      else
        delete data.key
        dfd.resolve data

  _update: (dfd, data) ->
    return dfd.reject new Error "Bad parameters" unless data.id and data.key
    @_load data.id, (err, base_data) =>
      if err then dfd.reject err
      else unless data.key is base_data.key then dfd.reject new Error "Forbidden"
      else @_save dfd, data

  _delete: (dfd, id, key) ->
    @_load id, (err, data) ->
      if err
        if err.message is "Not Found" then dfd.resolve()
        else dfd.reject err
      else if key isnt data.key then dfd.reject new Error "Forbidden"
      else fs.unlink "#{ __dirname }/../slides/#{ id }", (err) ->
        if err then dfd.reject err
        else dfd.resolve()
