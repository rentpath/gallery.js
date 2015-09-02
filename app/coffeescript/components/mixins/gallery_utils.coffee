define [
], (
) ->
  ->
    # NullSwiper
    @swiper =
      slideTo: ->
      reInit: ->
      params: {loop: false}
      activeLoopIndex: 0
      activeIndex: 0
      slideClass: ''

    # data.index is required int
    # data.speed is optional int (milliseconds)
    @goToIndex = (event, data) ->
      unless data.index is @activeIndex()
        $node = @$node
        if $node.is(':visible')
          @swiper.slideTo(data.index, data.speed)
        else
          # We must show the thumbnail tray briefly so that Swiper can calculate
          # the current slide position correctly.
          $node.show()
          @swiper.slideTo(data.index, data.speed)
          $node.hide()

    @activeIndex = ->
      if @swiper.params.loop then @swiper.activeLoopIndex else @swiper.activeIndex
