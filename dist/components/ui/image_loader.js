define(['jquery', 'flight/lib/component'], function($, defineComponent) {
  return defineComponent(function() {
    this.defaultAttrs({
      errorUrl: void 0,
      lazyLoadThreshold: void 0
    });
    this.initialLoad = function() {
      return this.loadImages(this.attr.lazyLoadThreshold);
    };
    this.lazyLoad = function() {
      return this.loadImages();
    };
    this.loadImages = function(num) {
      var errorUrl;
      errorUrl = this.attr.errorUrl;
      return this.$node.find("img[data-src]").slice(0, num).each(function() {
        var img;
        img = $(this);
        if (errorUrl) {
          img.on('error', function() {
            return this.src = errorUrl;
          });
        }
        return img.attr('src', img.attr('data-src')).removeAttr('data-src');
      });
    };
    return this.after('initialize', function() {
      this.on('uiGalleryLazyLoadRequested', this.lazyLoad);
      return this.initialLoad();
    });
  });
});
