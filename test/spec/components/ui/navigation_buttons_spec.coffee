define [ 'jquery' ], ($) ->
  describeComponent 'gallery/components/ui/navigation_buttons', ->

    beforeEach ->
      @fixture = readFixtures('navigation_buttons.html')

    describe 'initialize buttons', ->

      describe 'with loop on', ->
        beforeEach ->
          @setupComponent(@fixture, {loop: true})

        it "shows both buttons with multiple images", ->
          @component.$node.trigger('dataGalleryContentAvailable', {urls: ['1', '2', '3']})

          expect($('.js-ui-navigation-previous').css('display')).not.toBe('none')
          expect($('.js-ui-navigation-next').css('display')).not.toBe('none')

        it "shows neither button with one image", ->
          @component.$node.trigger('dataGalleryContentAvailable', {urls: ['1']})

          expect($('.js-ui-navigation-previous').css('display')).toBe('none')
          expect($('.js-ui-navigation-next').css('display')).toBe('none')

      describe 'with loop off', ->
        beforeEach ->
          @setupComponent(@fixture)

        it "shows neither button with one image", ->
          @component.$node.trigger('dataGalleryContentAvailable', {urls: ['1']})

          expect($('.js-ui-navigation-previous').css('display')).toBe('none')
          expect($('.js-ui-navigation-next').css('display')).toBe('none')

        it "shows the next button with multiple images", ->
          @component.$node.trigger('dataGalleryContentAvailable', {urls: ['1', '2', '3']})

          expect($('.js-ui-navigation-previous').css('display')).toBe('none')
          expect($('.js-ui-navigation-next').css('display')).not.toBe('none')

    describe 'handle buttons', ->

      describe 'with loop on', ->
        beforeEach ->
          @setupComponent(@fixture, {loop: true})

        it "shows both buttons on first image", ->
          @component.$node.trigger('uiSwiperSlideChanged', {activeIndex: 0, total: 3})

          expect($('.js-ui-navigation-previous').css('display')).not.toBe('none')
          expect($('.js-ui-navigation-next').css('display')).not.toBe('none')

        it "shows both buttons on inner image", ->
          @component.$node.trigger('uiSwiperSlideChanged', {activeIndex: 1, total: 3})

          expect($('.js-ui-navigation-previous').css('display')).not.toBe('none')
          expect($('.js-ui-navigation-next').css('display')).not.toBe('none')

        it "shows both buttons on last image", ->
          @component.$node.trigger('uiSwiperSlideChanged', {activeIndex: 2, total: 3})

          expect($('.js-ui-navigation-previous').css('display')).not.toBe('none')
          expect($('.js-ui-navigation-next').css('display')).not.toBe('none')

      describe 'with loop off', ->
        beforeEach ->
          @setupComponent(@fixture)

        it "shows only next button on first image", ->
          @component.$node.trigger('uiSwiperSlideChanged', {activeIndex: 0, total: 3})

          expect($('.js-ui-navigation-previous').css('display')).toBe('none')
          expect($('.js-ui-navigation-next').css('display')).not.toBe('none')

        it "shows both buttons on inner image", ->
          @component.$node.trigger('uiSwiperSlideChanged', {activeIndex: 1, total: 3})

          expect($('.js-ui-navigation-previous').css('display')).not.toBe('none')
          expect($('.js-ui-navigation-next').css('display')).not.toBe('none')

        it "shows only previous button on last image", ->
          @component.$node.trigger('uiSwiperSlideChanged', {activeIndex: 2, total: 3})

          expect($('.js-ui-navigation-previous').css('display')).not.toBe('none')
          expect($('.js-ui-navigation-next').css('display')).toBe('none')

    describe 'match loop value with swiper', ->

      it "sets loop to true when swiper is true", ->
        @setupComponent(@fixture)
        swiper = {slides: ['1', '2', '3']}
        @component.$node.trigger('uiSwiperInitialized', {swiper: swiper, loop: true})

        expect(@component.attr.loop).toBe(true)

      it "sets loop to false when swiper is false", ->
        @setupComponent(@fixture, {loop: true})
        swiper = {slides: ['1', '2', '3']}
        @component.$node.trigger('uiSwiperInitialized', {swiper: swiper, loop: false})

        expect(@component.attr.loop).toBe(false)

    describe 'buttons', ->
      beforeEach ->
        @setupComponent(@fixture)
        @component.$node.trigger('dataGalleryContentAvailable', {urls: ['1', '2', '3']})

      it "triggers uiSwiperWantsNextItem when next is clicked", ->
        spy = jasmine.createSpy 'uiSwiperWantsNextItem'
        @component.$node.on 'uiSwiperWantsNextItem', spy

        $('.js-ui-navigation-next').trigger('click')
        expect(spy).toHaveBeenCalled()

      it "triggers uiSwiperWantsPrevItem when next is clicked", ->
        spy = jasmine.createSpy 'uiSwiperWantsPrevItem'
        @component.$node.on 'uiSwiperWantsPrevItem', spy

        $('.js-ui-navigation-previous').trigger('click')
        expect(spy).toHaveBeenCalled()