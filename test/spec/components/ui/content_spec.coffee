define [ 'jquery' ], ($) ->
  describeComponent 'gallery/components/ui/content', ->
    fixture = "<div></div>"

    beforeEach ->
      @setupComponent(fixture)

    it 'populates gallery content on dataGalleryContentAvailable event', ->
      expected = '<div class="swiper-wrapper"><div class="swiper-slide"><img data-src="foo"></div><div class="swiper-slide"><img data-src="bar"></div></div>'
      @component.$node.trigger('dataGalleryContentAvailable', { urls: ['foo', 'bar'] })
      expect(@component.$node.html()).toEqual(expected)

    it 'triggers uiGalleryContentReady after populating gallery content', ->
      spy = spyOnEvent(@component.node, 'uiGalleryContentReady')
      @component.$node.trigger('dataGalleryContentAvailable', { urls: ['foo', 'bar'] })
      expect(spy).toHaveBeenTriggeredOn(@component.node)
