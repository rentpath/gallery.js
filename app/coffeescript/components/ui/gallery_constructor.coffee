define [
  'jquery'
  'flight/lib/component'
  'components/ui/gallery'
  'components/ui/content'
  'components/ui/image_loader'
], (
  $
  defineComponent
  GalleryUI
  ContentUI
  ImageLoaderUI
) ->

  # This component is not for production use.
  # It is being used as an architectural exploration.

  # This component orchestrates various lower-level components.
  # After attaching it, kick everything off by triggering
  # a 'dataGalleryContentAvailable' event with 'urls' (array of image urls)
  # for the ContentUI subcomponent.

  defineComponent ->

    @defaultAttrs
      # ImageLoaderUI options:
      errorUrl: undefined
      lazyLoadThreshold: undefined
      swiperConfig: {}

    @after 'initialize', ->
      @on 'uiGalleryContentReady', =>
        ImageLoaderUI.attachTo @$node, { lazyLoadThreshold: @attr.lazyLoadThreshold, errorUrl: @attr.errorUrl }
        GalleryUI.attachTo @$node, { swiperConfig: @attr.swiperConfig }

      ContentUI.attachTo @$node

      # After first slide change, lazy load remaining images.
      @$node.one 'uiGallerySlideChanged', =>
        @trigger 'uiLazyLoadRequest'
