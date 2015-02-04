define(['jquery', 'flight/lib/component', 'swiper'], function($, defineComponent) {
  return defineComponent(function() {
    this.defaultAttrs({
      swiperConfig: void 0,
      autoInit: true,
      swiper: void 0
    });
    this.initSwiper = function() {
      var swiperConfig;
      swiperConfig = this.attr.swiperConfig || {};
      swiperConfig.onSlideChangeStart = (function(_this) {
        return function(swiper) {
          var dataPayload, totalSlides;
          if (swiper.params.loop) {
            totalSlides = $.grep(swiper.slides, function(slide) {
              return !$(slide).hasClass('swiper-slide-duplicate');
            });
            dataPayload = {
              activeIndex: swiper.activeLoopIndex,
              previousIndex: _this.normalizePreviousIndex(swiper.previousIndex),
              total: totalSlides.length
            };
          } else {
            dataPayload = {
              activeIndex: swiper.activeIndex,
              previousIndex: _this.normalizePreviousIndex(swiper.previousIndex),
              total: swiper.slides.length
            };
          }
          return _this.trigger('uiSwiperSlideChanged', dataPayload);
        };
      })(this);
      swiperConfig.onSlideClick = (function(_this) {
        return function(swiper) {
          return _this.trigger('uiSwiperSlideClicked', {
            index: swiper.clickedSlideIndex
          });
        };
      })(this);
      this.swiper = new Swiper(this.node, swiperConfig);
      $(window).on('orientationchange', function() {
        return this.swiper.reInit();
      });
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
    this.goToIndex = function(event, data) {
      if (data.index !== this.swiper.activeIndex) {
        return this.swiper.swipeTo(data.index, data.speed);
      }
    };
    this.normalizePreviousIndex = function(value) {
      return value || 0;
    };
    return this.after('initialize', function() {
      this.on('uiSwiperWantsNextItem', this.nextItem);
      this.on('uiSwiperWantsPrevItem', this.prevItem);
      this.on('uiSwiperWantsToGoToIndex', this.goToIndex);
      if (this.attr.autoInit) {
        return this.initSwiper();
      }
    });
  });
});
