debug = require("debug") "models:presentation"
fs = require "fs"
uuid = require "node-uuid"
promises = require "underscore.deferred"
{framework} = require "slob"

uid = -> uuid.v4().split("-").join ""

module.exports = class Presentation extends framework.mvc.Model

  sync: (method, self, options) ->
    dfd = promises.Deferred()

    switch method
      when "create" then @_create dfd, @toJSON()
      when "update" then @_update dfd, @toJSON()

    dfd.promise()

  _create: (dfd, data) ->
    data.id = uid()
    data.key = uid()

    fs.writeFile "#{ __dirname }/../slides/#{ data.id }.json", JSON.stringify(data), (err) =>
      if err then dfd.reject new Error "Error saving data"
      else dfd.resolve data

  _update: (dfd, data) ->
    # Check data.id
    # Sanitize data (remove key attributes)
