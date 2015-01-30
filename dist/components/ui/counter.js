define(['jquery', 'flight/lib/component', 'swiper'], function($, defineComponent) {
  return defineComponent(function() {
    this.defaultAttrs({
      activeSelector: '.js-ui-counter-active',
      totalSelector: '.js-ui-counter-total'
    });
    this.initializeCounter = function(event, data) {
      $(this.attr.activeSelector).text(1);
      return $(this.attr.totalSelector).text(data.urls.length);
    };
    this.updateCounter = function(event, data) {
      return $(this.attr.activeSelector).text(data.activeIndex + 1);
    };
    return this.after('initialize', function() {
      this.on('dataGalleryContentAvailable', this.initializeCounter);
      return this.on('uiSwiperSlideChanged', this.updateCounter);
    });
  });
});
