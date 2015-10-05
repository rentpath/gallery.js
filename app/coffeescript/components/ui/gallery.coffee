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
      # Navigation clicks are not counted during the transition. Raising the
      # speed may result in missed clicks.
      swiperConfig.speed = 125

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

    @reinitSwiper = ->
      @swiper?.reInit()

    @after 'initialize', ->
      @on 'uiGalleryContentReady', @initSwiper
      @on 'uiGalleryWantsNextItem', @nextItem
      @on 'uiGalleryWantsPrevItem', @prevItem
      @on 'uiGalleryWantsToGoToIndex', @goToIndex
      @on 'uiGalleryDimensionsChange', @reinitSwiper

    @before 'teardown', ->
      @swiper?.destroy true

  defineComponent Gallery, galleryUtils
