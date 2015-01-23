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
      wrapperSelector:  '.swiper-wrapper'
      slide:            'swiper-slide'

    @addWrapper = ->
      wrapperHTML = "<div class=\"#{@attr.wrapper}\"></div>"
      @$node.append(wrapperHTML)

    @appendImage = (url)->
      # TODO: add lazy loading with data-src
      slideHtml = "<div class=\"#{@attr.slide}\"><img src=\"#{url}\"></div>"
      @select('wrapperSelector').append(slideHtml)

    @setup = (event, data) ->
      @addWrapper()
      for url in data.urls
        @appendImage(url)
      @trigger 'uiGalleryContentReady'

    @after 'initialize', ->
      @on 'dataGalleryContentAvailable', @setup