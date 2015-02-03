define [
  'jquery'
  'flight/lib/component'
], (
  $
  defineComponent
) ->

  defineComponent ->

    @defaultAttrs
      componentsToSync: []

    @updateSyncedComponents = (event, data) ->
      target = "#" + event.target.id
      for component in @attr.componentsToSync
        if component != target
          $(component).trigger('uiSwiperWantsToGoToIndex', {index: data.activeIndex})

    @after 'initialize', ->
      @on 'uiSwiperSlideChanged', @updateSyncedComponents
