"use strict"
requirejs.config
  baseUrl: "bower_components"
  paths:
    components: "../js/components"
    swiper: "swiper/dist/idangerous.swiper.min"
    jquery: "jquery/dist/jquery.min"

require ["components/ui/swiper", "components/ui/sync_gallery"], (SwiperUI, SyncGalleryUI) ->

  INTERESTING_EVENTS = ['uiSwiperSlideChanged', 'uiSwiperInitialized', 'uiSwiperSlideClicked']

  for eventName in INTERESTING_EVENTS
    $(document).on eventName, (event, data) ->
      console.log(event, data)

  SwiperUI.attachTo "#ui_swiper_sync"
  SwiperUI.attachTo "#ui_swiper"
  SyncGalleryUI.attachTo document, { componentsToSync: ["#ui_swiper", "#ui_swiper_sync"] }

  # Example of overriding SwiperJS defaults.
  # SwiperUI.attachTo "#ui_swiper", { swiperConfig: { loop: true } }
