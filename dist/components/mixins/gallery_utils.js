define([], function() {
  return function() {
    this.swiper = {
      swipeTo: function() {},
      params: {
        loop: false
      },
      activeLoopIndex: 0,
      activeIndex: 0,
      slideClass: ''
    };
    this.goToIndex = function(event, data) {
      if (data.index !== this.activeIndex()) {
        return this.swiper.swipeTo(data.index, data.speed);
      }
    };
    return this.activeIndex = function() {
      if (this.swiper.params.loop) {
        return this.swiper.activeLoopIndex;
      } else {
        return this.swiper.activeIndex;
      }
    };
  };
});
