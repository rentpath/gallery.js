define [], () ->
  describeMixin 'app/coffeescript/components/mixins/gallery_utils', ->
    beforeEach ->
      @setupComponent()

    describe 'activeIndex()', ->
      it 'returns @swiper.activeLoopIndex when @swiper.params.loop is truthy', ->
        @component.swiper.params = {loop: true}
        @component.swiper.activeLoopIndex = 5
        expect(@component.activeIndex()).toEqual(5)

      it 'returns @swiper.activeIndex when @swiper.params.loop is falsy', ->
        @component.swiper.params = {loop: false}
        @component.swiper.activeIndex = 7
        expect(@component.activeIndex()).toEqual(7)

    describe 'goToIndex()', ->
      it 'does nothing if data.index is the active index', ->
        @component.activeIndex = -> 42
        spyOn(@component.swiper, 'swipeTo')
        @component.goToIndex(null, {index: 42})
        expect(@component.swiper.swipeTo).not.toHaveBeenCalled()

      describe 'when data.index is not the active index', ->
        beforeEach ->
          @component.activeIndex = -> 42

        it 'calls @swiper.swipeTo()', ->
          spyOn(@component.swiper, 'swipeTo')
          @component.goToIndex(null, {index: 1, speed: 2})
          expect(@component.swiper.swipeTo).toHaveBeenCalledWith(1, 2)

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

