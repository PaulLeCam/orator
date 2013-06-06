debug = require("debug") "server"
express = require "express"
app = express()
server = require("http").createServer app
io = require("socket.io").listen server
env = app.settings.env

app.engine "jade", require("jade").__express

app.configure ->
  @set "views", "#{ __dirname }/views"
  @set "view engine", "jade"

  @use express.logger "dev"
  @use express.compress()
  # Statics
  @use express.favicon()
  if env is "production"
    @use express.static "#{ __dirname }/../www"
  else
    @use express.static "#{ __dirname }/../build"
  # Data
  @use express.bodyParser()
  # Locals
  @use require("slob").middleware "#{ __dirname }/../shared"
  # Error handling
  @use express.errorHandler()

require("./routes/default") app
require("./routes/crud") app, io

port = process.env.PORT ? 3001
server.listen port
debug "listening on port #{ port }"
