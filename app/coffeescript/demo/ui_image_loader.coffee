"use strict"
requirejs.config
  baseUrl: "bower_components"
  paths:
    components: "../js/components"
    jquery: "jquery/dist/jquery.min"
    underscore: 'underscore/underscore'

require ["components/ui/image_loader"], (LazyLoaderUI) ->

  LazyLoaderUI.attachTo ".js-ui-image-loader", { lazyLoadThreshold: 2, errorUrl: '/images/missing.jpg' }
