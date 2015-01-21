"use strict"
requirejs.config
  baseUrl: "bower_components"
  paths:
    components: "../js/components"
    page: "../js/page"
    swiper: "swiper/dist/idangerous.swiper.min"
    jquery: "jquery/dist/jquery.min"

require ["components/ui/swiper"], (SwiperUI) ->

  for eventName in ['uiSwiperSlideChanged', 'uiSwiperInitialized', 'uiSwiperSlideClick']
    $(document).on eventName, (event, data) ->
      console.log(event, data)

  SwiperUI.attachTo ".swiper-container"
