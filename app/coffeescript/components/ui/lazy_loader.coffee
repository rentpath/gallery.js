define [
  'jquery'
  'flight/lib/component'
], (
  $
  defineComponent
) ->

  defineComponent ->

    @lazyLoad = ->
      @$node.find("img[data-src]").each ->
        img = $(@)
        img.attr('src', img.attr('data-src')).removeAttr('data-src')

    @after 'initialize', ->
      @on 'uiLazyLoadRequest', @lazyLoad
