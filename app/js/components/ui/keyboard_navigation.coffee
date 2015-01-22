define [
  'jquery',
  'flight/lib/component'
], (
  $,
  defineComponent
) ->

  keyboardNavigation = ->

    @defaultAttrs
      galleryNode: document
      acceptedKeys:
        '37':  'uiGalleryWantsPrevItem' # left arrow
        '109': 'uiGalleryWantsPrevItem' # minus key
        '39':  'uiGalleryWantsNextItem' # right arrow
        '107': 'uiGalleryWantsNextItem' # plus key

    @evaluateKeyDown = (ev, data) ->
      if $(ev.target).data('gallery') && @attr.acceptedKeys[data.which.toString()]
        @trigger @attr.acceptedKeys[data.which.toString()]

    @after 'initialize', ->
      @on $(@attr.galleryNode), 'keydown', this.evaluateKeyDown

  defineComponent keyboardNavigation
