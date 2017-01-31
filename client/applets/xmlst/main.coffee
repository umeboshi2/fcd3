BootStrapAppRouter = require 'agate/src/bootstrap_router'


Controller = require './controller'


MainChannel = Backbone.Radio.channel 'global'
AppChannel = Backbone.Radio.channel 'xmlst'



class Router extends BootStrapAppRouter
  appRoutes:
    '': 'start'
    'xmlst/listprops': 'list_properties'
    'xmlst/viewprop/:id': 'view_property'

    
MainChannel.reply 'applet:xmlst:route', () ->
  controller = new Controller MainChannel
  AppChannel.reply 'view-property', (prop_id) ->
    controller.view_property prop_id
  AppChannel.reply 'list-properties', ->
    controller.list_properties()
  router = new Router
    controller: controller
    
