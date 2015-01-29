"use strict"
requirejs.config
  baseUrl: "bower_components"
  paths:
    components: "../js/components"
    jquery: "jquery/dist/jquery.min"

require ["components/ui/image_loader"], (LazyLoaderUI) ->

  LazyLoaderUI.attachTo "#ui_image_loader", { lazyLoadThreshold: 2, errorUrl: '/images/missing.jpg' }
