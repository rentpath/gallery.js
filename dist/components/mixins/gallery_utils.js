define([], function() {
  return function() {
    this.swiper = {
      slideTo: function() {},
      update: function() {},
      params: {
        loop: false
      },
      activeIndex: 0,
      slideClass: ''
    };
    return this.goToIndex = function(event, data) {
      var $node;
      $node = this.$node;
      if ($node.is(':visible')) {
        return this.swiper.slideTo(data.index, data.speed);
      } else {
        $node.show();
        this.swiper.slideTo(data.index, data.speed);
        return $node.hide();
      }
    };
  };
});
