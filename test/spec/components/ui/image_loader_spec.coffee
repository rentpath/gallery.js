define [ 'jquery' ], ($) ->
  describeComponent 'app/coffeescript/components/ui/image_loader', ->
    fixture = '<div><img data-src="foo"><img data-src="bar"><img data-src="barney"><img data-src="baz"></div>'

    describe 'with lazyLoadThreshold', ->
      beforeEach ->
        @setupComponent(fixture, { lazyLoadThreshold: 2 })
        @component.$node.trigger('uiGalleryContentReady')

      it "initially sets src of first images to data-src", ->
        expected = '<img data-index="0" src="foo"><img data-index="1" src="bar"><img data-src="barney" data-index="2"><img data-src="baz" data-index="3">'
        expect(@component.$node.html()).toEqual(expected)

      it "sets src of remaining images to data-src when uiGalleryLazyLoadRequested", ->
        expected = '<img data-index="0" src="foo"><img data-index="1" src="bar"><img data-index="2" src="barney"><img data-index="3" src="baz">'
        @component.$node.trigger('uiGalleryLazyLoadRequested')
        expect(@component.$node.html()).toEqual(expected)

    describe 'without lazyLoadThreshold', ->
      it "initially sets src of all images to data-src", ->
        @setupComponent(fixture)
        @component.$node.trigger('uiGalleryContentReady')
        expected = '<img data-index="0" src="foo"><img data-index="1" src="bar"><img data-index="2" src="barney"><img data-index="3" src="baz">'
        expect(@component.$node.html()).toEqual(expected)

    describe 'triggering load events', ->
      it "triggers when given an <img> with data-src", (done) ->
        @setupComponent '<div><img data-src="/base/test/spec/fixtures/images/3.jpg"></div>'
        eventSpy = spyOnEvent @component.$node, 'uiGalleryImageLoad'
        @component.$node.trigger('uiGalleryContentReady')

        # Allow events to propagate
        setTimeout =>
          expect(eventSpy).toHaveBeenTriggered
          expect(eventSpy.mostRecentCall.args[1].src).toMatch '/base/test/spec/fixtures/images/3.jpg'
          done()
        , 100

      it "triggers when given a <div> with data-src", (done) ->
        @setupComponent '<div><div data-src="/base/test/spec/fixtures/images/3.jpg"></div></div>'
        eventSpy = spyOnEvent @component.$node, 'uiGalleryImageLoad'
        @component.$node.trigger('uiGalleryContentReady')

        # Allow events to propagate
        setTimeout =>
          expect(eventSpy).toHaveBeenTriggered
          expect(eventSpy.mostRecentCall.args[1].src).toMatch '/base/test/spec/fixtures/images/3.jpg'
          done()
        , 100

    describe 'with errorUrl', ->
      it "sets src of error images to errorUrl", (done) ->
        ERROR_URL = '/base/test/spec/fixtures/images/missing.jpg'
        TIMEOUT = 100

        errorFixture = '<div><img data-src="/base/test/spec/fixtures/images/1.jpg"><img id="error_img" data-src="intentional404"><img data-src="/base/test/spec/fixtures/images/2.jpg"></div>'

        @setupComponent(errorFixture, { errorUrl: ERROR_URL })
        @component.$node.trigger('uiGalleryContentReady')

        setTimeout =>
          expect($('#error_img').attr('src')).toEqual(ERROR_URL)
          done()
        , TIMEOUT

     describe '#lazyLoad', ->
        beforeEach ->
          @setupComponent fixture

        describe 'when a direction is not specified', ->
          it "assigns src to the first", ->
            expected = '<img src="foo"><img data-src="bar"><img data-src="barney"><img data-src="baz">'
            @component.lazyLoad null, { number: 1 }
            expect(@component.$node.html()).toEqual(expected)

        describe 'when the direction is forward', ->
          it "assigns src to the first", ->
            expected = '<img src="foo"><img data-src="bar"><img data-src="barney"><img data-src="baz">'
            @component.lazyLoad null, { number: 1, direction: 'forward' }
            expect(@component.$node.html()).toEqual(expected)

        describe 'when the direction is backward', ->
          it "assigns src to the last", ->
            expected = '<img data-src="foo"><img data-src="bar"><img data-src="barney"><img src="baz">'
            @component.lazyLoad null, { number: 1, direction: 'backward' }
            expect(@component.$node.html()).toEqual(expected)

          it "assigns src several of the last", ->
            expected = '<img data-src="foo"><img src="bar"><img src="barney"><img src="baz">'
            @component.lazyLoad null, { number: 3, direction: 'backward' }
            expect(@component.$node.html()).toEqual(expected)

    describe '#assignIndex', ->
        beforeEach ->
          @setupComponent fixture

        it "assigns data-index", ->
          expected = '<img data-src="foo" data-index="0"><img data-src="bar" data-index="1"><img data-src="barney" data-index="2"><img data-src="baz" data-index="3">'
          @component.assignIndex()
          expect(@component.$node.html()).toEqual(expected)
