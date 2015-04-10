define(['jquery', 'flight/lib/component'], function($, defineComponent) {
  return defineComponent(function() {
    this.defaultAttrs({
      errorUrl: void 0,
      lazyLoadThreshold: void 0
    });
    this.lazyLoad = function(event, data) {
      var begin, direction, end, number;
      number = (data != null ? data.number : void 0) || this.attr.lazyLoadThreshold;
      direction = (data != null ? data.direction : void 0) || 'forward';
      if (direction === 'forward') {
        begin = 0;
        end = number;
      } else {
        begin = -number;
        end = void 0;
      }
      return this.loadImages(begin, end);
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
    this.loadImages = function(begin, end) {
      return this.$node.find("[data-src]").slice(begin, end).each((function(_this) {
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
