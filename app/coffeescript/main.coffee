"use strict"
requirejs.config
  baseUrl: "bower_components"
  paths:
    components: "../js/components"
    page: "../js/page"
    swiper: "swiper/dist/idangerous.swiper.min"
    jquery: "jquery/dist/jquery.min"

require ["components/ui/swiper"], (SwiperUI) ->

  INTERESTING_EVENTS = ['uiSwiperSlideChanged', 'uiSwiperInitialized', 'uiSwiperSlideClicked']

  for eventName in INTERESTING_EVENTS
    $(document).on eventName, (event, data) ->
      console.log(event, data)

  SwiperUI.attachTo ".swiper-container"
  # Example of overriding SwiperJS defaults.
  #SwiperUI.attachTo ".swiper-container", { swiperConfig: { loop: true } }
