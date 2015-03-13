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
      # 'componentsToSync' is an array of JS objects with the following structure:
      # {$element: $(".swiper-container"), transitionSpeed: 300}
      # transitionSpeed is optional.
      componentsToSync: null

    @updateSyncedGalleries = (event, data) ->
      for component in @attr.componentsToSync
        unless component.$element.is(event.target)
          @trigger component.$element, 'uiGalleryWantsToGoToIndex',
            index: data.activeIndex,
            speed: component.transitionSpeed

    @after 'initialize', ->
      @on 'uiGallerySlideChanged', @updateSyncedGalleries
