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
      swiperConfig = {}
      for key, value of @attr.swiperConfig
        swiperConfig[key] = value

      # This only works if we've not changed the swiper slide class.
      # Use @swiper.swiperClass instead.
      @total = @$node.find('.swiper-slide').length

      # This only works if we've not changed the swiper slide class.
      # Use @swiper.swiperClass instead.
      # set first slide to active
      @$node.find('.swiper-slide').first().addClass('active-slide')

      # handle event
      @on document, 'uiGallerySlideClicked', (event, data) ->
        @activateSlide data.index
        @transitionGallery data.slide

      swiperConfig.onSlideChangeStart = =>
        activeIndex = @activeIndex()
        dataPayload =
          activeIndex: activeIndex
          previousIndex: @previousIndex
          total: @total

        @trigger 'uiGallerySlideChanged', dataPayload
        @previousIndex = activeIndex

        # $('.js-modal-thumbnail-gallery .swiper-slide').eq(activeIndex).click()


      swiperConfig.onSlideClick = (swiper) =>
        @trigger 'uiGallerySlideClicked', { index: swiper.clickedSlideIndex, slide: swiper.clickedSlide }

        # # $('.js-modal-gallery').trigger 'uiGalleryWantsToGoToIndex',
        # #   index: swiper.clickedSlideIndex
        #   speed: 0

      @previousIndex = 0
      @swiper = new Swiper(@node, swiperConfig)
      @trigger 'uiSwiperInitialized', { swiper: @swiper }

    @nextItem = ->
      @swiper.swipeNext()

    @prevItem = ->
      @swiper.swipePrev()

    @activeIndex = ->
      if @swiper.params.loop then @swiper.activeLoopIndex else @swiper.activeIndex

    # data.index is required int
    # data.speed is optional (may be undefined) int (milliseconds)
    @goToIndex = (event, data) ->
      unless data.index is @activeIndex()
        @swiper.swipeTo(data.index, data.speed)

    @slides = ->
      @swiper.slides

    @visibleSlides = ->
      @swiper.visibleSlides

    @visibleSlideCount = ->
      @visibleSlides().length

    # This only works if we've not changed the swiper slide class.
    # Use @swiper.swiperClass instead.
    @activateSlide = (index) ->
      @$node.find('.swiper-slide').removeClass('active-slide')
      @$node.find('.swiper-slide').eq(index).addClass('active-slide')

    @slideSelector = ->
      '.' + @swiper.slideClass

    @firstVisibleSlide = ->
      @visibleSlides()[0]

    @lastVisibleSlide = ->
      index = @visibleSlideCount() - 1
      @visibleSlides()[index]

    @firstVisibleSlideIndex = ->
      @slides().indexOf @firstVisibleSlide()

    @lastVisibleSlideIndex = ->
      @slides().indexOf @lastVisibleSlide()

    @advanceGallery = ->
      @trigger 'uiGalleryWantsToGoToIndex', { index: @lastVisibleSlideIndex(), speed: 200 }

    @rewindGallery = ->
      # make a method that executes the conditional
      if @firstVisibleSlideIndex() > @visibleSlideCount() - 1
        index = @firstVisibleSlideIndex() - @visibleSlideCount() + 1
        @trigger 'uiGalleryWantsToGoToIndex', { index: index, speed: 200 }
      else
        @trigger 'uiGalleryWantsToGoToIndex', { index: 0, speed: 200 }

    @transitionGallery = (slide) ->
      if slide is @lastVisibleSlide()
        @advanceGallery()
      else if slide is @firstVisibleSlide()
        @rewindGallery()

    @after 'initialize', ->
      @on 'uiGalleryContentReady', @initSwiper
      @on 'uiGalleryWantsNextItem', @nextItem
      @on 'uiGalleryWantsPrevItem', @prevItem
      @on 'uiGalleryWantsToGoToIndex', @goToIndex
      $(window).on 'orientationchange', ->
        @swiper?.reInit()
