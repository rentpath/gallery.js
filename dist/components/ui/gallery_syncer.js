define(['jquery', 'flight/lib/component'], function($, defineComponent) {
  return defineComponent(function() {
    this.defaultAttrs({
      componentsToSync: null
    });
    this.updateSyncedGalleries = function(event, data) {
      var component, i, len, ref, results;
      ref = this.attr.componentsToSync;
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        component = ref[i];
        if (!$(component).is(event.target)) {
          results.push(this.trigger(component, 'uiGalleryWantsToGoToIndex', {
            index: data.activeIndex
          }));
        } else {
          results.push(void 0);
        }
      }
      return results;
    };
    return this.after('initialize', function() {
      return this.on('uiGallerySlideChanged', this.updateSyncedGalleries);
    });
  });
});
