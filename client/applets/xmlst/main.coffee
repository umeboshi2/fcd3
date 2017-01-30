BootStrapAppRouter = require 'agate/src/bootstrap_router'

Controller = require './controller'

MainChannel = Backbone.Radio.channel 'global'
XmlstChannel = Backbone.Radio.channel 'xmlst'



class Router extends BootStrapAppRouter
  appRoutes:
    '': 'start'
    'xmlst/listprops': 'list_properties'
    'xmlst/viewprop/:id': 'view_property'

    
MainChannel.reply 'applet:xmlst:route', () ->
  controller = new Controller MainChannel
  router = new Router
    controller: controller
    
