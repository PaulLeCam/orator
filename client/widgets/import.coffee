define [
  "sandbox/widget"
  "models/presentation"
], (sandbox, Presentation) ->

  class ImportSlides extends sandbox.Widget

    events:
      submit: "import"

    import: ->
      @$alert.addClass "hide"
      @model.importSlides @$input.val()
      if @model.get("slides").length
        sandbox.emit "import", @model
      else
        @$alert.removeClass "hide"
      no

    initialize: ->
      @model = new Presentation
      super()

    render: ->
      @$input = @$el.find "textarea"
      @$alert = @$el.find ".alert"
      @
