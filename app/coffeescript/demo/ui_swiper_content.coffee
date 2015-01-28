"use strict"
requirejs.config
  baseUrl: "bower_components"
  paths:
    components: "../js/components"
    jquery: "jquery/dist/jquery.min"

require ["components/ui/swiper_content"], (SwiperContentUI) ->

  INTERESTING_EVENTS = ['uiGalleryContentReady']

  for eventName in INTERESTING_EVENTS
    $('#ui_swiper_content').on eventName, (event, data) ->
      console.log(event, data)

  SwiperContentUI.attachTo "#ui_swiper_content"
