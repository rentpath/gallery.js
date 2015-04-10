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

    # data.direction can either be 'forward' or 'backward'
    # This allows a user to start from the end
    @lazyLoad = (event, data) ->
      number = data?.number or @attr.lazyLoadThreshold
      direction = data?.direction or 'forward'

      if direction is 'forward'
        begin = 0
        end = number
      else
        begin = -number
        end = undefined

      @loadImages begin, end

    @triggerImageLoad = (slide, imageElement, index) ->
      @trigger 'uiGalleryImageLoad',
        index:        index
        slideElement: slide
        src:          imageElement.src
        width:        imageElement.width
        height:       imageElement.height

    @loadImages = (begin, end) ->
      @$node.find("[data-src]").slice(begin, end).each (index, element) =>
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
