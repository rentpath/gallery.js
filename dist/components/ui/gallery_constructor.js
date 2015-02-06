define(['jquery', 'flight/lib/component', 'components/ui/gallery', 'components/ui/content', 'components/ui/image_loader'], function($, defineComponent, GalleryUI, ContentUI, ImageLoaderUI) {
  return defineComponent(function() {
    this.defaultAttrs({
      errorUrl: void 0,
      lazyLoadThreshold: void 0,
      swiperConfig: {}
    });
    return this.after('initialize', function() {
      this.on('uiGalleryContentReady', (function(_this) {
        return function() {
          ImageLoaderUI.attachTo(_this.$node, {
            lazyLoadThreshold: _this.attr.lazyLoadThreshold,
            errorUrl: _this.attr.errorUrl
          });
          return GalleryUI.attachTo(_this.$node, {
            swiperConfig: _this.attr.swiperConfig
          });
        };
      })(this));
      ContentUI.attachTo(this.$node);
      return this.$node.one('uiGallerySlideChanged', (function(_this) {
        return function() {
          return _this.trigger('uiGalleryLazyLoadRequested');
        };
      })(this));
    });
  });
});
