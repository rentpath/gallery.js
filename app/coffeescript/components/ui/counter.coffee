define [
  'jquery'
  'flight/lib/component'
], (
  $
  defineComponent
) ->

  defineComponent ->

    @defaultAttrs
      activeSelector: '.js-ui-counter-active'
      totalSelector: '.js-ui-counter-total'

    @initializeCounter = (event, data) ->
      @select('activeSelector').text 1
      @select('totalSelector').text(data.urls.length)

    @updateCounter = (event, data) ->
      @select('activeSelector').text(data.activeIndex + 1)

    @after 'initialize', ->
      @on 'dataGalleryContentAvailable', @initializeCounter
      @on 'uiGallerySlideChanged', @updateCounter