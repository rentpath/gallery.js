define(['jquery', 'flight/lib/component', 'swiper'], function($, defineComponent) {
  return defineComponent(function() {
    this.defaultAttrs({
      swiperConfig: {}
    });
    this.initSwiper = function() {
      var key, ref, swiperConfig, value;
      swiperConfig = {};
      ref = this.attr.swiperConfig;
      for (key in ref) {
        value = ref[key];
        swiperConfig[key] = value;
      }
      this.total = this.$node.find('.swiper-slide').length;
      this.$node.find('.swiper-slide').first().addClass('active-slide');
      this.on(document, 'uiGallerySlideClicked', function(event, data) {
        this.activateSlide(data.index);
        return this.transitionGallery(data.slide);
      });
      swiperConfig.onSlideChangeStart = (function(_this) {
        return function() {
          var activeIndex, dataPayload;
          activeIndex = _this.activeIndex();
          dataPayload = {
            activeIndex: activeIndex,
            previousIndex: _this.previousIndex,
            total: _this.total
          };
          _this.trigger('uiGallerySlideChanged', dataPayload);
          return _this.previousIndex = activeIndex;
        };
      })(this);
      swiperConfig.onSlideClick = (function(_this) {
        return function(swiper) {
          return _this.trigger('uiGallerySlideClicked', {
            index: swiper.clickedSlideIndex,
            slide: swiper.clickedSlide
          });
        };
      })(this);
      this.previousIndex = 0;
      this.swiper = new Swiper(this.node, swiperConfig);
      return this.trigger('uiSwiperInitialized', {
        swiper: this.swiper
      });
    };
    this.nextItem = function() {
      return this.swiper.swipeNext();
    };
    this.prevItem = function() {
      return this.swiper.swipePrev();
    };
    this.activeIndex = function() {
      if (this.swiper.params.loop) {
        return this.swiper.activeLoopIndex;
      } else {
        return this.swiper.activeIndex;
      }
    };
    this.goToIndex = function(event, data) {
      if (data.index !== this.activeIndex()) {
        return this.swiper.swipeTo(data.index, data.speed);
      }
    };
    this.slides = function() {
      return this.swiper.slides;
    };
    this.visibleSlides = function() {
      return this.swiper.visibleSlides;
    };
    this.visibleSlideCount = function() {
      return this.visibleSlides().length;
    };
    this.activateSlide = function(index) {
      this.$node.find('.swiper-slide').removeClass('active-slide');
      return this.$node.find('.swiper-slide').eq(index).addClass('active-slide');
    };
    this.slideSelector = function() {
      return '.' + this.swiper.slideClass;
    };
    this.firstVisibleSlide = function() {
      return this.visibleSlides()[0];
    };
    this.lastVisibleSlide = function() {
      var index;
      index = this.visibleSlideCount() - 1;
      return this.visibleSlides()[index];
    };
    this.firstVisibleSlideIndex = function() {
      return this.slides().indexOf(this.firstVisibleSlide());
    };
    this.lastVisibleSlideIndex = function() {
      return this.slides().indexOf(this.lastVisibleSlide());
    };
    this.advanceGallery = function() {
      return this.trigger('uiGalleryWantsToGoToIndex', {
        index: this.lastVisibleSlideIndex(),
        speed: 200
      });
    };
    this.rewindGallery = function() {
      var index;
      if (this.firstVisibleSlideIndex() > this.visibleSlideCount() - 1) {
        index = this.firstVisibleSlideIndex() - this.visibleSlideCount() + 1;
        return this.trigger('uiGalleryWantsToGoToIndex', {
          index: index,
          speed: 200
        });
      } else {
        return this.trigger('uiGalleryWantsToGoToIndex', {
          index: 0,
          speed: 200
        });
      }
    };
    this.transitionGallery = function(slide) {
      if (slide === this.lastVisibleSlide()) {
        return this.advanceGallery();
      } else if (slide === this.firstVisibleSlide()) {
        return this.rewindGallery();
      }
    };
    return this.after('initialize', function() {
      this.on('uiGalleryContentReady', this.initSwiper);
      this.on('uiGalleryWantsNextItem', this.nextItem);
      this.on('uiGalleryWantsPrevItem', this.prevItem);
      this.on('uiGalleryWantsToGoToIndex', this.goToIndex);
      return $(window).on('orientationchange', function() {
        var ref;
        return (ref = this.swiper) != null ? ref.reInit() : void 0;
      });
    });
  });
});
