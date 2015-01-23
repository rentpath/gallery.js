"use strict"
requirejs.config
  baseUrl: "bower_components"
  paths:
    components: "../js/components"
    page: "../js/page"
    swiper: "swiper/dist/idangerous.swiper.min"
    jquery: "jquery/dist/jquery.min"

require ["components/ui/swiper", "components/ui/swiper_content"], (SwiperUI, SwiperContentUI) ->

  INTERESTING_EVENTS = ['uiSwiperSlideChanged', 'uiSwiperInitialized', 'uiSwiperSlideClicked', 'uiGalleryContentReady', 'dataGalleryContentAvailable']

  for eventName in INTERESTING_EVENTS
    $(document).on eventName, (event, data) ->
      console.log(event, data)

  # Demo for components/ui/swiper
  SwiperUI.attachTo "#ui_swiper"
  # Example of overriding SwiperJS defaults.
  #SwiperUI.attachTo "#ui_swiper", { swiperConfig: { loop: true } }

  IMAGES = ["/images/1.jpg", "/images/2.jpg", "/images/3.jpg", "/images/4.jpg", "/images/5.jpg"]

  # Demo for components/ui/swiper_content
  SwiperContentUI.attachTo "#ui_swiper_content"
  $('#ui_swiper_content').trigger 'dataGalleryContentAvailable', { urls: IMAGES }

  # Integration demo
  SwiperContentUI.attachTo "#integration"
  $('#integration').on 'uiGalleryContentReady', ->
    SwiperUI.attachTo "#integration"
  $('#integration').trigger 'dataGalleryContentAvailable', { urls: IMAGES }
