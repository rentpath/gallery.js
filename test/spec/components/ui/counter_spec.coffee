define [ 'jquery' ], ($) ->
  describeComponent 'gallery/components/ui/counter', ->

    beforeEach ->
      @fixture = readFixtures('counter.html')
      @setupComponent(@fixture)

    describe 'initialize counter', ->

      it "injects total after dataGalleryContentAvailable", ->
        @component.$node.trigger('dataGalleryContentAvailable', {urls: ['1', '2', '3']})
        expect($('.js-ui-counter-total').text()).toBe('3')

    describe 'update counter', ->

      it "injects active number after uiGallerySlideChanged", ->
        @component.$node.trigger('uiGallerySlideChanged', {activeIndex: 1, total: 3})
        expect($('.js-ui-counter-active').text()).toBe('2')
