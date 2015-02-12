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

  selector = '.js-integration'

  for eventName in INTERESTING_EVENTS
    $(selector).on eventName, (event, data) ->
      console?.log?(event, data)

  NavigationButtonsUI.attachTo selector
  CounterUI.attachTo selector
  ContentUI.attachTo selector
  ImageLoaderUI.attachTo selector, { lazyLoadThreshold: 2, errorUrl: '/images/missing.jpg' }
  GalleryUI.attachTo selector, { swiperConfig: { loop: true } }

  $(selector).one 'uiGallerySlideChanged', ->
    $(selector).trigger 'uiGalleryLazyLoadRequested'

  IMAGES = ["/images/1.jpg", "/images/2.jpg", "/images/3.jpg", "/images/4.jpg", "/images/5.jpg", "/intentional404"]

  $(selector).trigger 'dataGalleryContentAvailable', { urls: IMAGES }
