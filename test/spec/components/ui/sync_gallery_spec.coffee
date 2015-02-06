define [ 'jquery' ], ($) ->
  describeComponent 'gallery/components/ui/sync_gallery', ->

    describe '#updateSyncedComponents', ->
      beforeEach ->
        loadFixtures('sync_gallery.html')
        @swiper = $('#ui_swiper')
        @swiperSync = $('#ui_swiper_sync')
        @setupComponent($('#syncer'), { componentsToSync: [@swiper, @swiperSync] })

      it 'triggers uiGalleryWantsToGoToIndex on components that need to be synced', ->
        event = {target: @swiper[0]}
        data = {activeIndex: 1}
        spyEvent = spyOnEvent('#ui_swiper_sync', 'uiGalleryWantsToGoToIndex')
        @component.updateSyncedComponents(event, data)
        expect(spyEvent).toHaveBeenTriggeredOnAndWith('#ui_swiper_sync', {index: 1})

      it 'does not trigger uiGalleryWantsToGoToIndex on components that should NOT be synced', ->
        event = {target: @swiper[0]}
        data = {activeIndex: 1}
        spyEvent = spyOnEvent('#ui_swiper', 'uiGalleryWantsToGoToIndex')
        @component.updateSyncedComponents(event, data)
        expect(spyEvent).not.toHaveBeenTriggeredOnAndWith('#ui_swiper', {index: 1})
