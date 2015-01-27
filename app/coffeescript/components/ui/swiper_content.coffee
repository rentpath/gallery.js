define [
  'jquery'
  'flight/lib/component'
], (
  $
  defineComponent
) ->

  defineComponent ->

    @defaultAttrs
      wrapper:           'swiper-wrapper'
      slide:             'swiper-slide'
      # To enable lazy loading, set to the number of items NOT to lazy load.
      # Example: If set to 2, then the 3rd and later items will be lazy loaded.
      lazyLoadThreshold: undefined

    @contentHtml = (urls) ->
      slideHtml = ""
      index = 0
      for url in urls
        slideHtml += @slideHtml(url, index)
        index++
      "<div class=\"#{@attr.wrapper}\">#{slideHtml}</div>"

    @slideHtml = (url, index) ->
      "<div class=\"#{@attr.slide}\"><img #{@srcAttr(index)}=\"#{url}\"></div>"

    @srcAttr = (index) ->
      if index >= @attr.lazyLoadThreshold then 'data-src' else 'src'

    @setup = (event, data) ->
      @$node.append(@contentHtml(data.urls))
      @trigger 'uiGalleryContentReady'

    @after 'initialize', ->
      @on 'dataGalleryContentAvailable', @setup
