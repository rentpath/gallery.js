define([], function() {
  return function() {
    this.swiper = {
      slideTo: function() {},
      reInit: function() {},
      params: {
        loop: false
      },
      activeLoopIndex: 0,
      activeIndex: 0,
      slideClass: ''
    };
    this.goToIndex = function(event, data) {
      var $node;
      if (data.index !== this.activeIndex()) {
        $node = this.$node;
        if ($node.is(':visible')) {
          return this.swiper.slideTo(data.index, data.speed);
        } else {
          $node.show();
          this.swiper.slideTo(data.index, data.speed);
          return $node.hide();
        }
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
