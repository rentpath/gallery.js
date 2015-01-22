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

    # This component assumes that the swiper content has already been setup.
    # The component's node should contain div.swiper-wrapper which
    # should contain any number of div.swiper-slide elements.
    @initSwiper = ->
      @attr.swiperConfig.onSlideChangeEnd = (swiper) =>
        @trigger 'uiSwiperSlideChanged', { activeIndex: swiper.activeIndex, previousIndex: swiper.previousIndex, total: swiper.slides.length }

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
      previousIndex = @swiper.activeIndex

      @swiper.swipeTo(data.index, data.speed)

      if data.speed == 0
        @trigger 'uiSwiperSlideChanged', { activeIndex: @swiper.activeIndex, previousIndex: previousIndex, total: @swiper.slides.length }

    @after 'initialize', ->
      @on 'uiSwiperWantsNextItem', @nextItem
      @on 'uiSwiperWantsPrevItem', @prevItem
      @on 'uiSwiperWantsToGoToIndex', @goToIndex
      @initSwiper()
