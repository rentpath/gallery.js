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
      swiperConfig: {}
      autoInit: true     # for use by specs

    # This component assumes that the swiper content has already been setup.
    # The component's node should contain div.swiper-wrapper which
    # should contain any number of div.swiper-slide elements.
    @initSwiper = ->
      @attr.swiperConfig.onSlideChangeEnd = (swiper) =>
        dataPayload =
          activeIndex: swiper.activeIndex
          previousIndex: @normalizePreviousIndex(swiper.previousIndex)
          total: swiper.slides.length

        @trigger 'uiSwiperSlideChanged', dataPayload

      @attr.swiperConfig.onSlideClick = (swiper) =>
        @trigger 'uiSwiperSlideClicked', { index: swiper.clickedSlideIndex }

      @swiper = new Swiper(@node, @attr.swiperConfig)

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

      # Note: Swiper doesn't call onSlideChangeEnd when speed is 0.
      # Opened an issue:
      # https://github.com/nolimits4web/Swiper/issues/1067

      previousIndex = @normalizePreviousIndex(@swiper.activeIndex)

      @swiper.swipeTo(data.index, data.speed)

      if data.speed == 0
        dataPayload =
          activeIndex: @swiper.activeIndex
          previousIndex: previousIndex
          total: @swiper.slides.length

        @trigger 'uiSwiperSlideChanged', dataPayload

    @normalizePreviousIndex = (value) ->
      # Swiper intially reports previous index as -0
      value || 0

    @after 'initialize', ->
      @on 'uiSwiperWantsNextItem', @nextItem
      @on 'uiSwiperWantsPrevItem', @prevItem
      @on 'uiSwiperWantsToGoToIndex', @goToIndex
      @initSwiper() if @attr.autoInit
