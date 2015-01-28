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
      # when uiLazyLoadRequest is received.
      lazyLoadThreshold: undefined

    @loadImages = (num) ->
      # num may be undefined to indicate all images
      @$node.find("img[data-src]").slice(0, num).each ->
        img = $(@)
        img.attr('src', img.attr('data-src')).removeAttr('data-src')

    @initialLoad = ->
      @loadImages(@attr.lazyLoadThreshold)

    @lazyLoad = ->
      @loadImages()

    @setupImageErrorHandler = ->
      return unless @attr.errorUrl?
      errorUrl = @attr.errorUrl
      @$node.find('img').on 'error', ->
        @src = errorUrl

    @after 'initialize', ->
      @setupImageErrorHandler()
      @on 'uiLazyLoadRequest', @lazyLoad
      @initialLoad()
