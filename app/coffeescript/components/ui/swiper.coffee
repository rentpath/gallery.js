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
      swiperConfig: undefined
      autoInit: true     # for use by specs
      swiper: undefined

    # This component assumes that the swiper content has already been setup.
    # The component's node should contain div.swiper-wrapper which
    # should contain any number of div.swiper-slide elements.
    @initSwiper = ->
      swiperConfig = @attr.swiperConfig || {}
      swiperConfig.onSlideChangeStart = (swiper) =>
        dataPayload =
          activeIndex: swiper.activeIndex
          previousIndex: @normalizePreviousIndex(swiper.previousIndex)
          total: swiper.slides.length

        @trigger 'uiSwiperSlideChanged', dataPayload

      swiperConfig.onSlideClick = (swiper) =>
        @trigger 'uiSwiperSlideClicked', { index: swiper.clickedSlideIndex }

      @swiper = new Swiper(@node, swiperConfig)

      $(window).on 'orientationchange', ->
        @swiper.reInit()

      @trigger 'uiSwiperInitialized', { swiper: @swiper }

    @nextItem = ->
      @swiper.swipeNext()

    @prevItem = ->
      @swiper.swipePrev()

    @goToIndex = (event, data) ->
      # data.index is required int
      # data.speed is optional (may be undefined) int (milliseconds)
      if data.index != @swiper.activeIndex
        @swiper.swipeTo(data.index, data.speed)

    @normalizePreviousIndex = (value) ->
      # Swiper intially reports previous index as -0
      value || 0

    @after 'initialize', ->
      @on 'uiSwiperWantsNextItem', @nextItem
      @on 'uiSwiperWantsPrevItem', @prevItem
      @on 'uiSwiperWantsToGoToIndex', @goToIndex
      @initSwiper() if @attr.autoInit
