define(['jquery', 'flight/lib/component', 'components/ui/swiper', 'components/ui/swiper_content', 'components/ui/image_loader'], function($, defineComponent, SwiperUI, SwiperContentUI, ImageLoaderUI) {
  return defineComponent(function() {
    this.defaultAttrs({
      errorUrl: void 0,
      lazyLoadThreshold: void 0
    });
    this.adaptSwiperUiEvents = function() {
      this.on('uiSwiperSlideChanged', (function(_this) {
        return function(ev, data) {
          return _this.trigger('uiGallerySlideChanged', data);
        };
      })(this));
      this.on('uiSwiperSlideClicked', (function(_this) {
        return function(ev, data) {
          return _this.trigger('uiGallerySlideClicked', data);
        };
      })(this));
      this.on('uiSwiperInitialized', (function(_this) {
        return function(ev, data) {
          return _this.trigger('uiGalleryFeaturesDetected', data.swiper.support);
        };
      })(this));
      this.on('uiGalleryWantsNextItem', (function(_this) {
        return function(ev, data) {
          return _this.trigger('uiSwiperWantsNextItem', data);
        };
      })(this));
      this.on('uiGalleryWantsPrevItem', (function(_this) {
        return function(ev, data) {
          return _this.trigger('uiSwiperWantsPrevItem', data);
        };
      })(this));
      return this.on('uiGalleryWantsToGoToIndex', (function(_this) {
        return function(ev, data) {
          return _this.trigger('uiSwiperWantsToGoToIndex', data);
        };
      })(this));
    };
    return this.after('initialize', function() {
      this.adaptSwiperUiEvents();
      this.on('uiGalleryContentReady', (function(_this) {
        return function() {
          ImageLoaderUI.attachTo(_this.$node, {
            lazyLoadThreshold: _this.attr.lazyLoadThreshold,
            errorUrl: _this.attr.errorUrl
          });
          return SwiperUI.attachTo(_this.$node);
        };
      })(this));
      SwiperContentUI.attachTo(this.$node);
      return this.$node.one('uiSwiperSlideChanged', (function(_this) {
        return function() {
          return _this.trigger('uiLazyLoadRequest');
        };
      })(this));
    });
  });
});
