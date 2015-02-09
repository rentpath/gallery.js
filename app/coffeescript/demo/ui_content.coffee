"use strict"
requirejs.config
  baseUrl: "bower_components"
  paths:
    components: "../js/components"
    jquery: "jquery/dist/jquery.min"

require ["components/ui/content"], (ContentUI) ->

  INTERESTING_EVENTS = ['uiGalleryContentReady']

  for eventName in INTERESTING_EVENTS
    $(document).on eventName, (event, data) ->
      console?.log?(event, data)

  ContentUI.attachTo ".js-ui-content"