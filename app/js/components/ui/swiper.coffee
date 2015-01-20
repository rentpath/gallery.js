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
      @attr.swiperConfig.onSlideChangeStart = (swiper) =>
        @trigger 'uiSwiperSlideChangeStart', { activeIndex: swiper.activeIndex, previousIndex: swiper.previousIndex }

      @attr.swiperConfig.onSlideChangeEnd = (swiper) =>
        @trigger 'uiSwiperSlideChangeEnd', { activeIndex: swiper.activeIndex, previousIndex: swiper.previousIndex }

      @attr.swiperConfig.onSlideClick = (swiper) =>
        @trigger 'uiSwiperSlideClick', { index: swiper.clickedSlideIndex }

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
      @swiper.swipeTo(data.index, data.speed)

    @after 'initialize', ->
      @on 'uiSwiperWantsNextItem', @nextItem
      @on 'uiSwiperWantsPrevItem', @prevItem
      @on 'uiSwiperWantsToGoToIndex', @goToIndex
      @initSwiper()
