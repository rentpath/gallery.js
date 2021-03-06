define ['jquery'], ($) ->
  describeComponent 'app/coffeescript/components/ui/gallery', ->
    TIMEOUT = 500

    beforeEach ->
      @fixture = readFixtures('gallery.html')

    describe "after uiGalleryContentReady event", ->
      beforeEach ->
        @setupComponent(@fixture)

      it 'configures the Swiper', ->
        @component.$node.trigger('uiGalleryContentReady')
        expect(@component.swiper).toBeDefined()

      it 'triggers uiSwiperInitialized', ->
        spy = spyOnEvent(@component.node, 'uiSwiperInitialized')
        @component.$node.trigger('uiGalleryContentReady')
        expect('uiSwiperInitialized').toHaveBeenTriggeredOnAndWith(@component.node, { swiper: @component.swiper })

    describe "other events", ->
      beforeEach ->
        @setupComponent(@fixture)
        @component.$node.trigger('uiGalleryContentReady')

      it "calls swiper.swipeNext() after uiGalleryWantsNextItem", ->
        spy = spyOn(@component.swiper, 'swipeNext')
        @component.$node.trigger('uiGalleryWantsNextItem')
        expect(spy).toHaveBeenCalled()

      it "calls swiper.swipePrev() after uiGalleryWantsPrevItem", ->
        spy = spyOn(@component.swiper, 'swipePrev')
        @component.$node.trigger('uiGalleryWantsPrevItem')
        expect(spy).toHaveBeenCalled()

      it "triggers uiGallerySlideChanged after swipeNext()", (done) ->
        spy = spyOnEvent(@component.node, 'uiGallerySlideChanged')
        @component.swiper.swipeNext()

        # wait for async event from swiper
        setTimeout =>
          data = { activeIndex: 1, previousIndex: 0, total: 4 }
          expect('uiGallerySlideChanged').toHaveBeenTriggeredOnAndWith(@component.node, data)
          done()
        , TIMEOUT

      it "triggers uiGallerySlideChanged after swipePrev()", (done) ->
        @component.swiper.swipeTo(1, 0)
        spy = spyOnEvent(@component.node, 'uiGallerySlideChanged')
        @component.swiper.swipePrev()

        # wait for async event from swiper
        setTimeout =>
          data = { activeIndex: 0, previousIndex: 1, total: 4 }
          expect('uiGallerySlideChanged').toHaveBeenTriggeredOnAndWith(@component.node, data)
          done()
        , TIMEOUT

      it "triggers uiGallerySlideChanged after swipeTo()", (done) ->
        spy = spyOnEvent(@component.node, 'uiGallerySlideChanged')
        @component.swiper.swipeTo(3)

        # wait for async event from swiper
        setTimeout =>
          data = { activeIndex: 3, previousIndex: 0, total: 4 }
          expect('uiGallerySlideChanged').toHaveBeenTriggeredOnAndWith(@component.node, data)
          done()
        , TIMEOUT

    describe "with loop enabled", ->
      beforeEach ->
        @setupComponent(@fixture, { swiperConfig: { loop: true } })
        @component.$node.trigger('uiGalleryContentReady')

      it "triggers uiGallerySlideChanged after swipeNext()", (done) ->
        spy = spyOnEvent(@component.node, 'uiGallerySlideChanged')
        @component.swiper.swipeNext()

        # wait for async event from swiper
        setTimeout =>
          data = { activeIndex: 1, previousIndex: 0, total: 4 }
          expect('uiGallerySlideChanged').toHaveBeenTriggeredOnAndWith(@component.node, data)
          done()
        , TIMEOUT

      it "triggers uiGallerySlideChanged after swipePrev()", (done) ->
        @component.swiper.swipeTo(1, 0)
        spy = spyOnEvent(@component.node, 'uiGallerySlideChanged')
        @component.swiper.swipePrev()

        # wait for async event from swiper
        setTimeout =>
          data = { activeIndex: 0, previousIndex: 1, total: 4 }
          expect('uiGallerySlideChanged').toHaveBeenTriggeredOnAndWith(@component.node, data)
          done()
        , TIMEOUT

       it "triggers uiGallerySlideChanged after swipeTo()", (done) ->
         spy = spyOnEvent(@component.node, 'uiGallerySlideChanged')
         @component.swiper.swipeTo(3)

         # wait for async event from swiper
         setTimeout =>
           data = { activeIndex: 3, previousIndex: 0, total: 4 }
           expect('uiGallerySlideChanged').toHaveBeenTriggeredOnAndWith(@component.node, data)
           done()
         , TIMEOUT
