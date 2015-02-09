define(['jquery', 'flight/lib/component', 'swiper'], function($, defineComponent) {
  return defineComponent(function() {
    this.defaultAttrs({
      swiperConfig: {},
      autoInit: true
    });
    this.initSwiper = function() {
      var key, swiperConfig, value, _ref;
      swiperConfig = {};
      _ref = this.attr.swiperConfig;
      for (key in _ref) {
        value = _ref[key];
        swiperConfig[key] = value;
      }
      swiperConfig.onSlideChangeStart = (function(_this) {
        return function(swiper) {
          var dataPayload;
          dataPayload = {
            activeIndex: swiper.params.loop ? swiper.activeLoopIndex : swiper.activeIndex,
            previousIndex: _this.normalizePreviousIndex(swiper.previousIndex),
            total: _this.$node.find('.swiper-slide').length
          };
          return _this.trigger('uiGallerySlideChanged', dataPayload);
        };
      })(this);
      swiperConfig.onSlideClick = (function(_this) {
        return function(swiper) {
          return _this.trigger('uiGallerySlideClicked', {
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
      this.on('uiGalleryWantsNextItem', this.nextItem);
      this.on('uiGalleryWantsPrevItem', this.prevItem);
      this.on('uiGalleryWantsToGoToIndex', this.goToIndex);
      if (this.attr.autoInit) {
        return this.initSwiper();
      }
    });
  });
});
