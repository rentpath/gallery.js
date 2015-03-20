define(['jquery', 'flight/lib/component', '../mixins/gallery_utils', 'swiper'], function($, defineComponent, galleryUtils) {
  var Thumbnails;
  Thumbnails = function() {
    this.defaultAttrs({
      swiperConfig: {},
      transitionSpeed: 200,
      swiperSlide: '.swiper-slide'
    });
    this.initSwiper = function() {
      var key, ref, swiperConfig, value;
      this.initializeFirstSlide();
      swiperConfig = {};
      ref = this.attr.swiperConfig;
      for (key in ref) {
        value = ref[key];
        swiperConfig[key] = value;
      }
      swiperConfig.onSlideClick = (function(_this) {
        return function(swiper) {
          _this.activateSlide(swiper.clickedSlideIndex);
          return _this.trigger('uiGallerySlideClicked', {
            index: swiper.clickedSlideIndex,
            speed: 0
          });
        };
      })(this);
      this.swiper = new Swiper(this.node, swiperConfig);
      this.trigger('uiSwiperInitialized', {
        swiper: this.swiper
      });
      return this.on(document, 'uiGallerySlideChanged', function(event, data) {
        this.activateSlide(data.activeIndex);
        return this.transitionGallery(this.$node.find('.swiper-slide').eq(data.activeIndex)[0]);
      });
    };
    this.slides = function() {
      return this.swiper.slides;
    };
    this.visibleSlides = function() {
      return this.swiper.visibleSlides;
    };
    this.visibleSlideCount = function() {
      return this.visibleSlides().length;
    };
    this.activateSlide = function(index) {
      this.$node.find('.swiper-slide').removeClass('active-slide');
      return this.$node.find('.swiper-slide').eq(index).addClass('active-slide');
    };
    this.initializeFirstSlide = function() {
      return this.$node.find('.swiper-slide').first().addClass('active-slide');
    };
    this.firstVisibleSlide = function() {
      return this.visibleSlides()[0];
    };
    this.lastVisibleSlide = function() {
      var index;
      index = this.visibleSlideCount() - 1;
      return this.visibleSlides()[index];
    };
    this.firstVisibleSlideIndex = function() {
      return this.slides().indexOf(this.firstVisibleSlide());
    };
    this.lastVisibleSlideIndex = function() {
      return this.slides().indexOf(this.lastVisibleSlide());
    };
    this.rightOfVisibleSlides = function(slide) {
      return this.slides().indexOf(slide) > this.lastVisibleSlideIndex();
    };
    this.leftOfVisibleSlides = function(slide) {
      return this.slides().indexOf(slide) < this.firstVisibleSlideIndex();
    };
    this.syncWithGallery = function(event, data) {
      this.activateSlide(data.activeIndex);
      return this.transitionGallery(this.select('swiper-slide').eq(data.activeIndex)[0]);
    };
    this.advanceGallery = function() {
      return this.trigger('uiGalleryWantsToGoToIndex', {
        index: this.lastVisibleSlideIndex(),
        speed: this.attr.transitionSpeed
      });
    };
    this.transitionGallery = function(slide) {
      if (slide === this.lastVisibleSlide()) {
        return this.advanceGallery();
      } else if (this.rightOfVisibleSlides(slide)) {
        return this.advanceGallery();
      } else if (slide === this.firstVisibleSlide()) {
        return this.rewindGallery();
      } else if (this.leftOfVisibleSlides(slide)) {
        return this.rewindGallery();
      }
    };
    this.rewindGallery = function() {
      if (this.firstVisibleSlideIndex() > this.visibleSlideCount() - 1) {
        return this.trigger('uiGalleryWantsToGoToIndex', {
          index: this.firstVisibleSlideIndex() - this.visibleSlideCount() + 1,
          speed: this.attr.transitionSpeed
        });
      } else {
        return this.trigger('uiGalleryWantsToGoToIndex', {
          index: 0,
          speed: this.attr.transitionSpeed
        });
      }
    };
    return this.after('initialize', function() {
      this.on('uiGalleryContentReady', this.initSwiper);
      this.on('uiGalleryWantsToGoToIndex', this.goToIndex);
      return $(window).on('orientationchange', function() {
        var ref;
        return (ref = this.swiper) != null ? ref.reInit() : void 0;
      });
    });
  };
  return defineComponent(Thumbnails, galleryUtils);
});
