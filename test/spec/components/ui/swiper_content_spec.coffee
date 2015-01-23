define [ 'jquery' ], ($) ->
  describeComponent 'gallery/components/ui/swiper_content', ->
    beforeEach ->
      fixture = "<div></div>"
      @setupComponent(fixture)

    it 'populates swiper content on dataGalleryContentAvailable event', ->
      expected = '<div class="swiper-wrapper"><div class="swiper-slide"><img src="foo"></div><div class="swiper-slide"><img src="bar"></div></div>'
      @component.$node.trigger('dataGalleryContentAvailable', { urls: ['foo', 'bar'] })
      expect(@component.$node.html()).toEqual(expected)

    it 'triggers uiGalleryContentReady after populating swiper content', ->
      spy = spyOnEvent(@component.node, 'uiGalleryContentReady')
      @component.$node.trigger('dataGalleryContentAvailable', { urls: ['foo', 'bar'] })
      expect(spy).toHaveBeenTriggeredOn(@component.node)
