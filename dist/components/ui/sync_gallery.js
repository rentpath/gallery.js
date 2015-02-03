define(['jquery', 'flight/lib/component'], function($, defineComponent) {
  return defineComponent(function() {
    this.defaultAttrs({
      componentsToSync: []
    });
    this.updateSyncedComponents = function(event, data) {
      var component, target, _i, _len, _ref, _results;
      target = "#" + event.target.id;
      _ref = this.attr.componentsToSync;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        component = _ref[_i];
        if (component !== target) {
          _results.push($(component).trigger('uiSwiperWantsToGoToIndex', {
            index: data.activeIndex
          }));
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };
    return this.after('initialize', function() {
      return this.on('uiSwiperSlideChanged', this.updateSyncedComponents);
    });
  });
});
