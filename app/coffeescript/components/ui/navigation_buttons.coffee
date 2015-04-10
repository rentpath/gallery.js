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
      numImages: 0

    @initializeNavigation = ->
      if @attr.numImages > 1
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
        @initializeNavigation()

    @setNumImages= (event, data) ->
      @attr.numImages = data.urls.length
      @initializeNavigation()

    @after 'initialize', ->
      @on 'dataGalleryContentAvailable', @setNumImages
      @on 'uiGallerySlideChanged', @displayButtons
      @on 'uiSwiperInitialized', @setLoopValue

      @select('previousSelector').on 'click', (event, data) =>
        event.preventDefault()
        @trigger 'uiGalleryWantsPrevItem'

      @select('nextSelector').on 'click', (event, data) =>
        event.preventDefault()
        @trigger 'uiGalleryWantsNextItem'
