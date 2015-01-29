define [ 'jquery' ], ($) ->
  describeComponent 'gallery/components/ui/counter', ->
    TIMEOUT = 3000

    beforeEach ->
      @fixture = readFixtures('counter.html')
      @setupComponent(@fixture)
      @node = $('.js-ui-counter')

    describe 'initialize counter', ->
    
      beforeEach ->
        @data = {urls: ['1', '2', '3']}

      it "injects initial count on call to initializeCounter", ->
        @component.initializeCounter(null, @data)
        expect(@node.text()).toBe('1 of 3')

      it "injects initial count after dataGalleryContentAvailable", ->
        @component.$node.trigger('dataGalleryContentAvailable', @data)

        setTimeout =>
          expect(@node.text()).toBe('2 of 3')
        , TIMEOUT

      it "calls initializeCounter after dataGalleryContentAvailable", ->
        spy = spyOn(@component, 'initializeCounter')
        @component.$node.trigger('dataGalleryContentAvailable', @data)
        
        setTimeout =>
          expect(spy).toHaveBeenCalled()
        , TIMEOUT

    describe 'update counter', ->
    
      beforeEach ->
        @data = {activeIndex: 1, total: 3}

      it "injects new count on call to updateCounter", ->
        @component.updateCounter(null, @data)
        expect(@node.text()).toBe('2 of 3')

      it "injects new count after uiSwiperSlideChanged", ->
        @component.$node.trigger('uiSwiperSlideChanged', @data)

        setTimeout =>
          expect(@node.text()).toBe('2 of 3')
        , TIMEOUT

      it "calls updateCounter after uiSwiperSlideChanged", ->
        spy = spyOn(@component, 'updateCounter')
        @component.$node.trigger('uiSwiperSlideChanged', @data)
        
        setTimeout =>
          expect(spy).toHaveBeenCalled()
        , TIMEOUT