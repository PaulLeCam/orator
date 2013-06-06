define [
  "sandbox/service"
  "socketio"
], (sandbox, io) ->

  socket = null

  connect: (uri) ->
    socket = io.connect uri
    sandbox.dev.log "Socket connected to #{ uri }"
    socket

  on: (ev, cb) ->
    if socket? then socket.on ev, => cb.apply socket, arguments
    else sandbox.dev.warn "Could not listen to event `#{ ev }`: socket is not connected"

  emit: (args...) ->
    if socket? then socket.emit.apply socket, args
    else sandbox.dev.warn "Could not emit event `#{ args[0] }`: socket is not connected"
