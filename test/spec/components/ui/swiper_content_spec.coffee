define [ 'jquery' ], ($) ->
  describeComponent 'gallery/components/ui/swiper_content', ->
    fixture = "<div></div>"

    describe 'events', ->
      beforeEach ->
        @setupComponent(fixture)

      it 'populates swiper content on dataGalleryContentAvailable event', ->
        expected = '<div class="swiper-wrapper"><div class="swiper-slide"><img src="foo"></div><div class="swiper-slide"><img src="bar"></div></div>'
        @component.$node.trigger('dataGalleryContentAvailable', { urls: ['foo', 'bar'] })
        expect(@component.$node.html()).toEqual(expected)

      it 'triggers uiGalleryContentReady after populating swiper content', ->
        spy = spyOnEvent(@component.node, 'uiGalleryContentReady')
        @component.$node.trigger('dataGalleryContentAvailable', { urls: ['foo', 'bar'] })
        expect(spy).toHaveBeenTriggeredOn(@component.node)

    describe 'lazy loading', ->
      beforeEach ->
        @setupComponent(fixture, { lazyLoadThreshold: 2 })

      it 'sets data-src instead of src for images after lazyLoadThreshold', ->
        expected = '<div class="swiper-wrapper"><div class="swiper-slide"><img src="foo"></div><div class="swiper-slide"><img src="bar"></div><div class="swiper-slide"><img data-src="barney"></div><div class="swiper-slide"><img data-src="baz"></div></div>'
        @component.$node.trigger('dataGalleryContentAvailable', { urls: ['foo', 'bar', 'barney', 'baz',] })
        expect(@component.$node.html()).toEqual(expected)
