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
    this.triggerImageLoad = function(slide, imageElement, index) {
      return this.trigger('uiGalleryImageLoad', {
        index: index,
        slideElement: slide,
        src: imageElement.src,
        width: imageElement.width,
        height: imageElement.height
      });
    };
    this.loadImages = function(num) {
      return this.$node.find("[data-src]").slice(0, num).each((function(_this) {
        return function(index, img) {
          var errorUrl, imageElement;
          img = $(img);
          if (img.prop('tagName') === 'IMG') {
            if (errorUrl = _this.attr.errorUrl) {
              img.on('error', function() {
                return this.src = errorUrl;
              });
            }
            img.on('load', function() {
              return _this.triggerImageLoad(img, img[0], index);
            });
            img.attr('src', img.attr('data-src'));
          } else {
            imageElement = new Image;
            $(imageElement).on('load', function() {
              return _this.triggerImageLoad(img, imageElement, index);
            });
            imageElement.src = img.attr('data-src');
            img.css('background-image', "url(" + (img.attr('data-src')) + ")");
          }
          return img.removeAttr('data-src');
        };
      })(this));
    };
    return this.after('initialize', function() {
      this.on('uiGalleryContentReady', this.initialLoad);
      return this.on('uiGalleryLazyLoadRequested', this.lazyLoad);
    });
  });
});
