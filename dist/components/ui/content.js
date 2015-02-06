define(['jquery', 'flight/lib/component'], function($, defineComponent) {
  return defineComponent(function() {
    this.defaultAttrs({
      wrapper: 'swiper-wrapper',
      slide: 'swiper-slide'
    });
    this.contentHtml = function(urls) {
      var slideHtml, url, _i, _len;
      slideHtml = "";
      for (_i = 0, _len = urls.length; _i < _len; _i++) {
        url = urls[_i];
        slideHtml += this.slideHtml(url);
      }
      return "<div class=\"" + this.attr.wrapper + "\">" + slideHtml + "</div>";
    };
    this.slideHtml = function(url) {
      return "<div class=\"" + this.attr.slide + "\"><img data-src=\"" + url + "\"></div>";
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