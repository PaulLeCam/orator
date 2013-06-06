require [
  "sandbox/widget"
  "services/router"
  "models/presentation"
  "./config"
], (sandbox, router, Presentation) ->

  # Dev only!
  sandbox.dev.active = yes
  window.sandbox = sandbox

  # sandbox.routing.start
  #   pushState: on

  data = """
  <div class="slides">
    <section>
        <h1>
            <br>
        </h1>
        <h1>
            <br>
        </h1>
        <h1>Welcome</h1>
    </section>
    <section>
        <section>
            <h2>Slide 1</h2>
        </section>
        <section>
            <h2>Slide 1.1</h2>
        </section>
    </section>
    <section>
        <h2>slide 2</h2>
    </section>
    <section>
        <section>
            <h2>slide 3</h2>
        </section>
        <section>
            <h2>slide 3.1</h2>
        </section>
    </section>
  </div>
  """

  p = new Presentation().importSlides data

  sandbox.dev.log "presentation", p
  p.save()
    .fail(-> console.error "failed")
    .done -> console.log "presentation saved", p.toJSON()
