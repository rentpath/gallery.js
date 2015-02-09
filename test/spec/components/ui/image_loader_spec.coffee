define [ 'jquery' ], ($) ->
  describeComponent 'gallery/components/ui/image_loader', ->
    fixture = '<div><img data-src="foo"><img data-src="bar"><img data-src="barney"><img data-src="baz"></div>'

    describe 'with lazyLoadThreshold', ->
      beforeEach ->
        @setupComponent(fixture, { lazyLoadThreshold: 2 })

      it "initially sets src of first images to data-src", ->
        expected = '<img src="foo"><img src="bar"><img data-src="barney"><img data-src="baz">'
        expect(@component.$node.html()).toEqual(expected)

      it "sets src of remaining images to data-src when uiGalleryLazyLoadRequested", ->
        expected = '<img src="foo"><img src="bar"><img src="barney"><img src="baz">'
        @component.$node.trigger('uiGalleryLazyLoadRequested')
        expect(@component.$node.html()).toEqual(expected)

    describe 'without lazyLoadThreshold', ->
      beforeEach ->
        @setupComponent(fixture)

      it "initially sets src of all images to data-src", ->
        expected = '<img src="foo"><img src="bar"><img src="barney"><img src="baz">'
        expect(@component.$node.html()).toEqual(expected)

    describe 'with errorUrl', ->
      ERROR_URL = '/base/test/spec/fixtures/images/missing.jpg'
      TIMEOUT = 100

      errorFixture = '<div><img data src="/base/test/spec/fixtures/images/1.jpg"><img id="error_img" data-src="intentional404"><img data-src="/base/test/spec/fixtures/images/2.jpg"></div>'

      beforeEach ->
        @setupComponent(errorFixture, { errorUrl: ERROR_URL })

      it "sets src of error images to errorUrl", (done) ->
        setTimeout =>
          expect($('#error_img').attr('src')).toEqual(ERROR_URL)
          done()
        , TIMEOUT