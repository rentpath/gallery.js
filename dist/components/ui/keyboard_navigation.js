define(['jquery', 'flight/lib/component'], function($, defineComponent) {
  var keyboardNavigation;
  keyboardNavigation = function() {
    this.defaultAttrs({
      galleryNode: document,
      modalSelector: '',
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
      if (this.attr.acceptedKeys[key_code] && !this._input_field_has_focus_or_modal_is_open()) {
        return this.trigger(this.attr.acceptedKeys[key_code]);
      }
    };
    this._input_field_has_focus_or_modal_is_open = function() {
      return this._input_field_has_focus() || this._modal_is_open();
    };
    this._input_field_has_focus = function() {
      return $(document.activeElement).is('input, textarea, select');
    };
    this._modal_is_open = function() {
      return $(document).find(this.attr.modalSelector).length > 0;
    };
    return this.after('initialize', function() {
      return this.on($(this.attr.galleryNode), 'keydown', this.evaluateKeyDown);
    });
  };
  return defineComponent(keyboardNavigation);
});
