define [
  'jquery'
  'underscore'
  'flight/lib/component'
  '../mixins/gallery_utils'
  'swiper'
], (
  $
  _
  defineComponent
  galleryUtils
) ->
  Thumbnails = ->
    @defaultAttrs
      swiperConfig: {}
      transitionSpeed: 200

    @$swiperSlides = ->
      cssClass = '.' + @swiper.params.slideClass
      @$node.find(cssClass)

    @initSwiper = ->
      @initializeFirstSlide()

      # swiperConfig is set here due to the fact that @defaultAttrs can be
      # clobbered when multiple instances of a component are initialized.
      swiperConfig = _.clone(@attr.swiperConfig)

      swiperConfig.onSlideClick = (swiper) =>
        if swiper.clickedSlideIndex < @attr.photoCount
          @activateSlide swiper.clickedSlideIndex
          @trigger 'uiGallerySlideChanged', activeIndex: swiper.clickedSlideIndex

      @swiper = new Swiper(@node, swiperConfig)
      @trigger 'uiSwiperInitialized', { swiper: @swiper }
      @on document, 'uiGallerySlideChanged', (event, data) ->
        @activateSlide data.activeIndex
        @transitionGallery @$swiperSlides().eq(data.activeIndex)[0]

    @slides = ->
      @swiper.slides

    @visibleSlides = ->
      @swiper.slides.slice(@swiper.activeIndex, @swiper.activeIndex + @visibleSlideCount())

    @visibleSlideCount = ->
      if @isLastThumbnailSet()
        @slides().length - @swiper.activeIndex
      else
        @swiper.params.slidesPerView

    @activateSlide = (index) ->
      @$swiperSlides().removeClass('active-slide')
      @$swiperSlides().eq(index).addClass('active-slide')

    @initializeFirstSlide = ->
      @$swiperSlides().first().addClass('active-slide')

    @firstVisibleSlide = ->
      @visibleSlides()[0]

    @lastVisibleSlide = ->
      index = @visibleSlideCount() - 1
      @visibleSlides()[index]

    @firstVisibleSlideIndex = ->
      @slides().indexOf @firstVisibleSlide()

    @lastVisibleSlideIndex = ->
      @slides().indexOf @lastVisibleSlide()

    @rightOfVisibleSlides = (slide) ->
      @slides().indexOf(slide) > @lastVisibleSlideIndex()

    @leftOfVisibleSlides = (slide) ->
      @slides().indexOf(slide) < @firstVisibleSlideIndex()

    @isFirstThumbnailSet = ->
      @swiper.activeIndex < @swiper.params.slidesPerView

    @isLastThumbnailSet = ->
      @slides().length - @swiper.activeIndex <= @swiper.params.slidesPerView

    @advanceGallery = ->
      @trigger 'uiGalleryWantsToGoToIndex',
        index: @lastVisibleSlideIndex()
        speed: @attr.transitionSpeed

    @transitionGallery = (slide) ->
      if slide is @lastVisibleSlide()
        @advanceGallery()
      else if @rightOfVisibleSlides(slide)
        @advanceGallery()

      else if slide is @firstVisibleSlide()
        @rewindGallery()
      else if @leftOfVisibleSlides(slide)
        @rewindGallery()

    @rewindGallery = ->
      if @isFirstThumbnailSet()
        @trigger 'uiGalleryWantsToGoToIndex',
          index: 0,
          speed: @attr.transitionSpeed
      else
        @trigger 'uiGalleryWantsToGoToIndex',
          index: @firstVisibleSlideIndex() - @visibleSlideCount() + 1
          speed: @attr.transitionSpeed

    @reinitSwiper = ->
      @swiper?.reInit()

    @after 'initialize', ->
      @on 'uiGalleryContentReady', @initSwiper
      @on 'uiGalleryWantsToGoToIndex', @goToIndex
      @on 'uiGalleryDimensionsChange', @reinitSwiper

    @before 'teardown', ->
      @swiper?.destroy?(true)

  defineComponent Thumbnails, galleryUtils
