BootStrapAppRouter = require 'agate/src/bootstrap_router'

Controller = require './controller'

MainChannel = Backbone.Radio.channel 'global'
XmlstChannel = Backbone.Radio.channel 'xmlst'



class Router extends BootStrapAppRouter
  appRoutes:
    'xmlst': 'start'
    'xmlst/settings': 'settings_page'
    'xmlst/dashboard': 'show_dashboard'
    'xmlst/listblogs': 'list_blogs'
    'xmlst/viewblog/:id': 'view_blog'
    'xmlst/addblog' : 'add_new_blog'

    
MainChannel.reply 'applet:xmlst:route', () ->
  controller = new Controller MainChannel
  router = new Router
    controller: controller
    
