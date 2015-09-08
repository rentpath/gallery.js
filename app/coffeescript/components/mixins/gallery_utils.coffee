define [
], (
) ->
  ->
    # NullSwiper
    @swiper =
      slideTo: ->
      update: ->
      params: {loop: false}
      activeIndex: 0
      slideClass: ''

    # data.index is required int
    # data.speed is optional int (milliseconds)
    @goToIndex = (event, data) ->
      $node = @$node
      if $node.is(':visible')
        @swiper.slideTo(data.index, data.speed)
      else
        # We must show the thumbnail tray briefly so that Swiper can calculate
        # the current slide position correctly.
        $node.show()
        @swiper.slideTo(data.index, data.speed)
        $node.hide()
