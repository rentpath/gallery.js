define [ 'jquery' ], ($) ->
  describeComponent 'gallery/components/ui/swiper', ->
    TIMEOUT = 500

    beforeEach ->
      @fixture = readFixtures('swiper.html')

    describe '#initSwiper', ->
      beforeEach ->
        @setupComponent(@fixture, { autoInit: false })

      it 'configures the Swiper', ->
        @component.initSwiper()
        expect(@component.swiper).toBeDefined()

      it 'triggers uiSwiperInitialized', ->
        spy = spyOnEvent(@component.node, 'uiSwiperInitialized')
        @component.initSwiper()
        expect('uiSwiperInitialized').toHaveBeenTriggeredOnAndWith(@component.node, { swiper: @component.swiper, loop: false })

    describe 'events', ->
      beforeEach ->
        @setupComponent(@fixture)

      it "calls swiper.swipeNext() after uiSwiperWantsNextItem", ->
        spy = spyOn(@component.swiper, 'swipeNext')
        @component.$node.trigger('uiSwiperWantsNextItem')
        expect(spy).toHaveBeenCalled()

      it "calls swiper.swipePrev() after uiSwiperWantsPrevItem", ->
        spy = spyOn(@component.swiper, 'swipePrev')
        @component.$node.trigger('uiSwiperWantsPrevItem')
        expect(spy).toHaveBeenCalled()

      it "calls swiper.swipeTo() after uiSwiperWantsToGoToIndex", ->
        spy = spyOn(@component.swiper, 'swipeTo')
        @component.$node.trigger('uiSwiperWantsToGoToIndex', { index: 1, speed: 0 })
        expect(spy).toHaveBeenCalledWith(1, 0)

      it "triggers uiSwiperSlideChanged after swipeNext()", (done) ->
        spy = spyOnEvent(@component.node, 'uiSwiperSlideChanged')
        @component.swiper.swipeNext()

        # wait for async event from swiper
        setTimeout =>
          expect('uiSwiperSlideChanged').toHaveBeenTriggeredOnAndWith(@component.node, { activeIndex: 1, previousIndex: 0, total: 4 })
          done()
        , TIMEOUT

      it "triggers uiSwiperSlideChanged after swipePrev()", (done) ->
        @component.swiper.swipeTo(1, 0)
        spy = spyOnEvent(@component.node, 'uiSwiperSlideChanged')
        @component.swiper.swipePrev()

        # wait for async event from swiper
        setTimeout =>
          expect('uiSwiperSlideChanged').toHaveBeenTriggeredOnAndWith(@component.node, { activeIndex: 0, previousIndex: 1, total: 4 })
          done()
        , TIMEOUT

      it "triggers uiSwiperSlideChanged after swipeTo()", (done) ->
        spy = spyOnEvent(@component.node, 'uiSwiperSlideChanged')
        @component.swiper.swipeTo(3)

        # wait for async event from swiper
        setTimeout =>
          expect('uiSwiperSlideChanged').toHaveBeenTriggeredOnAndWith(@component.node, { activeIndex: 3, previousIndex: 0, total: 4 })
          done()
        , TIMEOUT

      it "triggers uiSwiperSlideClicked after a click", ->
        spy = spyOnEvent(@component.node, 'uiSwiperSlideClicked')
        $('.swiper-slide')[2].click()

        expect('uiSwiperSlideClicked').toHaveBeenTriggeredOnAndWith(@component.node, { index: 2 })
