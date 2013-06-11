define [
  "core/mvc"
  "core/promise"
  "core/util"
  "ext/mvc/model-cache"
  "components/slides-import"
  "services/socket"
], (mvc, promise, util, modelCache, slidesImport, io) ->

  class Presentation extends mvc.Model

    importSlides: (html) ->
      @set "slides", slidesImport html
      @emit "import"

    sync: (method, self, options) ->
      dfd = promise.deferred()

      url = util.result @, "url"
      io.connect url ? "/"
      io.emit method, @toJSON(), (err, data) =>
        if err then dfd.reject err
        else
          @set data
          dfd.resolve()

      dfd.promise()

  modelCache Presentation
