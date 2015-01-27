define [
  'jquery'
  'flight/lib/component'
], (
  $
  defineComponent
) ->

  defineComponent ->

    @defaultAttrs
      wrapper: 'swiper-wrapper'
      slide:   'swiper-slide'

    @contentHtml = (urls) ->
      slideHtml = ""
      for url in urls
        slideHtml += @slideHtml(url)
      "<div class=\"#{@attr.wrapper}\">#{slideHtml}</div>"

    @slideHtml = (url) ->
      "<div class=\"#{@attr.slide}\"><img data-src=\"#{url}\"></div>"

    @setup = (event, data) ->
      @$node.append(@contentHtml(data.urls))
      @trigger 'uiGalleryContentReady'

    @after 'initialize', ->
      @on 'dataGalleryContentAvailable', @setup
