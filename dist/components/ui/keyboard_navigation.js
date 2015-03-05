define(['jquery', 'flight/lib/component'], function($, defineComponent) {
  var keyboardNavigation;
  keyboardNavigation = function() {
    this.defaultAttrs({
      galleryNode: document,
      acceptedKeys: {
        '37': 'uiGalleryWantsPrevItem',
        '109': 'uiGalleryWantsPrevItem',
        '189': 'uiGalleryWantsPrevItem',
        '39': 'uiGalleryWantsNextItem',
        '107': 'uiGalleryWantsNextItem',
        '187': 'uiGalleryWantsNextItem'
      }
    });
    this.evaluateKeyDown = function(event, data) {
      var key_code, _ref;
      key_code = (_ref = event.which) != null ? _ref.toString() : void 0;
      if (this.attr.acceptedKeys[key_code] && !this._input_field_or_modal()) {
        return this.trigger(this.attr.acceptedKeys[key_code]);
      }
    };
    this._input_field_or_modal = function() {
      return $(document.activeElement).is('input, textarea, select') || $(document).find('.prm_dialog_modal').length > 0;
    };
    return this.after('initialize', function() {
      return this.on($(this.attr.galleryNode), 'keydown', this.evaluateKeyDown);
    });
  };
  return defineComponent(keyboardNavigation);
});
