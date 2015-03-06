define [ 'jquery' ], ($) ->

  describeComponent 'gallery/components/ui/keyboard_navigation', ->
    beforeEach ->
      fixture = readFixtures "gallery_page.html"
      @setupComponent fixture, {modalSelector: '.modal'}

    describe '#evaluatekeydown', ->

      beforeEach ->
        @event = $.Event 'keydown'
        @selector = 'div[data-gallery="gallery1"]'

      describe 'when input has focus', ->

        it 'should not trigger on keydown', ->
          spyEvent = spyOnEvent @selector, 'uiGalleryWantsPrevItem'
          @event.which = 37
          $('input').focus()
          $(document).trigger @event
          expect(spyEvent).not.toHaveBeenTriggeredOn(@selector)

      describe 'when a dialog modal is open', ->

        it 'should not trigger on keydown', ->
          spyEvent = spyOnEvent @selector, 'uiGalleryWantsPrevItem'
          @event.which = 37
          $('#modal-container').append('<div class="modal"></div>')
          $(document).trigger @event
          expect(spyEvent).not.toHaveBeenTriggeredOn(@selector)

      describe 'uiGalleryWantsPrevItem', ->

        beforeEach ->
          @spyEvent = spyOnEvent @selector, 'uiGalleryWantsPrevItem'

        it 'should trigger on left arrow keydown', ->
          @event.which = 37
          $(document).trigger @event
          expect(@spyEvent).toHaveBeenTriggeredOn(@selector)

        it 'should trigger on "-" keydown', ->
          @event.which = 189
          $(document).trigger @event
          expect(@spyEvent).toHaveBeenTriggeredOn(@selector)

        it 'should trigger on "-" (keypad) keydown', ->
          @event.which = 109
          $(document).trigger @event
          expect(@spyEvent).toHaveBeenTriggeredOn(@selector)

      describe 'uiGalleryWantsNextItem', ->

        beforeEach ->
          @spyEvent = spyOnEvent @selector, 'uiGalleryWantsNextItem'

        it 'should trigger on right arrow keydown', ->
          @event.which = 39
          $(document).trigger @event
          expect(@spyEvent).toHaveBeenTriggeredOn(@selector)

        it 'should trigger on "+" keydown', ->
          @event.which = 187
          $(document).trigger @event
          expect(@spyEvent).toHaveBeenTriggeredOn(@selector)

        it 'should trigger on "+" (keypad) keydown', ->
          @event.which = 107
          $(document).trigger @event
          expect(@spyEvent).toHaveBeenTriggeredOn(@selector)