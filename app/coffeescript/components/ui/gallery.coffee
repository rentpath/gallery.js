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
      # swiperConfig is set here due to the fact that @defaultAttrs can be
      # clobbered when multiple instances of a component are initialized.
      swiperConfig = {}
      for key, value of @attr.swiperConfig
        swiperConfig[key] = value
      swiperConfig.onSlideChangeStart = (swiper) =>
        if swiper.params.loop
          dataPayload =
            activeIndex: swiper.activeLoopIndex
            previousIndex: @normalizePreviousIndex(swiper.previousIndex)
            total: $(swiper.slides).not('.swiper-slide-duplicate').length
        else
          dataPayload =
            activeIndex: swiper.activeIndex
            previousIndex: @normalizePreviousIndex(swiper.previousIndex)
            total: swiper.slides.length

        @trigger 'uiGallerySlideChanged', dataPayload

      swiperConfig.onSlideClick = (swiper) =>
        @trigger 'uiGallerySlideClicked', { index: swiper.clickedSlideIndex }

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
      @on 'uiGalleryWantsNextItem', @nextItem
      @on 'uiGalleryWantsPrevItem', @prevItem
      @on 'uiGalleryWantsToGoToIndex', @goToIndex
      @initSwiper() if @attr.autoInit
