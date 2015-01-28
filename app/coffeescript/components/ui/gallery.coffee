define [
  'jquery'
  'flight/lib/component'
  'components/ui/swiper'
  'components/ui/swiper_content'
  'components/ui/image_loader'
], (
  $
  defineComponent
  SwiperUI
  SwiperContentUI
  ImageLoaderUI
) ->

  # This component orchestrates various lower-level components.
  # After attaching it, kick everything off by triggering
  # a 'dataGalleryContentAvailable' event with 'urls' (array of image urls)
  # for the SwiperContentUI subcomponent.

  defineComponent ->

    @defaultAttrs
      # ImageLoaderUI options:
      errorUrl: undefined
      lazyLoadThreshold: undefined

    @adaptSwiperUiEvents = ->
      # Events from SwiperUI:
      @on 'uiSwiperSlideChanged', (ev, data) =>
        @trigger 'uiGallerySlideChanged', data
      @on 'uiSwiperSlideClicked', (ev, data) =>
        @trigger 'uiGallerySlideClicked', data
      @on 'uiSwiperInitialized', (ev, data) =>
        @trigger 'uiGalleryFeaturesDetected', data.swiper.support

      # Events to SwiperUI:
      @on 'uiGalleryWantsNextItem', (ev, data) =>
        @trigger 'uiSwiperWantsNextItem', data
      @on 'uiGalleryWantsPrevItem', (ev, data) =>
        @trigger 'uiSwiperWantsPrevItem', data
      @on 'uiGalleryWantsToGoToIndex', (ev, data) =>
        @trigger 'uiSwiperWantsToGoToIndex', data

    @after 'initialize', ->
      @adaptSwiperUiEvents()

      @on 'uiGalleryContentReady', =>
        ImageLoaderUI.attachTo @$node, { lazyLoadThreshold: @attr.lazyLoadThreshold, errorUrl: @attr.errorUrl }
        SwiperUI.attachTo @$node

      SwiperContentUI.attachTo @$node

      # After first slide change, lazy load remaining images.
      @$node.one 'uiSwiperSlideChanged', =>
        @trigger 'uiLazyLoadRequest'
