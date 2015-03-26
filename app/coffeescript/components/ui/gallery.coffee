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

  Gallery = ->
    @defaultAttrs
      swiperConfig: {}

    # This component assumes that the swiper content has already been setup.
    # The component's node should contain div.swiper-wrapper which
    # should contain any number of div.swiper-slide elements.
    @initSwiper = ->
      # swiperConfig is set here due to the fact that @defaultAttrs can be
      # clobbered when multiple instances of a component are initialized.
      swiperConfig = _.clone(@attr.swiperConfig)

      @total = @$node.find('.swiper-slide').length

      swiperConfig.onSlideChangeStart = =>
        @trigger 'uiGallerySlideChanged',
          activeIndex: @activeIndex()
          previousIndex: @previousIndex
          total: @total
        @previousIndex = @activeIndex()

      @previousIndex = 0
      @swiper = new Swiper(@node, swiperConfig)
      @trigger 'uiSwiperInitialized', { swiper: @swiper }

    @nextItem = ->
      @swiper.swipeNext()

    @prevItem = ->
      @swiper.swipePrev()

    @after 'initialize', ->
      @on 'uiGalleryContentReady', @initSwiper
      @on 'uiGalleryWantsNextItem', @nextItem
      @on 'uiGalleryWantsPrevItem', @prevItem
      @on 'uiGalleryWantsToGoToIndex', @goToIndex
      @on document, 'uiGallerySlideClicked', @goToIndex
      $(window).on 'orientationchange', ->
        @swiper?.reInit()

  defineComponent Gallery, galleryUtils
