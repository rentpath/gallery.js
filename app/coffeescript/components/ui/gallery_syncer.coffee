define [
  'jquery'
  'flight/lib/component'
], (
  $
  defineComponent
) ->

  defineComponent ->

    @defaultAttrs
      # Attach this component to a div that wraps the galleries you would like to sync.
      # .attachTo "#sync-container", {componentsToSync: $('#sync-container .swiper-container')}
      # 'componentsToSync' is an array of DOM elements.
      componentsToSync: null

    @updateSyncedGalleries = (event, data) ->
      for component in @attr.componentsToSync
        unless $(component).is(event.target)
          @trigger component, 'uiGalleryWantsToGoToIndex',
            index: data.activeIndex,
            speed: data.syncTransitionSpeed

    @after 'initialize', ->
      @on 'uiGallerySlideChanged', @updateSyncedGalleries
