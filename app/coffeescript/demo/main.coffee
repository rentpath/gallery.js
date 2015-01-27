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
  "components/ui/lazy_loader"
], (
  SwiperUI
  SwiperContentUI
  LazyLoaderUI
) ->

  INTERESTING_EVENTS = ['uiSwiperSlideChanged', 'uiSwiperInitialized', 'uiSwiperSlideClicked', 'uiGalleryContentReady', 'dataGalleryContentAvailable', 'uiLazyLoadRequest']

  for eventName in INTERESTING_EVENTS
    $(document).on eventName, (event, data) ->
      console.log(event, data)

  IMAGES = ["/images/1.jpg", "/images/2.jpg", "/images/3.jpg", "/images/4.jpg", "/images/5.jpg"]

  SwiperContentUI.attachTo "#integration", { lazyLoadThreshold: 2 }

  $('#integration').on 'uiGalleryContentReady', ->
    SwiperUI.attachTo "#integration"

  LazyLoaderUI.attachTo "#integration"

  $('#integration').one 'uiSwiperSlideChanged', ->
    $('#integration').trigger 'uiLazyLoadRequest'

  $('#integration').trigger 'dataGalleryContentAvailable', { urls: IMAGES }
