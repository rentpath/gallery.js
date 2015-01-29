define(['jquery', 'flight/lib/component', 'swiper'], function($, defineComponent) {
  return defineComponent(function() {
    this.defaultAttrs({
      counterSelector: '.ui_counter'
    });
    this.initializeCounter = function(event, data) {
      return $(this.attr.counterSelector).text('1 of ' + data.urls.length);
    };
    this.updateCounter = function(event, data) {
      return $(this.attr.counterSelector).text((data.activeIndex + 1) + ' of ' + data.total);
    };
    return this.after('initialize', function() {
      this.on('dataGalleryContentAvailable', this.initializeCounter);
      return this.on('uiSwiperSlideChanged', this.updateCounter);
    });
  });
});
