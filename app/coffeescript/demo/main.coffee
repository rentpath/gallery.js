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
    'uiLazyLoadRequest'
  ]

  for eventName in INTERESTING_EVENTS
    $(document).on eventName, (event, data) ->
      console?.log?(event, data)

  NavigationButtonsUI.attachTo "#integration"
  CounterUI.attachTo "#integration" #, { activeSelector: '.js-ui-counter-active', totalSelector: '.js-ui-counter-total' }
  ContentUI.attachTo "#integration"

  $('#integration').on 'uiGalleryContentReady', ->
    ImageLoaderUI.attachTo "#integration", { lazyLoadThreshold: 2, errorUrl: '/images/missing.jpg' }
    GalleryUI.attachTo "#integration", { swiperConfig: { loop: true } }

  $('#integration').one 'uiGallerySlideChanged', ->
    $('#integration').trigger 'uiLazyLoadRequest'

  IMAGES = ["/images/1.jpg", "/images/2.jpg", "/images/3.jpg", "/images/4.jpg", "/images/5.jpg", "/intentional404"]

  $('#integration').trigger 'dataGalleryContentAvailable', { urls: IMAGES }
