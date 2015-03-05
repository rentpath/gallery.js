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
        '109': 'uiGalleryWantsPrevItem' # minus key (keypad)
        '189': 'uiGalleryWantsPrevItem' # minus key
        '39':  'uiGalleryWantsNextItem' # right arrow
        '107': 'uiGalleryWantsNextItem' # plus key (keypad)
        '187': 'uiGalleryWantsNextItem' # plus key

    @evaluateKeyDown = (event, data) ->
      key_code = event.which?.toString()
      if @attr.acceptedKeys[key_code] and not @_input_field_or_modal()
        this.trigger @attr.acceptedKeys[key_code]

    @_input_field_or_modal = ->
      $(document.activeElement).is('input, textarea, select') or $(document).find('.prm_dialog_modal').length > 0

    @after 'initialize', ->
      @on $(@attr.galleryNode), 'keydown', @evaluateKeyDown

  defineComponent keyboardNavigation