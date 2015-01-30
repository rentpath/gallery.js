define [
  'jquery'
  'flight/lib/component'
  'swiper'
], (
  $
  defineComponent
) ->

  defineComponent ->

    @defaultAttrs
      previousSelector: '.js-ui-navigation-previous'
      nextSelector: '.js-ui-navigation-next'
      loop: false

    @initializeNavigation = (event, data) ->
      if data.urls.length > 1
        $(@attr.nextSelector).show()
        if @attr.loop then $(@attr.previousSelector).show() else $(@attr.previousSelector).hide()
      else
        $(@attr.previousSelector).hide()
        $(@attr.nextSelector).hide()

    @handleButtons = (event, data) ->
      unless @attr.loop
        if (data.activeIndex > 0) then $(@attr.previousSelector).show() else $(@attr.previousSelector).hide()
        if ((data.activeIndex + 1) < data.total) then $(@attr.nextSelector).show() else $(@attr.nextSelector).hide()

    @setLoopValue = (event, data) ->
      @attr.loop = data.loop
      @initializeNavigation(event, {urls: data.swiper.slides})

    @after 'initialize', ->
      @on 'dataGalleryContentAvailable', @initializeNavigation
      @on 'uiSwiperSlideChanged', @handleButtons
      @on 'uiSwiperInitialized', @setLoopValue

      $(@attr.previousSelector).on 'click', (event, data) =>
        event.preventDefault()
        @trigger 'uiSwiperWantsPrevItem'

      $(@attr.nextSelector).on 'click', (event, data) =>
        event.preventDefault()
        @trigger 'uiSwiperWantsNextItem'
