define(['jquery', 'flight/lib/component', 'swiper'], function($, defineComponent) {
  return defineComponent(function() {
    this.defaultAttrs({
      previousSelector: '.js-ui-navigation-previous',
      nextSelector: '.js-ui-navigation-next',
      loop: false
    });
    this.initializeNavigation = function(event, data) {
      if (data.urls.length > 1) {
        $(this.attr.nextSelector).show();
        if (this.attr.loop) {
          return $(this.attr.previousSelector).show();
        } else {
          return $(this.attr.previousSelector).hide();
        }
      } else {
        $(this.attr.previousSelector).hide();
        return $(this.attr.nextSelector).hide();
      }
    };
    this.handleButtons = function(event, data) {
      if (!this.attr.loop) {
        if (data.activeIndex > 0) {
          $(this.attr.previousSelector).show();
        } else {
          $(this.attr.previousSelector).hide();
        }
        if ((data.activeIndex + 1) < data.total) {
          return $(this.attr.nextSelector).show();
        } else {
          return $(this.attr.nextSelector).hide();
        }
      }
    };
    this.setLoopValue = function(event, data) {
      this.attr.loop = data.loop;
      return this.initializeNavigation(event, {
        urls: data.swiper.slides
      });
    };
    return this.after('initialize', function() {
      this.on('dataGalleryContentAvailable', this.initializeNavigation);
      this.on('uiSwiperSlideChanged', this.handleButtons);
      this.on('uiSwiperInitialized', this.setLoopValue);
      $(this.attr.previousSelector).on('click', (function(_this) {
        return function(event, data) {
          event.preventDefault();
          return _this.trigger('uiSwiperWantsPrevItem');
        };
      })(this));
      return $(this.attr.nextSelector).on('click', (function(_this) {
        return function(event, data) {
          event.preventDefault();
          return _this.trigger('uiSwiperWantsNextItem');
        };
      })(this));
    });
  });
});
