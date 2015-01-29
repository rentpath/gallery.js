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
  "components/ui/image_loader"
  "components/ui/navigation_buttons"
  "components/ui/counter"
], (
  SwiperUI
  SwiperContentUI
  ImageLoaderUI
  NavigationButtonsUI
  CounterUI
) ->

  INTERESTING_EVENTS = ['uiSwiperSlideChanged', 'uiSwiperInitialized', 'uiSwiperSlideClicked', 'uiGalleryContentReady', 'dataGalleryContentAvailable', 'uiLazyLoadRequest']

  for eventName in INTERESTING_EVENTS
    $(document).on eventName, (event, data) ->
      console.log(event, data)

  IMAGES = ["/images/1.jpg", "/images/2.jpg", "/images/3.jpg", "/images/4.jpg", "/images/5.jpg", "/intentional404"]

  NavigationButtonsUI.attachTo "#integration"
  CounterUI.attachTo "#integration" #, { counterSelector: '.ui_counter' }
  SwiperContentUI.attachTo "#integration"

  $('#integration').on 'uiGalleryContentReady', ->
    ImageLoaderUI.attachTo "#integration", { lazyLoadThreshold: 2, errorUrl: '/images/missing.jpg' }
    SwiperUI.attachTo "#integration", { swiperConfig: { loop: true } }

  $('#integration').one 'uiSwiperSlideChanged', ->
    $('#integration').trigger 'uiLazyLoadRequest'

  $('#integration').trigger 'dataGalleryContentAvailable', { urls: IMAGES }
