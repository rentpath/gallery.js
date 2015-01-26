"use strict"
requirejs.config
  baseUrl: "bower_components"
  paths:
    components: "../js/components"
    swiper: "swiper/dist/idangerous.swiper.min"
    jquery: "jquery/dist/jquery.min"

require [
  "components/ui/swiper"
  "components/ui/swiper_content"
], (
  SwiperUI
  SwiperContentUI
) ->

  INTERESTING_EVENTS = ['uiSwiperSlideChanged', 'uiSwiperInitialized', 'uiSwiperSlideClicked', 'uiGalleryContentReady', 'dataGalleryContentAvailable']

  for eventName in INTERESTING_EVENTS
    $(document).on eventName, (event, data) ->
      console.log(event, data)

  IMAGES = ["/images/1.jpg", "/images/2.jpg", "/images/3.jpg", "/images/4.jpg", "/images/5.jpg"]

  SwiperContentUI.attachTo "#integration"
  $('#integration').on 'uiGalleryContentReady', ->
    SwiperUI.attachTo "#integration"
  $('#integration').trigger 'dataGalleryContentAvailable', { urls: IMAGES }
