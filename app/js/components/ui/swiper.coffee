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
      placeholderUrl: undefined

    @dataSwiperImagesAvailable = (event, data) ->
      # data.urls is required array
      @initSwiper() unless @swiper
      for url in data.urls
        # FIXME: this will keep appending slides
        @swiper.createSlide("<img src=\"#{url}\" onerror=\"this.src='#{@attr.placeholderUrl}'\">").append()

    @initSwiper = ->
      @attr.swiperConfig.onSlideChangeStart = (swiper) =>
        @trigger 'uiSwiperSlideChangeStart', { activeIndex: swiper.activeIndex, previousIndex: swiper.previousIndex }

      @attr.swiperConfig.onSlideChangeEnd = (swiper) =>
        @trigger 'uiSwiperSlideChangeEnd', { activeIndex: swiper.activeIndex, previousIndex: swiper.previousIndex }

      @attr.swiperConfig.onSlideClick = (swiper) =>
        @trigger 'uiSwiperSlideClick', { index: swiper.clickedSlideIndex }

      @$node.append("<div class='swiper-wrapper'></div>")
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
      @swiper = undefined
      @on 'dataSwiperImagesAvailable', @initSwiper
      @on 'uiSwiperWantsNextItem', @nextItem
      @on 'uiSwiperWantsPrevItem', @prevItem
      @on 'uiSwiperWantsToGoToIndex', @goToIndex
