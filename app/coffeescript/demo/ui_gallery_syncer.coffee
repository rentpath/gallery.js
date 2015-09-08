"use strict"
requirejs.config
  baseUrl: "bower_components"
  paths:
    components: "../js/components"
    swiper: "swiper/dist/js/swiper.min"
    jquery: "jquery/dist/jquery.min"
    underscore: 'underscore/underscore'

require ["components/ui/gallery", "components/ui/gallery_syncer"], (GalleryUI, GallerySyncerUI) ->

  INTERESTING_EVENTS = ['uiGallerySlideChanged', 'uiSwiperInitialized', 'uiGallerySlideClicked']

  for eventName in INTERESTING_EVENTS
    $(document).on eventName, (event, data) ->
      console?.log?(event, data)

  GalleryUI.attachTo ".js-ui-gallery-sync"
  GalleryUI.attachTo ".js-ui-gallery"
  GalleryUI.attachTo ".js-ui-gallery-sync2"
  GalleryUI.attachTo ".js-ui-gallery2"
  GallerySyncerUI.attachTo ".js-sync-container", { componentsToSync: $('.js-sync-container .swiper-container') }
  GallerySyncerUI.attachTo ".js-sync-container2", { componentsToSync: $(".js-sync-container2 .swiper-container") }

  $(".js-ui-gallery").trigger "uiGalleryContentReady"
  $(".js-ui-gallery-sync").trigger "uiGalleryContentReady"
  $(".js-ui-gallery2").trigger "uiGalleryContentReady"
  $(".js-ui-gallery-sync2").trigger "uiGalleryContentReady"
