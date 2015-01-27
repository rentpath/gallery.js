define(['jquery', 'flight/lib/component'], function($, defineComponent) {
  return defineComponent(function() {
    this.defaultAttrs({
      wrapper: 'swiper-wrapper',
      slide: 'swiper-slide',
      lazyLoadThreshold: void 0
    });
    this.contentHtml = function(urls) {
      var index, slideHtml, url, _i, _len;
      slideHtml = "";
      index = 0;
      for (_i = 0, _len = urls.length; _i < _len; _i++) {
        url = urls[_i];
        slideHtml += this.slideHtml(url, index);
        index++;
      }
      return "<div class=\"" + this.attr.wrapper + "\">" + slideHtml + "</div>";
    };
    this.slideHtml = function(url, index) {
      return "<div class=\"" + this.attr.slide + "\"><img " + (this.srcAttr(index)) + "=\"" + url + "\"></div>";
    };
    this.srcAttr = function(index) {
      if (index >= this.attr.lazyLoadThreshold) {
        return 'data-src';
      } else {
        return 'src';
      }
    };
    this.setup = function(event, data) {
      this.$node.append(this.contentHtml(data.urls));
      return this.trigger('uiGalleryContentReady');
    };
    return this.after('initialize', function() {
      return this.on('dataGalleryContentAvailable', this.setup);
    });
  });
});
