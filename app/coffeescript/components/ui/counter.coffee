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
      counterSelector: '.ui_counter'

    @initializeCounter = (event, data) ->
      $(@attr.counterSelector).text('1 of ' + data.urls.length)

    @updateCounter = (event, data) ->
      $(@attr.counterSelector).text((data.activeIndex + 1) + ' of ' + data.total)

    @after 'initialize', ->
      @on 'dataGalleryContentAvailable', @initializeCounter
      @on 'uiSwiperSlideChanged', @updateCounter
