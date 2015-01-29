define(['jquery', 'flight/lib/component'], function($, defineComponent) {
  return defineComponent(function() {
    this.defaultAttrs({
      errorUrl: void 0,
      lazyLoadThreshold: void 0
    });
    this.loadImages = function(num) {
      return this.$node.find("img[data-src]").slice(0, num).each(function() {
        var img;
        img = $(this);
        return img.attr('src', img.attr('data-src')).removeAttr('data-src');
      });
    };
    this.initialLoad = function() {
      return this.loadImages(this.attr.lazyLoadThreshold);
    };
    this.lazyLoad = function() {
      return this.loadImages();
    };
    this.setupImageErrorHandler = function() {
      var errorUrl;
      if (this.attr.errorUrl == null) {
        return;
      }
      errorUrl = this.attr.errorUrl;
      return this.$node.find('img').on('error', function() {
        return this.src = errorUrl;
      });
    };
    return this.after('initialize', function() {
      this.setupImageErrorHandler();
      this.on('uiLazyLoadRequest', this.lazyLoad);
      return this.initialLoad();
    });
  });
});
