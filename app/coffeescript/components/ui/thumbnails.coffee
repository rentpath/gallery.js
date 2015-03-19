define [
  'jquery'
  'flight/lib/component'
  '../mixins/gallery_utils'
  'swiper'
], (
  $
  defineComponent
  galleryUtils
) ->
  Thumbnails = ->
    @defaultAttrs
      swiperConfig: {}
      transitionSpeed: 200

    # This component assumes that the swiper content has already been set up.
    # The component's node should contain div.swiper-wrapper which
    # should contain any number of div.swiper-slide elements.
    @initSwiper = ->
      @initializeFirstSlide()

      # swiperConfig is set here due to the fact that @defaultAttrs can be
      # clobbered when multiple instances of a component are initialized.
      swiperConfig = {}
      for key, value of @attr.swiperConfig
        swiperConfig[key] = value

      swiperConfig.onSlideClick = (swiper) =>
        @activateSlide swiper.clickedSlideIndex
        @transitionGallery @$node.find('.swiper-slide').eq(swiper.clickedSlideIndex)[0]
        @trigger 'uiGallerySlideClicked', { index: swiper.clickedSlideIndex, speed: 0 }

      @swiper = new Swiper(@node, swiperConfig)
      @trigger 'uiSwiperInitialized', { swiper: @swiper }
      @on document, 'uiGallerySlideChanged', (event, data) ->
        @activateSlide data.activeIndex
        @transitionGallery @$node.find('.swiper-slide').eq(data.activeIndex)[0]

    @slides = ->
      @swiper.slides

    @visibleSlides = ->
      @swiper.visibleSlides

    @visibleSlideCount = ->
      @visibleSlides().length

    @activateSlide = (index) ->
      @$node.find('.swiper-slide').removeClass('active-slide')
      @$node.find('.swiper-slide').eq(index).addClass('active-slide')

    @initializeFirstSlide = ->
      @$node.find('.swiper-slide').first().addClass('active-slide')

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
      @trigger 'uiGalleryWantsToGoToIndex',
        index: @lastVisibleSlideIndex(),
        speed: @attr.transitionSpeed

    @transitionGallery = (slide) ->
      if slide is @lastVisibleSlide()
        @advanceGallery()
      else if slide is @firstVisibleSlide()
        @rewindGallery()

    # Make a method that executes the conditional
    @rewindGallery = ->
      if @firstVisibleSlideIndex() > @visibleSlideCount() - 1
        @trigger 'uiGalleryWantsToGoToIndex',
          index: @firstVisibleSlideIndex() - @visibleSlideCount() + 1
          speed: @attr.transitionSpeed
      else
        @trigger 'uiGalleryWantsToGoToIndex',
          index: 0,
          speed: @attr.transitionSpeed

    @after 'initialize', ->
      @on 'uiGalleryContentReady', @initSwiper
      @on 'uiGalleryWantsToGoToIndex', @goToIndex
      $(window).on 'orientationchange', ->
        @swiper?.reInit()

  defineComponent Thumbnails, galleryUtils
