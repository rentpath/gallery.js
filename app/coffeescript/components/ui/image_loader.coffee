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

    @triggerImageLoad = (slide, imageElement, index) ->
      @trigger 'uiGalleryImageLoad',
        index:        index
        slideElement: slide
        src:          imageElement.src
        width:        imageElement.width
        height:       imageElement.height

    @loadImages = (num) ->
      # num is the number of images to load
      # num may be undefined to indicate all images
      @$node.find("[data-src]").slice(0, num).each (index, img) =>
        img = $(img)

        if img.prop('tagName') is 'IMG'
          if errorUrl = @attr.errorUrl
            img.on 'error', -> @src = errorUrl
          img.on 'load', =>
            @triggerImageLoad img, img[0], index
          img.attr 'src', img.attr('data-src')
        else
          # For tracking onload
          # Browser still makes one HTTP request
          imageElement = new Image
          $(imageElement).on 'load', =>
            @triggerImageLoad  img, imageElement, index
          imageElement.src = img.attr('data-src')

          img.css 'background-image', "url(#{img.attr('data-src')})"

        img.removeAttr 'data-src'

    @after 'initialize', ->
      @on 'uiGalleryContentReady', @initialLoad
      @on 'uiGalleryLazyLoadRequested', @lazyLoad
