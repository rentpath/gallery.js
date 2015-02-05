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
      swiperConfig: {}

    @after 'initialize', ->
      @on 'uiGalleryContentReady', =>
        ImageLoaderUI.attachTo @$node, { lazyLoadThreshold: @attr.lazyLoadThreshold, errorUrl: @attr.errorUrl }
        SwiperUI.attachTo @$node, { swiperConfig: @attr.swiperConfig }

      SwiperContentUI.attachTo @$node

      # After first slide change, lazy load remaining images.
      @$node.one 'uiGallerySlideChanged', =>
        @trigger 'uiLazyLoadRequest'
