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

      it 'calls @swiper.swipeTo() if data.index is not the active index', ->
        @component.activeIndex = -> 42
        spyOn(@component.swiper, 'swipeTo')
        @component.goToIndex(null, {index: 1, speed: 2})
        expect(@component.swiper.swipeTo).toHaveBeenCalledWith(1, 2)
