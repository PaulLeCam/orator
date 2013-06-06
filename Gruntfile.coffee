dir =
  shared:
    root: "shared"
    templates: "shared/templates"
  client:
    bower_components: "client/bower_components"
    assets: "client/assets"
    code: "client/coffee"
    widgets: "client/widgets"
    stylus: "client/stylus"
    less: "client/less"
  build:
    root: "build"
    fonts: "build/fonts"
    css: "build/css"
    js: "build/js"
    templates: "build/js/templates"
    widgets: "build/js/widgets"
  prod:
    root: "www"
    fonts: "www/fonts"
    css: "www/css"
    js: "www/js"
    widgets: "www/js/widgets"

module.exports = (grunt) ->
  grunt.initConfig

    clean:
      build: dir.build.root
      prod: dir.prod.root
      widgets: dir.prod.widgets

    copy:
      bower_components:
        files: [
          # Core libs
          {src: "#{ dir.client.bower_components }/requirejs/require.js", dest: "#{ dir.build.js }/lib/require.js"}
          {src: "#{ dir.client.bower_components }/json3/lib/json3.js", dest: "#{ dir.build.js }/lib/json3.js"}
          {src: "#{ dir.client.bower_components }/jquery/jquery.js", dest: "#{ dir.build.js }/lib/jquery.js"}
          {src: "#{ dir.client.bower_components }/backbone/backbone.js", dest: "#{ dir.build.js }/lib/backbone.js"}
          {src: "#{ dir.client.bower_components }/lodash/dist/lodash.compat.js", dest: "#{ dir.build.js }/lib/lodash.js"}
          {src: "#{ dir.client.bower_components }/handlebars/handlebars.runtime.js", dest: "#{ dir.build.js }/lib/handlebars.js"}
          {expand: yes, cwd: "#{ dir.client.bower_components }/slob/dist", src: "**", dest: dir.build.js}
          # Bootstrap
          {expand: yes, cwd: "#{ dir.client.bower_components }/bootstrap/js", src: "*.js", dest: "#{ dir.build.js }/lib/bootstrap/"}
          {expand: yes, cwd: "#{ dir.client.bower_components }/bootstrap/fonts", src: "*", dest: dir.build.fonts}
          {expand: yes, cwd: "#{ dir.client.bower_components }/bootstrap/less", src: "*", dest: "#{ dir.client.less }/bootstrap/base/"}
          # Reveal.js
          {src: "#{ dir.client.bower_components }/reveal.js/js/reveal.js", dest: "#{ dir.build.js }/lib/reveal.js"}
          {src: "#{ dir.client.bower_components }/reveal.js/css/reveal.css", dest: "#{ dir.build.css }/reveal.css"}
        ]
      assets:
        files: [
          expand: yes
          cwd: dir.client.assets
          src: "**"
          dest: dir.build.root
        ]
      fonts:
        files: [
          expand: yes
          cwd: dir.build.fonts
          src: "*"
          dest: dir.prod.fonts
        ]

    coffee:
      shared:
        files: [
          expand: yes
          cwd: dir.shared.root
          src: "**/*.coffee"
          dest: dir.build.js
          ext: ".js"
        ]
      client:
        files: [
          expand: yes
          cwd: dir.client.code
          src: "**/*.coffee"
          dest: dir.build.js
          ext: ".js"
        ]
      widgets:
        files: [
          expand: yes
          cwd: dir.client.widgets
          src: "**/*.coffee"
          dest: dir.build.widgets
          ext: ".js"
        ]

    handlebars:
      shared:
        options:
          namespace: no
          amd: yes
        files: [
          expand: yes
          cwd: dir.shared.templates
          src: "**/*.htm"
          dest: dir.build.templates
          ext: ".js"
        ]
      widgets:
        options:
          namespace: no
          amd: yes
        files: [
          expand: yes
          cwd: dir.client.widgets
          src: "*/templates/*.htm"
          dest: dir.build.widgets
          ext: ".js"
        ]

    less:
      build:
        files: [
          expand: yes
          cwd: dir.client.less
          src: "*.less"
          dest: dir.build.css
          ext: ".css"
        ]

    watch:
      shared_code:
        files: "#{ dir.shared.root }/**/*.coffee"
        tasks: "coffee:shared"
      client_code:
        files: "#{ dir.client.code }/**/*.coffee"
        tasks: "coffee:client"
      widgets_code:
        files: "#{ dir.client.widgets }/**/*.coffee"
        tasks: "coffee:widgets"
      shared_templates:
        files: "#{ dir.shared.templates }/**/*.htm"
        tasks: "handlebars:shared"
      widgets_templates:
        files: "#{ dir.client.widgets }/*/templates/*.htm"
        tasks: "handlebars:widgets"
      less:
        files: "#{ dir.client.less }/**/*.less"
        tasks: "less"
      stylus:
        files: "#{ dir.client.stylus }/**/*.styl"
        tasks: "stylus"

    cssmin:
      prod:
        files: [
          expand: yes
          cwd: dir.build.css
          src: "**/*.css"
          dest: dir.prod.css
        ]

    requirejs:
      compile:
        options:
          baseUrl: dir.build.js
          mainConfigFile: "#{ dir.build.js }/config.js"
          dir: dir.prod.js
          modules: [
            {
              name: "app"
            }
          ]

  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-handlebars"
  grunt.loadNpmTasks "grunt-contrib-less"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-cssmin"
  grunt.loadNpmTasks "grunt-contrib-requirejs"

  grunt.registerTask "build", ["clean:build", "copy:bower_components", "copy:assets", "coffee", "handlebars", "less"]
  grunt.registerTask "dev", ["build", "watch"]
  grunt.registerTask "prod", ["build", "clean:prod", "copy:fonts", "cssmin", "requirejs", "clean:widgets"]
  grunt.registerTask "default", ["prod"]
