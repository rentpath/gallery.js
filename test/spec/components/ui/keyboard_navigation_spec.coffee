define [ 'jquery' ], ($) ->

  describeComponent 'gallery/components/ui/keyboard_navigation', ->
    beforeEach ->
      fixture = readFixtures "gallery_page.html"
      @setupComponent fixture, { galleryNode: 'div[data-gallery="gallery1"]'}

    describe '#evaluatekeydown', ->
      spy = null

      describe 'non-gallery keydown', ->
        beforeEach ->
          spy = jasmine.createSpy 'uiGalleryWantsPrevItem'
          $('div[data-gallery="gallery1"]').on 'uiGalleryWantsPrevItem', spy

        it 'should not trigger a gallery event on keydown', ->
          $('input').trigger 'keydown', { which: 37 }
          expect(spy).not.toHaveBeenCalled()

      describe 'uiGalleryWantsPrevItem', ->
        beforeEach ->
          spy = jasmine.createSpy 'uiGalleryWantsPrevItem'
          $('div[data-gallery="gallery1"]').on 'uiGalleryWantsPrevItem', spy

        it 'should trigger on left arrow keydown', ->
          $('div[data-gallery="gallery1"]').trigger 'keydown', { which: 37 }
          expect(spy).toHaveBeenCalled()

        it 'should trigger minus sign keydown', ->
          $('div[data-gallery="gallery1"]').trigger 'keydown', { which: 109 }
          expect(spy).toHaveBeenCalled()

      describe 'uiGalleryWantsNextItem', ->
        beforeEach ->
          spy = jasmine.createSpy 'uiGalleryWantsNextItem'
          $('[data-gallery="gallery1"]').on 'uiGalleryWantsNextItem', spy

        it 'should trigger on right arrow keydown', ->
          $('[data-gallery="gallery1"]').trigger 'keydown', { which: 39 }
          expect(spy).toHaveBeenCalled()

        it 'should trigger plus sign keydown', ->
          $('[data-gallery="gallery1"]').trigger 'keydown', { which: 107 }
          expect(spy).toHaveBeenCalled()