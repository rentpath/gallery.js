"use strict"
requirejs.config
  baseUrl: "bower_components"
  paths:
    components: "../js/components"
    swiper: "swiper/dist/idangerous.swiper.min"
    jquery: "jquery/dist/jquery.min"

require ["components/ui/swiper", "components/ui/sync_gallery"], (SwiperUI, SyncGalleryUI) ->

  INTERESTING_EVENTS = ['uiGallerySlideChanged', 'uiSwiperInitialized', 'uiSwiperSlideClicked']

  for eventName in INTERESTING_EVENTS
    $(document).on eventName, (event, data) ->
      console?.log?(event, data)

  SwiperUI.attachTo "#ui_swiper_sync"
  SwiperUI.attachTo "#ui_swiper"
  SwiperUI.attachTo "#ui_swiper_sync2"
  SwiperUI.attachTo "#ui_swiper2"
  SyncGalleryUI.attachTo "#sync-container", { componentsToSync: $('#sync-container .swiper-container') }
  SyncGalleryUI.attachTo "#sync-container2", { componentsToSync: $("#sync-container2 .swiper-container") }

  # Example of overriding SwiperJS defaults.
  # SwiperUI.attachTo "#ui_swiper", { swiperConfig: { loop: true } }
