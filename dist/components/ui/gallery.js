define(['jquery', 'underscore', 'flight/lib/component', '../mixins/gallery_utils', 'swiper'], function($, _, defineComponent, galleryUtils) {
  var Gallery;
  Gallery = function() {
    this.defaultAttrs({
      swiperConfig: {}
    });
    this.initSwiper = function() {
      var swiperConfig;
      swiperConfig = _.clone(this.attr.swiperConfig);
      swiperConfig.speed = 125;
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
      return this.swiper.slideNext();
    };
    this.prevItem = function() {
      return this.swiper.slidePrev();
    };
    this.reinitSwiper = function() {
      var ref;
      return (ref = this.swiper) != null ? ref.update() : void 0;
    };
    this.after('initialize', function() {
      this.on('uiGalleryContentReady', this.initSwiper);
      this.on('uiGalleryWantsNextItem', this.nextItem);
      this.on('uiGalleryWantsPrevItem', this.prevItem);
      this.on('uiGalleryWantsToGoToIndex', this.goToIndex);
      this.on('uiGalleryDimensionsChange', this.reinitSwiper);
      return this.on(document, 'uiGallerySlideClicked', this.goToIndex);
    });
    return this.before('teardown', function() {
      var ref;
      return (ref = this.swiper) != null ? ref.destroy(true) : void 0;
    });
  };
  return defineComponent(Gallery, galleryUtils);
});
