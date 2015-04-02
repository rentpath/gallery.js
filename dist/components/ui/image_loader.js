define(['jquery', 'flight/lib/component'], function($, defineComponent) {
  return defineComponent(function() {
    this.defaultAttrs({
      errorUrl: void 0,
      lazyLoadThreshold: void 0
    });
    this.lazyLoad = function(event, data) {
      var number;
      number = (data != null ? data.number : void 0) || this.attr.lazyLoadThreshold;
      return this.loadImages(number);
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
        return function(index, element) {
          var imageElement;
          element = $(element);
          if (element.prop('tagName') === 'IMG') {
            if (_this.attr.errorUrl) {
              element.on('error', function() {
                return element.attr('src', _this.attr.errorUrl);
              });
            }
            element.on('load', function() {
              return _this.triggerImageLoad(element, element[0], index);
            });
            element.attr('src', element.attr('data-src'));
          } else {
            imageElement = new Image;
            $(imageElement).on('load', function() {
              return _this.triggerImageLoad(element, imageElement, index);
            });
            imageElement.src = element.attr('data-src');
            element.css('background-image', "url(" + (element.attr('data-src')) + ")");
          }
          return element.removeAttr('data-src');
        };
      })(this));
    };
    return this.after('initialize', function() {
      this.on('uiGalleryContentReady', this.lazyLoad);
      return this.on('uiGalleryLazyLoadRequested', this.lazyLoad);
    });
  });
});
