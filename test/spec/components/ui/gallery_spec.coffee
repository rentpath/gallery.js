define [ 'jquery' ], ($) ->
  describeComponent 'gallery/components/ui/gallery', ->
    TIMEOUT = 500

    beforeEach ->
      @fixture = readFixtures('gallery.html')

    describe '#initSwiper', ->
      beforeEach ->
        @setupComponent(@fixture, { autoInit: false })

      it 'configures the Swiper', ->
        @component.initSwiper()
        expect(@component.swiper).toBeDefined()

      it 'triggers uiSwiperInitialized', ->
        spy = spyOnEvent(@component.node, 'uiSwiperInitialized')
        @component.initSwiper()
        expect('uiSwiperInitialized').toHaveBeenTriggeredOnAndWith(@component.node, { swiper: @component.swiper })

    describe 'events', ->
      beforeEach ->
        @setupComponent(@fixture)

      it "calls swiper.swipeNext() after uiGalleryWantsNextItem", ->
        spy = spyOn(@component.swiper, 'swipeNext')
        @component.$node.trigger('uiGalleryWantsNextItem')
        expect(spy).toHaveBeenCalled()

      it "calls swiper.swipePrev() after uiGalleryWantsPrevItem", ->
        spy = spyOn(@component.swiper, 'swipePrev')
        @component.$node.trigger('uiGalleryWantsPrevItem')
        expect(spy).toHaveBeenCalled()

      it "calls swiper.swipeTo() after uiGalleryWantsToGoToIndex", ->
        spy = spyOn(@component.swiper, 'swipeTo')
        @component.$node.trigger('uiGalleryWantsToGoToIndex', { index: 1, speed: 0 })
        expect(spy).toHaveBeenCalledWith(1, 0)

      it "triggers uiGallerySlideChanged after swipeNext()", (done) ->
        spy = spyOnEvent(@component.node, 'uiGallerySlideChanged')
        @component.swiper.swipeNext()

        # wait for async event from swiper
        setTimeout =>
          expect('uiGallerySlideChanged').toHaveBeenTriggeredOnAndWith(@component.node, { activeIndex: 1, previousIndex: 0, total: 4 })
          done()
        , TIMEOUT

      it "triggers uiGallerySlideChanged after swipePrev()", (done) ->
        @component.swiper.swipeTo(1, 0)
        spy = spyOnEvent(@component.node, 'uiGallerySlideChanged')
        @component.swiper.swipePrev()

        # wait for async event from swiper
        setTimeout =>
          expect('uiGallerySlideChanged').toHaveBeenTriggeredOnAndWith(@component.node, { activeIndex: 0, previousIndex: 1, total: 4 })
          done()
        , TIMEOUT

      it "triggers uiGallerySlideChanged after swipeTo()", (done) ->
        spy = spyOnEvent(@component.node, 'uiGallerySlideChanged')
        @component.swiper.swipeTo(3)

        # wait for async event from swiper
        setTimeout =>
          expect('uiGallerySlideChanged').toHaveBeenTriggeredOnAndWith(@component.node, { activeIndex: 3, previousIndex: 0, total: 4 })
          done()
        , TIMEOUT

      it "triggers uiGallerySlideClicked after a click", ->
        spy = spyOnEvent(@component.node, 'uiGallerySlideClicked')
        $('.swiper-slide')[2].click()

        expect('uiGallerySlideClicked').toHaveBeenTriggeredOnAndWith(@component.node, { index: 2 })