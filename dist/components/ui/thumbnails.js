define(['jquery', 'underscore', 'flight/lib/component', '../mixins/gallery_utils', 'swiper'], function($, _, defineComponent, galleryUtils) {
  var Thumbnails;
  Thumbnails = function() {
    this.defaultAttrs({
      swiperConfig: {},
      transitionSpeed: 200
    });
    this.$swiperSlides = function() {
      var cssClass;
      cssClass = '.' + this.swiper.params.slideClass;
      return this.$node.find(cssClass);
    };
    this.initSwiper = function() {
      var swiperConfig;
      this.initializeFirstSlide();
      swiperConfig = _.clone(this.attr.swiperConfig);
      swiperConfig.onSlideClick = (function(_this) {
        return function(swiper) {
          if (swiper.clickedSlideIndex < _this.attr.photoCount) {
            _this.activateSlide(swiper.clickedSlideIndex);
            return _this.trigger('uiGallerySlideChanged', {
              activeIndex: swiper.clickedSlideIndex
            });
          }
        };
      })(this);
      this.swiper = new Swiper(this.node, swiperConfig);
      this.trigger('uiSwiperInitialized', {
        swiper: this.swiper
      });
      return this.on(document, 'uiGallerySlideChanged', function(event, data) {
        this.activateSlide(data.activeIndex);
        return this.transitionGallery(this.$swiperSlides().eq(data.activeIndex)[0]);
      });
    };
    this.slides = function() {
      return this.swiper.slides;
    };
    this.visibleSlides = function() {
      return this.swiper.slides.slice(this.swiper.activeIndex, this.swiper.activeIndex + this.visibleSlideCount());
    };
    this.visibleSlideCount = function() {
      if (this.isLastThumbnailSet()) {
        return this.slides().length - this.swiper.activeIndex;
      } else {
        return this.swiper.params.slidesPerView;
      }
    };
    this.activateSlide = function(index) {
      this.$swiperSlides().removeClass('active-slide');
      return this.$swiperSlides().eq(index).addClass('active-slide');
    };
    this.initializeFirstSlide = function() {
      return this.$swiperSlides().first().addClass('active-slide');
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
    this.isFirstThumbnailSet = function() {
      return this.swiper.activeIndex < this.swiper.params.slidesPerView;
    };
    this.isLastThumbnailSet = function() {
      return this.slides().length - this.swiper.activeIndex <= this.swiper.params.slidesPerView;
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
      if (this.isFirstThumbnailSet()) {
        return this.trigger('uiGalleryWantsToGoToIndex', {
          index: 0,
          speed: this.attr.transitionSpeed
        });
      } else {
        return this.trigger('uiGalleryWantsToGoToIndex', {
          index: this.firstVisibleSlideIndex() - this.visibleSlideCount() + 1,
          speed: this.attr.transitionSpeed
        });
      }
    };
    this.reinitSwiper = function() {
      var ref;
      return (ref = this.swiper) != null ? ref.reInit() : void 0;
    };
    this.after('initialize', function() {
      this.on('uiGalleryContentReady', this.initSwiper);
      this.on('uiGalleryWantsToGoToIndex', this.goToIndex);
      return this.on('uiGalleryDimensionsChange', this.reinitSwiper);
    });
    return this.before('teardown', function() {
      var ref;
      return (ref = this.swiper) != null ? typeof ref.destroy === "function" ? ref.destroy(true) : void 0 : void 0;
    });
  };
  return defineComponent(Thumbnails, galleryUtils);
});
