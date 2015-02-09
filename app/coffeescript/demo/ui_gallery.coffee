"use strict"
requirejs.config
  baseUrl: "bower_components"
  paths:
    components: "../js/components"
    swiper: "swiper/dist/idangerous.swiper.min"
    jquery: "jquery/dist/jquery.min"

require ["components/ui/gallery"], (GalleryUI) ->

  INTERESTING_EVENTS = ['uiGallerySlideChanged', 'uiGalleryFeaturesDetected', 'uiGallerySlideClicked']

  for eventName in INTERESTING_EVENTS
    $(document).on eventName, (event, data) ->
      console?.log?(event, data)

  GalleryUI.attachTo ".js-ui-gallery"
  # Example of overriding SwiperJS defaults.
  # GalleryUI.attachTo ".js-ui-gallery", { swiperConfig: { loop: true } }