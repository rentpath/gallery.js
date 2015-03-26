define [ 'jquery' ], ($) ->
  describeComponent 'app/coffeescript/components/ui/navigation_buttons', ->

    beforeEach ->
      @fixture = readFixtures('navigation_buttons.html')

    describe 'initialize buttons', ->

      describe 'with loop on', ->
        beforeEach ->
          @setupComponent(@fixture, {loop: true})

        it "shows both buttons with multiple images", ->
          @component.$node.trigger('dataGalleryContentAvailable', {urls: ['1', '2', '3']})

          expect($('.js-ui-navigation-previous').hasClass('disabled')).toBeFalsy()
          expect($('.js-ui-navigation-next').hasClass('disabled')).toBeFalsy()

        it "shows neither button with one image", ->
          @component.$node.trigger('dataGalleryContentAvailable', {urls: ['1']})

          expect($('.js-ui-navigation-previous').hasClass('disabled')).toBeTruthy()
          expect($('.js-ui-navigation-next').hasClass('disabled')).toBeTruthy()

      describe 'with loop off', ->
        beforeEach ->
          @setupComponent(@fixture)

        it "shows neither button with one image", ->
          @component.$node.trigger('dataGalleryContentAvailable', {urls: ['1']})

          expect($('.js-ui-navigation-previous').hasClass('disabled')).toBeTruthy()
          expect($('.js-ui-navigation-next').hasClass('disabled')).toBeTruthy()

        it "shows the next button with multiple images", ->
          @component.$node.trigger('dataGalleryContentAvailable', {urls: ['1', '2', '3']})

          expect($('.js-ui-navigation-previous').hasClass('disabled')).toBeTruthy()
          expect($('.js-ui-navigation-next').hasClass('disabled')).toBeFalsy()

    describe 'display buttons', ->

      describe 'with loop on', ->
        beforeEach ->
          @setupComponent(@fixture, {loop: true})

        it "shows both buttons on first image", ->
          @component.$node.trigger('uiGallerySlideChanged', {activeIndex: 0, total: 3})

          expect($('.js-ui-navigation-previous').hasClass('disabled')).toBeFalsy()
          expect($('.js-ui-navigation-next').hasClass('disabled')).toBeFalsy()

        it "shows both buttons on inner image", ->
          @component.$node.trigger('uiGallerySlideChanged', {activeIndex: 1, total: 3})

          expect($('.js-ui-navigation-previous').hasClass('disabled')).toBeFalsy()
          expect($('.js-ui-navigation-next').hasClass('disabled')).toBeFalsy()

        it "shows both buttons on last image", ->
          @component.$node.trigger('uiGallerySlideChanged', {activeIndex: 2, total: 3})

          expect($('.js-ui-navigation-previous').hasClass('disabled')).toBeFalsy()
          expect($('.js-ui-navigation-next').hasClass('disabled')).toBeFalsy()

      describe 'with loop off', ->
        beforeEach ->
          @setupComponent(@fixture)

        it "shows only next button on first image", ->
          @component.$node.trigger('uiGallerySlideChanged', {activeIndex: 0, total: 3})

          expect($('.js-ui-navigation-previous').hasClass('disabled')).toBeTruthy()
          expect($('.js-ui-navigation-next').hasClass('disabled')).toBeFalsy()

        it "shows both buttons on inner image", ->
          @component.$node.trigger('uiGallerySlideChanged', {activeIndex: 1, total: 3})

          expect($('.js-ui-navigation-previous').hasClass('disabled')).toBeFalsy()
          expect($('.js-ui-navigation-next').hasClass('disabled')).toBeFalsy()

        it "shows only previous button on last image", ->
          @component.$node.trigger('uiGallerySlideChanged', {activeIndex: 2, total: 3})

          expect($('.js-ui-navigation-previous').hasClass('disabled')).toBeFalsy()
          expect($('.js-ui-navigation-next').hasClass('disabled')).toBeTruthy()

    describe 'match loop value with swiper', ->

      it "sets loop to true when swiper is true", ->
        @setupComponent(@fixture)
        swiper = {slides: ['1', '2', '3'], params: { loop: true }}
        @component.$node.trigger('uiSwiperInitialized', {swiper: swiper})

        expect(@component.attr.loop).toBe(true)

      it "sets loop to false when swiper is false", ->
        @setupComponent(@fixture, {loop: true})
        swiper = {slides: ['1', '2', '3'], params: { loop: false }}
        @component.$node.trigger('uiSwiperInitialized', {swiper: swiper})

        expect(@component.attr.loop).toBe(false)

    describe 'buttons', ->
      beforeEach ->
        @setupComponent(@fixture)
        @component.$node.trigger('dataGalleryContentAvailable', {urls: ['1', '2', '3']})

      it "triggers uiGalleryWantsNextItem when next is clicked", ->
        spy = jasmine.createSpy 'uiGalleryWantsNextItem'
        @component.$node.on 'uiGalleryWantsNextItem', spy

        $('.js-ui-navigation-next').trigger('click')
        expect(spy).toHaveBeenCalled()

      it "triggers uiGalleryWantsPrevItem when next is clicked", ->
        spy = jasmine.createSpy 'uiGalleryWantsPrevItem'
        @component.$node.on 'uiGalleryWantsPrevItem', spy

        $('.js-ui-navigation-previous').trigger('click')
        expect(spy).toHaveBeenCalled()
