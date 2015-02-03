define [ 'jquery' ], ($) ->
  describeComponent 'gallery/components/ui/sync_gallery', ->

    describe '#updateSyncedComponents', ->
      beforeEach ->
        @fixture = readFixtures('sync_gallery.html')
        @setupComponent(@fixture, { componentsToSync: ['#ui_swiper', '#ui_swiper_sync'] })

      it 'triggers uiSwiperWantsToGoToIndex on components that need to be synced', ->
        event = {target: {id: 'ui_swiper'}}
        data = {activeIndex: 1}
        spyEvent = spyOnEvent('#ui_swiper_sync', 'uiSwiperWantsToGoToIndex')
        @component.updateSyncedComponents(event, data)
        expect(spyEvent).toHaveBeenTriggeredOnAndWith('#ui_swiper_sync', {index: 1})

      it 'does not trigger uiSwiperWantsToGoToIndex on components that should NOT be synced', ->
        event = {target: {id: 'ui_swiper'}}
        data = {activeIndex: 1}
        spyEvent = spyOnEvent('#ui_swiper', 'uiSwiperWantsToGoToIndex')
        @component.updateSyncedComponents(event, data)
        expect(spyEvent).not.toHaveBeenTriggeredOnAndWith('#ui_swiper', {index: 1})
