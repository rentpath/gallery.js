var indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

define(['jquery', 'flight/lib/component'], function($, defineComponent) {
  return defineComponent(function() {
    this.defaultAttrs({
      previousSelector: '.js-ui-navigation-previous',
      nextSelector: '.js-ui-navigation-next',
      disabledClass: 'disabled',
      loop: false
    });
    this.initializeNavigation = function(event, data) {
      if (data.urls.length > 1) {
        this.select('nextSelector').removeClass(this.attr.disabledClass);
        if (this.attr.loop) {
          return this.select('previousSelector').removeClass(this.attr.disabledClass);
        } else {
          return this.select('previousSelector').addClass(this.attr.disabledClass);
        }
      } else {
        this.select('previousSelector').addClass(this.attr.disabledClass);
        return this.select('nextSelector').addClass(this.attr.disabledClass);
      }
    };
    this.displayButtons = function(event, data) {
      if (!this.attr.loop) {
        if (data.activeIndex > 0) {
          this.select('previousSelector').removeClass(this.attr.disabledClass);
        } else {
          this.select('previousSelector').addClass(this.attr.disabledClass);
        }
        if ((data.activeIndex + 1) < data.total) {
          return this.select('nextSelector').removeClass(this.attr.disabledClass);
        } else {
          return this.select('nextSelector').addClass(this.attr.disabledClass);
        }
      }
    };
    this.setLoopValue = function(event, data) {
      var images, uniqueImages;
      if (this.attr.loop !== data.swiper.params.loop) {
        this.attr.loop = data.swiper.params.loop;
        images = $(data.swiper.slides).find('img');
        uniqueImages = [];
        images.each(function(index, image) {
          var src;
          src = $(image).attr('src') || $(image).data('src');
          if (indexOf.call(uniqueImages, src) < 0) {
            return uniqueImages.push(src);
          }
        });
        return this.initializeNavigation(event, {
          urls: uniqueImages
        });
      }
    };
    return this.after('initialize', function() {
      this.on('dataGalleryContentAvailable', this.initializeNavigation);
      this.on('uiGallerySlideChanged', this.displayButtons);
      this.on('uiSwiperInitialized', this.setLoopValue);
      this.select('previousSelector').on('click', (function(_this) {
        return function(event, data) {
          event.preventDefault();
          return _this.trigger('uiGalleryWantsPrevItem');
        };
      })(this));
      return this.select('nextSelector').on('click', (function(_this) {
        return function(event, data) {
          event.preventDefault();
          return _this.trigger('uiGalleryWantsNextItem');
        };
      })(this));
    });
  });
});
