define(['jquery', 'flight/lib/component'], function($, defineComponent) {
  return defineComponent(function() {
    this.defaultAttrs({
      errorUrl: void 0,
      lazyLoadThreshold: void 0
    });
    this.assignIndex = function() {
      return this.$node.find("[data-src]").each(function(index) {
        var ele;
        ele = $(this);
        if (!ele.attr('data-index')) {
          return ele.attr('data-index', index);
        }
      });
    };
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
      var elements;
      if (end) {
        elements = this.$node.find("[data-src]").slice(begin, end);
      } else {
        elements = this.$node.find("[data-src]").slice(begin);
      }
      return elements.each((function(_this) {
        return function(_index, element) {
          var imageElement, index;
          element = $(element);
          index = parseInt(element.attr('data-index'), 10);
          imageElement = new Image;
          $(imageElement).on('load', function() {
            return _this.triggerImageLoad(element, imageElement, index);
          });
          imageElement.src = element.attr('data-src');
          if (element.prop('tagName') === 'IMG') {
            return _this.setImageSrc(element);
          } else {
            return _this.setBackgroundImageSrc(element);
          }
        };
      })(this));
    };
    this.setImageSrc = function(element) {
      if (this.attr.errorUrl) {
        element.on('error', (function(_this) {
          return function() {
            return element.attr('src', _this.attr.errorUrl);
          };
        })(this));
      }
      return element.attr('src', element.attr('data-src')).removeAttr('data-src');
    };
    this.setBackgroundImageSrc = function(element) {
      return element.css('background-image', "url(" + (element.attr('data-src')) + ")").removeAttr('data-src');
    };
    return this.after('initialize', function() {
      this.on('uiGalleryContentReady', this.assignIndex);
      this.on('uiGalleryContentReady', this.lazyLoad);
      return this.on('uiGalleryLazyLoadRequested', this.lazyLoad);
    });
  });
});
