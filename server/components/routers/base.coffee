module.exports = class BaseRouter

  constructor: (@app) ->
    @usePartials ?= yes
    @viewPrefix ?= ""
    @defineRoutes()

  defineRoutes: ->

  #
  # Utilities
  #

  getViewName: (req, view) ->
    view = "_"+ view if @usePartials and req.xhr
    "#{ @viewPrefix }#{ view }"

  _resView: (req, res, view, data = {}) ->
    res.render @getViewName(req, view), data

  _redirect: (req, res) ->
    uri = req.session.redirect ? "/"
    delete req.session.redirect
    res.redirect uri

  #
  # Error handling
  #

  _handleError: (req, res, error) ->
    if req.is "json" then res.json error.code,
      status: "Error"
      error: error
    else res.render "error", {error}

  handleBadRequest: (req, res, error = {}) ->
    error.code ?= 400
    error.type ?= "Bad request"
    @_handleError req, res, error

  handleUnauthorized: (req, res, error = {}) ->
    error.code ?= 401
    error.type ?= "Unauthorized"
    @_handleError req, res, error

  handleForbidden: (req, res, error = {}) ->
    error.code ?= 403
    error.type ?= "Forbidden"
    @_handleError req, res, error

  handleNotFound: (req, res, error = {}) ->
    error.code ?= 404
    error.type ?= "Not found"
    @_handleError req, res, error

  handleServerError: (req, res, error = {}) ->
    error.code ?= 500
    error.type ?= "Server error"
    @_handleError req, res, error
