"use strict"
require [
  "components/ui/gallery"
  "components/ui/content"
  "components/ui/image_loader"
  "components/ui/keyboard_navigation"
  "components/ui/navigation_buttons"
  "components/ui/counter"
], (
  GalleryUI
  ContentUI
  ImageLoaderUI
  KeyboardNavigationUI
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
    'uiGalleryWantsNextItem'
    'uiGalleryWantsPrevItem'
    'uiGalleryImageLoad'
  ]

  selector = '.js-integration'

  for eventName in INTERESTING_EVENTS
    $(selector).on eventName, (event, data) ->
      console?.log?(event, data)

  KeyboardNavigationUI.attachTo selector
  NavigationButtonsUI.attachTo selector
  CounterUI.attachTo selector
  ContentUI.attachTo selector
  ImageLoaderUI.attachTo selector, { lazyLoadThreshold: 2, errorUrl: '/images/missing.jpg' }
  GalleryUI.attachTo selector, { swiperConfig: { loop: true } }

  $(selector).one 'uiGallerySlideChanged', ->
    $(selector).trigger 'uiGalleryLazyLoadRequested'

  IMAGES = ["/images/1.jpg", "/images/2.jpg", "/images/3.jpg", "/images/4.jpg", "/images/5.jpg", "/intentional404"]

  $(selector).trigger 'dataGalleryContentAvailable', { urls: IMAGES }
