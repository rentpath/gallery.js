define [
  'jquery'
  'flight/lib/component'
], (
  $
  defineComponent
) ->

  defineComponent ->

    @defaultAttrs
      wrapper:          'swiper-wrapper'
      slide:            'swiper-slide'

    @slideHtml = (url)->
      # TODO: add lazy loading with data-src
      "<div class=\"#{@attr.slide}\"><img src=\"#{url}\"></div>"

    @contentHtml = (urls) ->
      slideHtml = ""
      for url in urls
        slideHtml += @slideHtml(url)
      "<div class=\"#{@attr.wrapper}\">#{slideHtml}</div>"

    @setup = (event, data) ->
      @$node.append(@contentHtml(data.urls))
      @trigger 'uiGalleryContentReady'

    @after 'initialize', ->
      @on 'dataGalleryContentAvailable', @setup
