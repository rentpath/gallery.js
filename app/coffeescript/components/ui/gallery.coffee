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
      # swiperConfig is set here due to the fact that @defaultAttrs can be
      # clobbered when multiple instances of a component are initialized.
      swiperConfig = { speed: 150 }
      for key, value of @attr.swiperConfig
        swiperConfig[key] = value

      @total = @$node.find('.swiper-slide').length

      swiperConfig.onSlideChangeStart = =>
        activeIndex = @activeIndex()
        dataPayload =
          activeIndex: activeIndex
          previousIndex: @previousIndex
          total: @total

        @trigger 'uiGallerySlideChanged', dataPayload
        @previousIndex = activeIndex

      swiperConfig.onSlideClick = (swiper) =>
        @trigger 'uiGallerySlideClicked', { index: swiper.clickedSlideIndex }

      @previousIndex = 0
      @swiper = new Swiper(@node, swiperConfig)
      @trigger 'uiSwiperInitialized', { swiper: @swiper }

    @nextItem = ->
      @swiper.swipeNext()

    @prevItem = ->
      @swiper.swipePrev()

    @activeIndex = ->
      if @swiper.params.loop then @swiper.activeLoopIndex else @swiper.activeIndex

    @goToIndex = (event, data) ->
      # data.index is required int
      # data.speed is optional (may be undefined) int (milliseconds)
      unless data.index is @activeIndex()
        @swiper.swipeTo(data.index, data.speed)

    @after 'initialize', ->
      @on 'uiGalleryContentReady', @initSwiper
      @on 'uiGalleryWantsNextItem', @nextItem
      @on 'uiGalleryWantsPrevItem', @prevItem
      @on 'uiGalleryWantsToGoToIndex', @goToIndex
      $(window).on 'orientationchange', ->
        @swiper?.reInit()
