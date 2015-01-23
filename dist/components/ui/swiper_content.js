define(['jquery', 'flight/lib/component'], function($, defineComponent) {
  return defineComponent(function() {
    this.defaultAttrs({
      wrapper: 'swiper-wrapper',
      wrapperSelector: '.swiper-wrapper',
      slide: 'swiper-slide'
    });
    this.addWrapper = function() {
      var wrapperHTML;
      wrapperHTML = "<div class=\"" + this.attr.wrapper + "\"></div>";
      return this.$node.append(wrapperHTML);
    };
    this.appendImage = function(url) {
      var slideHtml;
      slideHtml = "<div class=\"" + this.attr.slide + "\"><img src=\"" + url + "\"></div>";
      return this.select('wrapperSelector').append(slideHtml);
    };
    this.setup = function(event, data) {
      var url, _i, _len, _ref;
      this.addWrapper();
      _ref = data.urls;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        url = _ref[_i];
        this.appendImage(url);
      }
      return this.trigger('uiGalleryContentReady');
    };
    return this.after('initialize', function() {
      return this.on('dataGalleryContentAvailable', this.setup);
    });
  });
});
