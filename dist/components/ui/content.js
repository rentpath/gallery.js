define(['jquery', 'flight/lib/component'], function($, defineComponent) {
  return defineComponent(function() {
    this.defaultAttrs({
      wrapper: 'swiper-wrapper',
      slide: 'swiper-slide',
      backgroundImg: false
    });
    this.contentHtml = function(urls) {
      var i, len, slideHtml, url;
      slideHtml = "";
      for (i = 0, len = urls.length; i < len; i++) {
        url = urls[i];
        slideHtml += this.slideHtml(url);
      }
      return "<div class=\"" + this.attr.wrapper + "\">" + slideHtml + "</div>";
    };
    this.slideHtml = function(url) {
      if (this.attr.backgroundImg) {
        return "<div class=\"" + this.attr.slide + "\" data-src=\"" + url + "\"></div>";
      } else {
        return "<div class=\"" + this.attr.slide + "\"><img data-src=\"" + url + "\"></div>";
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
