define(['jquery', 'flight/lib/component', 'swiper'], function($, defineComponent) {
  return defineComponent(function() {
    this.defaultAttrs({
      swiperConfig: {},
      autoInit: true
    });
    this.initSwiper = function() {
      this.attr.swiperConfig.onSlideChangeStart = (function(_this) {
        return function(swiper) {
          var dataPayload;
          dataPayload = {
            activeIndex: swiper.activeIndex,
            previousIndex: _this.normalizePreviousIndex(swiper.previousIndex),
            total: swiper.slides.length
          };
          return _this.trigger('uiSwiperSlideChanged', dataPayload);
        };
      })(this);
      this.attr.swiperConfig.onSlideClick = (function(_this) {
        return function(swiper) {
          return _this.trigger('uiSwiperSlideClicked', {
            index: swiper.clickedSlideIndex
          });
        };
      })(this);
      this.swiper = new Swiper(this.node, this.attr.swiperConfig);
      $(window).on('orientationchange', function() {
        return this.swiper.reInit();
      });
      return this.trigger('uiSwiperInitialized', {
        swiper: this.swiper,
        loop: !!this.attr.swiperConfig.loop
      });
    };
    this.nextItem = function() {
      return this.swiper.swipeNext();
    };
    this.prevItem = function() {
      return this.swiper.swipePrev();
    };
    this.goToIndex = function(event, data) {
      return this.swiper.swipeTo(data.index, data.speed);
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
