define [
], (
) ->
  ->
    # NullSwiper
    @swiper =
      swipeTo: ->
      reInit: ->
      params: {loop: false}
      activeLoopIndex: 0
      activeIndex: 0
      slideClass: ''

    # data.index is required int
    # data.speed is optional int (milliseconds)
    @goToIndex = (event, data) ->
      unless data.index is @activeIndex()
        @swiper.swipeTo(data.index, data.speed)

    @activeIndex = ->
      if @swiper.params.loop then @swiper.activeLoopIndex else @swiper.activeIndex
