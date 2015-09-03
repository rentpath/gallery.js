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

    # Assign data-index once. This is used b/c #loadImages needs the absolute
    # and not relative index
    @assignIndex = ->
      @$node.find("[data-src]").each (index) ->
        ele = $ @
        ele.attr 'data-index', index unless ele.attr('data-index')

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
      if end
        elements = @$node.find("[data-src]").slice(begin, end)
      else
        # Normally, you can set `end` to `undefined` and it will work like it
        # was not set. But IE8 does not behave this way.
        elements = @$node.find("[data-src]").slice(begin)

      elements.each (_index, element) =>
        element = $(element)
        index = parseInt element.attr('data-index'), 10

        # For tracking onload
        # Browser still makes one HTTP request
        imageElement = new Image
        $(imageElement).on 'load', =>
          @triggerImageLoad  element, imageElement, index
        imageElement.src = element.attr('data-src')

        if element.prop('tagName') is 'IMG'
          @setImageSrc element
        else
          @setBackgroundImageSrc element

    @setImageSrc = (element) ->
      if @attr.errorUrl
        element.on 'error', =>
          # element.attr 'src', @attr.errorUrl
          # We need to get the 'real' DOM element
          @$node.find("img[data-index=#{element.data('index')}]").attr('src', @attr.errorUrl)
      element
        .attr 'src', element.attr('data-src')
        .removeAttr 'data-src'

    @setBackgroundImageSrc = (element) ->
      imageUrl = element.attr('data-src')
      errorUrl = @attr.errorUrl
      img = new Image
      img.onload = ->
        element
          .css 'background-image', "url(#{imageUrl})"
          .removeAttr 'data-src'
      img.onerror = ->
        element
          .css 'background-image', "url(#{errorUrl})"
          .removeAttr 'data-src'
      img.src = imageUrl

    @after 'initialize', ->
      @on 'uiGalleryContentReady', @assignIndex
      @on 'uiGalleryContentReady', @lazyLoad
      @on 'uiGalleryLazyLoadRequested', @lazyLoad
