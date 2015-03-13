define [
  'jquery'
  'flight/lib/component'
], (
  $
  defineComponent
) ->

  defineComponent ->

    @defaultAttrs
      previousSelector: '.js-ui-navigation-previous'
      nextSelector: '.js-ui-navigation-next'
      disabledClass: 'disabled'
      loop: false

    @initializeNavigation = (event, data) ->
      if data.urls.length > 1
        @select('nextSelector').removeClass(@attr.disabledClass)
        if @attr.loop
          @select('previousSelector').removeClass(@attr.disabledClass)
        else
          @select('previousSelector').addClass(@attr.disabledClass)
      else
        @select('previousSelector').addClass(@attr.disabledClass)
        @select('nextSelector').addClass(@attr.disabledClass)

    @displayButtons = (event, data) ->
      unless @attr.loop
        if data.activeIndex > 0
          @select('previousSelector').removeClass(@attr.disabledClass)
        else
          @select('previousSelector').addClass(@attr.disabledClass)
        if (data.activeIndex + 1) < data.total
          @select('nextSelector').removeClass(@attr.disabledClass)
        else
          @select('nextSelector').addClass(@attr.disabledClass)

    @setLoopValue = (event, data) ->
      unless @attr.loop == data.swiper.params.loop
        @attr.loop = data.swiper.params.loop
        @initializeNavigation(event, {urls: data.swiper.slides})

    @after 'initialize', ->
      @on 'dataGalleryContentAvailable', @initializeNavigation
      @on 'uiGallerySlideChanged', @displayButtons
      @on 'uiSwiperInitialized', @setLoopValue

      @select('previousSelector').on 'click touchstart', (event, data) =>
        event.preventDefault()
        @trigger 'uiGalleryWantsPrevItem'

      @select('nextSelector').on 'click touchstart', (event, data) =>
        event.preventDefault()
        @trigger 'uiGalleryWantsNextItem'
