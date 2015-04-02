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

    @lazyLoad = (event, data) ->
      number = data?.number or @attr.lazyLoadThreshold
      @loadImages number

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
      @$node.find("[data-src]").slice(0, num).each (index, element) =>
        element = $(element)

        if element.prop('tagName') is 'IMG'
          if @attr.errorUrl
            element.on 'error', => element.attr 'src', @attr.errorUrl
          element.on 'load', =>
            @triggerImageLoad element, element[0], index
          element.attr 'src', element.attr('data-src')
        else
          # For tracking onload
          # Browser still makes one HTTP request
          imageElement = new Image
          $(imageElement).on 'load', =>
            @triggerImageLoad  element, imageElement, index
          imageElement.src = element.attr('data-src')

          element.css 'background-image', "url(#{element.attr('data-src')})"

        element.removeAttr 'data-src'

    @after 'initialize', ->
      @on 'uiGalleryContentReady', @lazyLoad
      @on 'uiGalleryLazyLoadRequested', @lazyLoad
