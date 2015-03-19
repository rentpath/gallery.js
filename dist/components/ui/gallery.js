define(['jquery', 'flight/lib/component', '../mixins/gallery_utils', 'swiper'], function($, defineComponent, galleryUtils) {
  var Gallery;
  Gallery = function() {
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
          _this.trigger('uiGallerySlideChanged', {
            activeIndex: _this.activeIndex(),
            previousIndex: _this.previousIndex,
            total: _this.total
          });
          return _this.previousIndex = _this.activeIndex();
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
  };
  return defineComponent(Gallery, galleryUtils);
});
