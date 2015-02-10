define [
  'jquery'
  'flight/lib/component'
], (
  $
  defineComponent
) ->

  defineComponent ->

    @defaultAttrs
      errorUrl: undefined
      # To enable lazy loading, set to the index where lazy loading is to start.
      # Example: If set to 2, then the first two images will be loaded
      # after initialization.  The 3rd and later items will be lazy loaded
      # when uiGalleryLazyLoadRequested is received.
      lazyLoadThreshold: undefined

    @initialLoad = ->
      @loadImages(@attr.lazyLoadThreshold)

    @lazyLoad = ->
      @loadImages()

    @loadImages = (num) ->
      # num is the number of images to load
      # num may be undefined to indicate all images
      errorUrl = @attr.errorUrl
      @$node.find("img[data-src]").slice(0, num).each ->
        img = $(@)

        if errorUrl
          img.on 'error', -> @src = errorUrl

        img.attr('src', img.attr('data-src')).removeAttr('data-src')

    @after 'initialize', ->
      @on 'uiGalleryContentReady', @initialLoad
      @on 'uiGalleryLazyLoadRequested', @lazyLoad
