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
      exclusionSelector: ''
      acceptedKeys:
        '37':  'uiGalleryWantsPrevItem' # left arrow
        '109': 'uiGalleryWantsPrevItem' # minus key (keypad)
        '189': 'uiGalleryWantsPrevItem' # minus key
        '39':  'uiGalleryWantsNextItem' # right arrow
        '107': 'uiGalleryWantsNextItem' # plus key (keypad)
        '187': 'uiGalleryWantsNextItem' # plus key

    @evaluateKeyDown = (event, data) ->
      key_code = event.which?.toString()
      if @attr.acceptedKeys[key_code] and not @_inputFieldHasFocusOrExclusionIsPresent()
        this.trigger @attr.acceptedKeys[key_code]

    @_inputFieldHasFocusOrExclusionIsPresent = ->
      @_inputFieldHasFocus() or @_exclusionIsPresent()

    @_inputFieldHasFocus = ->
      $(document.activeElement).is('input, textarea, select')

    @_exclusionIsPresent = ->
      $(document).find(@attr.exclusionSelector).length > 0

    @after 'initialize', ->
      @on $(@attr.galleryNode), 'keydown', @evaluateKeyDown

  defineComponent keyboardNavigation