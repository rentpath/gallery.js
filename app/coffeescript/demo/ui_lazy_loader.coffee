"use strict"
requirejs.config
  baseUrl: "bower_components"
  paths:
    components: "../js/components"
    jquery: "jquery/dist/jquery.min"

require ["components/ui/lazy_loader"], (LazyLoaderUI) ->

  LazyLoaderUI.attachTo "#ui_lazy_loader"
