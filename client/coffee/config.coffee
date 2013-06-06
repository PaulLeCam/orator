require.config

  baseUrl: "/js"
  deps: [
    "json3"
  ]

  shim:
    # Libs
    backbone:
      deps: ["underscore", "jquery"]
      exports: "Backbone"
    handlebars:
      exports: "Handlebars"
    # Bootstrap
    "bootstrap-affix":
      deps: ["jquery"]
    "bootstrap-alert":
      deps: ["jquery", "bootstrap-transition"]
    "bootstrap-button":
      deps: ["jquery"]
    "bootstrap-carousel":
      deps: ["jquery", "bootstrap-transition"]
    "bootstrap-collapse":
      deps: ["jquery", "bootstrap-transition"]
    "bootstrap-dropdown":
      deps: ["jquery"]
    "bootstrap-modal":
      deps: ["jquery", "bootstrap-transition"]
    "bootstrap-popover":
      deps: ["jquery", "bootstrap-tooltip"]
    "bootstrap-scrollspy":
      deps: ["jquery"]
    "bootstrap-tab":
      deps: ["jquery", "bootstrap-transition"]
    "bootstrap-tooltip":
      deps: ["jquery", "bootstrap-transition"]
    "bootstrap-transition":
      deps: ["jquery"]
    # App
    reveal:
      exports: "Reveal"
    socketio:
      exports: "io"

  paths:
    # Utilities
    json3: "lib/json3"
    jquery: "lib/jquery"
    underscore: "lib/lodash"
    backbone: "lib/backbone"
    handlebars: "lib/handlebars"
    # Bootstrap
    "bootstrap-affix": "lib/bootstrap/affix"
    "bootstrap-alert": "lib/bootstrap/alert"
    "bootstrap-button": "lib/bootstrap/button"
    "bootstrap-carousel": "lib/bootstrap/carousel"
    "bootstrap-collapse": "lib/bootstrap/collapse"
    "bootstrap-dropdown": "lib/bootstrap/dropdown"
    "bootstrap-modal": "lib/bootstrap/modal"
    "bootstrap-popover": "lib/bootstrap/popover"
    "bootstrap-scrollspy": "lib/bootstrap/scrollspy"
    "bootstrap-tab": "lib/bootstrap/tab"
    "bootstrap-tooltip": "lib/bootstrap/tooltip"
    "bootstrap-transition": "lib/bootstrap/transition"
    # App libs
    reveal: "lib/reveal"
    socketio: "../socket.io/socket.io"
