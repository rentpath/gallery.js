define ['jquery'], ($) ->
  describeComponent 'app/coffeescript/components/ui/thumbnails', ->
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

      it "calls swiper.swipeTo() after uiGalleryWantsToGoToIndex", ->
        spy = spyOn(@component.swiper, 'swipeTo')
        @component.$node.trigger('uiGalleryWantsToGoToIndex', { index: 1, speed: 0 })
        expect(spy).toHaveBeenCalledWith(1, 0)

      # it "triggers uiGallerySlideClicked after a click", ->
      #   spy = spyOnEvent(@component.node, 'uiGallerySlideClicked')
      #   $('.swiper-slide')[2].click()

      #   # TODO: Fixme
      #   # expect('uiGallerySlideClicked').toHaveBeenTriggeredOnAndWith(@component.node, { index: 2 })
      #   expect('uiGallerySlideClicked').toHaveBeenTriggeredOn(@component.node)

    describe 'visibleSlideCount()', ->
      it 'returns the number of Swiper slides the user can see', ->
        @setupComponent()
        slides = ['fake html element 1', 'fake html element 2']
        @component.swiper = { visibleSlides: slides }
        expect(@component.visibleSlideCount()).toEqual(2)

    describe 'visibleSlides()', ->
      it 'returns the Swiper slides the user can see', ->
        @setupComponent()
        slides = ['fake html element 1', 'fake html element 2']
        @component.swiper = { visibleSlides: slides }
        expect(@component.visibleSlides()).toEqual(slides)

    describe 'slides()', ->
      it 'returns all Swiper slides', ->
        @setupComponent()
        slides = ['fake html element 1', 'fake html element 2']
        @component.swiper = { slides: slides }
        expect(@component.slides()).toEqual(slides)

    describe 'activateSlide()', ->
      beforeEach ->
        @setupComponent('<div class="swiper-container"><div class="swiper-wrapper"><div class="swiper-slide active-slide"></div><div class="swiper-slide"></div>')
        @component.initSwiper()

      it 'removes the .active-slide class from inactive slides', ->
        @component.activateSlide(1)
        inactiveSlide = $(@component.slides()).first()
        expect(inactiveSlide).not.toHaveClass('active-slide')

      it 'adds the .active-slide slide to the new active slide', ->
        @component.activateSlide(1)
        activeSlide = $(@component.slides()).last()
        expect(activeSlide).toHaveClass('active-slide')

    # describe 'slideSelector()', ->
    #   it 'returns Swiper.slideClass, prefixed with a period', ->
    #     @setupComponent()
    #     @component.swiper = { slideClass: 'test' }
    #     expect(@component.slideSelector()).toEqual('.test')

    describe 'firstVisibleSlide()', ->
      it 'returns the last Swiper slide the user can see', ->
        @setupComponent()
        slides = ['fake html element 1', 'fake html element 2']
        @component.swiper = { visibleSlides: slides }
        expect(@component.firstVisibleSlide()).toEqual('fake html element 1')

    describe 'lastVisibleSlide()', ->
      it 'returns the last Swiper slide the user can see', ->
        @setupComponent()
        slides = ['fake html element 1', 'fake html element 2']
        @component.swiper = { visibleSlides: slides }
        expect(@component.lastVisibleSlide()).toEqual('fake html element 2')

    describe 'lastVisibleSlideIndex()', ->
      it 'returns the Swiper index of the last visible slide', ->
        @setupComponent()
        visibleSlides = ['fake html element 1', 'fake html element 2']
        slides = visibleSlides.concat('fake html element 3')
        @component.swiper = { visibleSlides: visibleSlides, slides: slides }
        expect(@component.lastVisibleSlideIndex()).toEqual(1)

    describe 'firstVisibleSlideIndex()', ->
      it 'returns the Swiper index of the last visible slide', ->
        @setupComponent()
        visibleSlides = ['fake html element 2', 'fake html element 3']
        slides = ['fake html element 1'].concat(visibleSlides)
        @component.swiper = { visibleSlides: visibleSlides, slides: slides }
        expect(@component.firstVisibleSlideIndex()).toEqual(1)

    describe 'advanceGallery()', ->
      it 'advances gallery so last visible slide becomes first visible slide', ->
        @setupComponent()
        spyOn(@component, 'trigger')
        visibleSlides = ['fake html element 1', 'fake html element 2']
        slides = visibleSlides.concat('fake html element 3')
        @component.swiper = { visibleSlides: visibleSlides, slides: slides, params: {}, swipeTo: -> }
        @component.advanceGallery()
        expect(@component.trigger).toHaveBeenCalledWith('uiGalleryWantsToGoToIndex', { index: 1, speed: 200 })

    describe 'rewindGallery()', ->
      describe 'there is not a full set of slides to rewind', ->
        it 'rewinds to the first slide', ->
          @setupComponent()
          spyOn(@component, 'trigger')
          visibleSlides = ['fake html element 2', 'fake html element 3']
          slides = ['fake html element 1'].concat(visibleSlides)
          @component.swiper = { visibleSlides: visibleSlides, slides: slides, params: {}, swipeTo: -> }
          @component.rewindGallery()
          expect(@component.trigger).toHaveBeenCalledWith('uiGalleryWantsToGoToIndex', { index: 0, speed: 200 })

      describe 'there is a full set of slides to rewind', ->
        it 'rewinds a near-full set of visible slides, but keeps one slide from prior set visible ', ->
          @setupComponent()
          spyOn(@component, 'trigger')
          visibleSlides = ['fake html element 3', 'fake html element 4']
          slides = ['fake html element 1', 'fake html element 2'].concat(visibleSlides)
          @component.swiper = { visibleSlides: visibleSlides, slides: slides, params: {}, swipeTo: -> }
          @component.rewindGallery()
          expect(@component.trigger).toHaveBeenCalledWith('uiGalleryWantsToGoToIndex', { index: 1, speed: 200 })

      describe 'transitionGallery', ->
        it 'rewinds the gallery if a given slide is the first visible slide', ->
          @setupComponent()
          spyOn(@component, 'trigger')
          visibleSlides = ['fake html element 2', 'fake html element 3']
          slides = ['fake html element 1'].concat(visibleSlides)
          @component.swiper = { visibleSlides: visibleSlides, slides: slides, params: {}, swipeTo: -> }
          @component.transitionGallery('fake html element 2')
          expect(@component.trigger).toHaveBeenCalledWith('uiGalleryWantsToGoToIndex', { index: 0, speed: 200 })

        it 'advances gallery if a given slide is the last visible slide', ->
          @setupComponent()
          spyOn(@component, 'trigger')
          visibleSlides = ['fake html element 1', 'fake html element 2']
          slides = visibleSlides.concat('fake html element 3')
          @component.swiper = { visibleSlides: visibleSlides, slides: slides, params: {}, swipeTo: -> }
          @component.advanceGallery()
          expect(@component.trigger).toHaveBeenCalledWith('uiGalleryWantsToGoToIndex', { index: 1, speed: 200 })
