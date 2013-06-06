debug = require("debug") "cluster"
cluster = require "cluster"
cluster.setupMaster
  exec: "server/app.js"

cpus = require("os").cpus().length
debug "setting up %s forks...", cpus
cluster.fork() for i in [0..cpus]

cluster.on "exit", (worker) ->
  debug "worker exit, forking new one"
  cluster.fork()
