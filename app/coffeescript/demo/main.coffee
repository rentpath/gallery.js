"use strict"
requirejs.config
  baseUrl: "bower_components"
  paths:
    components: "../js/components"
    swiper: "swiper/dist/idangerous.swiper.min"
    jquery: "jquery/dist/jquery.min"

require [
  "components/ui/gallery"
  "components/ui/navigation_buttons"
  "components/ui/counter"
], (
  GalleryUI
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
    $('#integration').on eventName, (event, data) ->
      console.log(event, data) if console && console.log

  GalleryUI.attachTo "#integration", { lazyLoadThreshold: 2, errorUrl: '/images/missing.jpg' }
  NavigationButtonsUI.attachTo "#integration"
  CounterUI.attachTo "#integration" #, { activeSelector: '.js-ui-counter-active', totalSelector: '.js-ui-counter-total' }

  IMAGES = ["/images/1.jpg", "/images/2.jpg", "/images/3.jpg", "/images/4.jpg", "/images/5.jpg", "/intentional404"]

  $('#integration').trigger 'dataGalleryContentAvailable', { urls: IMAGES }
