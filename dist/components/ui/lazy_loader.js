define(['jquery', 'flight/lib/component'], function($, defineComponent) {
  return defineComponent(function() {
    this.lazyLoad = function() {
      return this.$node.find("img[data-src]").each(function() {
        var img;
        img = $(this);
        return img.attr('src', img.attr('data-src')).removeAttr('data-src');
      });
    };
    return this.after('initialize', function() {
      return this.on('uiLazyLoadRequest', this.lazyLoad);
    });
  });
});
