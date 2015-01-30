define [ 'jquery' ], ($) ->
  describeComponent 'gallery/components/ui/counter', ->
    TIMEOUT = 3000

    beforeEach ->
      @fixture = readFixtures('counter.html')
      @setupComponent(@fixture)
      @node = $('.counter')

    describe 'initialize counter', ->
    
      it "injects initial count after dataGalleryContentAvailable", ->
        @component.$node.trigger('dataGalleryContentAvailable', {urls: ['1', '2', '3']})

        setTimeout =>
          expect(@node.text()).toBe('2 of 3')
        , TIMEOUT

    describe 'update counter', ->
    
      it "injects new count after uiSwiperSlideChanged", ->
        @component.$node.trigger('uiSwiperSlideChanged', {activeIndex: 1, total: 3})

        setTimeout =>
          expect(@node.text()).toBe('2 of 3')
        , TIMEOUT