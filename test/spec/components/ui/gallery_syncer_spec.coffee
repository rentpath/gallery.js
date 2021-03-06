define [ 'jquery' ], ($) ->
  describeComponent 'app/coffeescript/components/ui/gallery_syncer', ->

    describe '#updateSyncedGalleries', ->
      beforeEach ->
        loadFixtures('gallery_syncer.html')
        @gallery = $('.js-ui-gallery')
        @gallerySync = $('.js-ui-gallery-sync')
        @setupComponent($('.js-syncer'), {componentsToSync: [
          {$element: @gallery}
          {$element: @gallerySync, transitionSpeed: 100}
        ]})

      it 'triggers uiGalleryWantsToGoToIndex on components that need to be synced', ->
        event = {target: @gallery[0]}
        data = {activeIndex: 1}
        spyEvent = spyOnEvent('.js-ui-gallery-sync', 'uiGalleryWantsToGoToIndex')
        @component.updateSyncedGalleries(event, data)
        expect(spyEvent).toHaveBeenTriggeredOnAndWith('.js-ui-gallery-sync', {index: 1, speed: 100})

      it 'does not trigger uiGalleryWantsToGoToIndex on components that should NOT be synced', ->
        event = {target: @gallery[0]}
        data = {activeIndex: 1}
        spyEvent = spyOnEvent('.js-ui-gallery', 'uiGalleryWantsToGoToIndex')
        @component.updateSyncedGalleries(event, data)
        expect(spyEvent).not.toHaveBeenTriggeredOnAndWith('.js-ui-gallery', {index: 1, speed: 100})
