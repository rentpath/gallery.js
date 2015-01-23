define(['jquery', 'flight/lib/component'], function($, defineComponent) {
  var keyboardNavigation;
  keyboardNavigation = function() {
    this.defaultAttrs({
      galleryNode: document,
      acceptedKeys: {
        '37': 'uiGalleryWantsPrevItem',
        '109': 'uiGalleryWantsPrevItem',
        '39': 'uiGalleryWantsNextItem',
        '107': 'uiGalleryWantsNextItem'
      }
    });
    this.evaluateKeyDown = function(ev, data) {
      if ($(ev.target).data('gallery') && this.attr.acceptedKeys[data.which.toString()]) {
        return this.trigger(this.attr.acceptedKeys[data.which.toString()]);
      }
    };
    return this.after('initialize', function() {
      return this.on($(this.attr.galleryNode), 'keydown', this.evaluateKeyDown);
    });
  };
  return defineComponent(keyboardNavigation);
});
