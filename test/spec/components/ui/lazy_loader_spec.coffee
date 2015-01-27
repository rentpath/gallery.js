define [ 'jquery' ], ($) ->
  describeComponent 'gallery/components/ui/lazy_loader', ->

    beforeEach ->
      @fixture = '<div><img src="foo"><img data-src="bar"><img data-src="baz"></div>'
      @setupComponent(@fixture)

    it "sets src of images to data-src", ->
      expected = '<img src="foo"><img src="bar"><img src="baz">'
      @component.$node.trigger('uiLazyLoadRequest')
      expect(@component.$node.html()).toEqual(expected)
