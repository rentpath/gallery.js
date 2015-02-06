"use strict"
requirejs.config
  baseUrl: "bower_components"
  paths:
    components: "../js/components"
    swiper: "swiper/dist/idangerous.swiper.min"
    jquery: "jquery/dist/jquery.min"

require ["components/ui/swiper"], (SwiperUI) ->

  INTERESTING_EVENTS = ['uiGallerySlideChanged', 'uiGalleryFeaturesDetected', 'uiGallerySlideClicked']

  for eventName in INTERESTING_EVENTS
    $(document).on eventName, (event, data) ->
      console?.log?(event, data)

  SwiperUI.attachTo "#ui_swiper"
  # Example of overriding SwiperJS defaults.
  #SwiperUI.attachTo "#ui_swiper", { swiperConfig: { loop: true } }
