define [
  "sandbox/component"
  "components/slides-import"
  "services/socket"
], (sandbox, slidesImport, io) ->

  class Presentation extends sandbox.mvc.Model

    importSlides: (html) ->
      @set "slides", slidesImport html

    sync: (method, self, options) ->
      dfd = sandbox.deferred()

      url = sandbox.util.result @, "url"
      io.connect url ? "/"
      io.emit method, @toJSON(), (err, data) =>
        if err then dfd.reject err
        else
          @set data
          dfd.resolve()

      dfd.promise()
