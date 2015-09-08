define [], () ->
  describeMixin 'app/coffeescript/components/mixins/gallery_utils', ->
    beforeEach ->
      @setupComponent()

    describe 'goToIndex()', ->
      it 'does nothing if data.index is the active index', ->
        @component.activeIndex = 42
        spyOn(@component.swiper, 'slideTo')
        @component.goToIndex(null, {index: 42})
        expect(@component.swiper.slideTo).not.toHaveBeenCalled()

      describe 'when data.index is not the active index', ->
        beforeEach ->
          @component.activeIndex = -> 42

        it 'calls @swiper.swipeTo()', ->
          spyOn(@component.swiper, 'slideTo')
          @component.goToIndex(null, {index: 1, speed: 2})
          expect(@component.swiper.slideTo).toHaveBeenCalledWith(1, 2)

        describe 'a hack for ensuring correct swiping behavior in Chrome', ->
          it 'quickly shows and hides the tray if the tray is not visible', ->
            @component.$node.hide() # Make tray invisible
            spyOn(@component.$node, 'show')
            spyOn(@component.$node, 'hide')
            @component.goToIndex(null, {index: 1, speed: 2})
            expect(@component.$node.show).toHaveBeenCalled()
            expect(@component.$node.hide).toHaveBeenCalled()

          it 'does not hide the tray if the tray is visible', ->
            spyOn(@component.$node, 'show')
            spyOn(@component.$node, 'hide')
            @component.goToIndex(null, {index: 1, speed: 2})
            expect(@component.$node.show).not.toHaveBeenCalled()
            expect(@component.$node.hide).not.toHaveBeenCalled()

