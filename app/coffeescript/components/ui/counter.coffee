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
      activeSelector: '.js-ui-counter-active'
      totalSelector: '.js-ui-counter-total'

    @initializeCounter = (event, data) ->
      $(@attr.activeSelector).text 1
      $(@attr.totalSelector).text data.urls.length

    @updateCounter = (event, data) ->
      $(@attr.activeSelector).text (data.activeIndex + 1)

    @after 'initialize', ->
      @on 'dataGalleryContentAvailable', @initializeCounter
      @on 'uiSwiperSlideChanged', @updateCounter
