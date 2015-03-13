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
            index: swiper.clickedSlideIndex
          });
        };
      })(this);
      swiperConfig.onSlideTouch = (function(_this) {
        return function(swiper) {
          return _this.trigger('uiGallerySlideClicked', {
            index: swiper.clickedSlideIndex
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
