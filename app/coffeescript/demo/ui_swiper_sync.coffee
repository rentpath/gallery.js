"use strict"
requirejs.config
  baseUrl: "bower_components"
  paths:
    components: "../js/components"
    swiper: "swiper/dist/idangerous.swiper.min"
    jquery: "jquery/dist/jquery.min"

require ["components/ui/gallery", "components/ui/gallery_syncer"], (GalleryUI, GallerySyncerUI) ->

  INTERESTING_EVENTS = ['uiGallerySlideChanged', 'uiSwiperInitialized', 'uiGallerySlideClicked']

  for eventName in INTERESTING_EVENTS
    $(document).on eventName, (event, data) ->
      console?.log?(event, data)

  GalleryUI.attachTo "#ui_swiper_sync"
  GalleryUI.attachTo "#ui_swiper"
  GalleryUI.attachTo "#ui_swiper_sync2"
  GalleryUI.attachTo "#ui_swiper2"
  GallerySyncerUI.attachTo "#sync-container", { componentsToSync: $('#sync-container .swiper-container') }
  GallerySyncerUI.attachTo "#sync-container2", { componentsToSync: $("#sync-container2 .swiper-container") }

  # Example of overriding SwiperJS defaults.
  # GalleryUI.attachTo "#ui_swiper", { swiperConfig: { loop: true } }
