"use strict"
requirejs.config
  baseUrl: "bower_components"
  paths:
    components: "../js/components"
    swiper: "swiper/dist/idangerous.swiper.min"
    jquery: "jquery/dist/jquery.min"

require [
  "components/ui/gallery"
  "components/ui/content"
  "components/ui/image_loader"
  "components/ui/navigation_buttons"
  "components/ui/counter"
], (
  GalleryUI
  ContentUI
  ImageLoaderUI
  NavigationButtonsUI
  CounterUI
) ->

  INTERESTING_EVENTS = [
    'uiGallerySlideChanged'
    'uiGallerySlideClicked'
    'uiGalleryFeaturesDetected'
    'uiGalleryContentReady'
    'dataGalleryContentAvailable'
    'uiGalleryLazyLoadRequested'
  ]

  for eventName in INTERESTING_EVENTS
    $(document).on eventName, (event, data) ->
      console?.log?(event, data)

  NavigationButtonsUI.attachTo ".js-integration"
  CounterUI.attachTo ".js-integration"
  ContentUI.attachTo ".js-integration"

  $('.js-integration').on 'uiGalleryContentReady', ->
    ImageLoaderUI.attachTo ".js-integration", { lazyLoadThreshold: 2, errorUrl: '/images/missing.jpg' }
    GalleryUI.attachTo ".js-integration", { swiperConfig: { loop: true } }

  $('.js-integration').one 'uiGallerySlideChanged', ->
    $('.js-integration').trigger 'uiGalleryLazyLoadRequested'

  IMAGES = ["/images/1.jpg", "/images/2.jpg", "/images/3.jpg", "/images/4.jpg", "/images/5.jpg", "/intentional404"]

  $('.js-integration').trigger 'dataGalleryContentAvailable', { urls: IMAGES }
