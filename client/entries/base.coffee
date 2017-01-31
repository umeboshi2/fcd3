$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'

  
require 'bootstrap'

{ BootstrapModalRegion } = require 'agate/src/regions'

MainChannel = Backbone.Radio.channel 'global'

_MainLayoutTemplate = tc.renderable (container) ->
  #tc.div '#navbar-view-container'
  #tc.div '#editor-bar-container'
  tc.div ".#{container}", ->
    #tc.div '.row', ->
    #  tc.div '.col-md-10', ->
    #    tc.div '#messages'
    tc.div '#applet-content.row'
  tc.div '#footer'
  tc.div '#modal'

MainLayoutTemplate = ->
  _MainLayoutTemplate 'container'

MainFluidLayoutTemplate = ->
  _MainLayoutTemplate 'container-fluid'
  
class MainPageLayout extends Backbone.Marionette.View
  template: MainFluidLayoutTemplate
  regions:
    #messages: '#messages'
    #navbar: '#navbar-view-container'
    modal: BootstrapModalRegion
    applet: '#applet-content'
    footer: '#footer'
    

if __DEV__
  console.warn "__DEV__", __DEV__, "DEBUG", DEBUG
  Backbone.Radio.DEBUG = true
  #FIXME
  window.chnnl = MainChannel
  
# taken from agate
# removed navbar and messages
initialize_page = (app) ->
  #regions = MainChannel.request 'main:app:regions'
  appmodel = MainChannel.request 'main:app:appmodel'
  # create layout view
  if appmodel.has 'appView'
    AppView = appmodel.get 'appView'
  else
    AppView = Views.MainPageLayout
    
  layout_opts = {}
  if appmodel.has 'layout_template'
    layout_opts.template = appmodel.get 'layout_template'
  layout = new AppView layout_opts
  app.showView layout
  


class AppletMenuView extends Backbone.Marionette.View
  templateContext: ->
    applets: @applets
    
  template: tc.renderable (entry) ->
    if entry?.applets
      tc.li '.dropdown', ->
        tc.a '.dropdown-toggle', 'data-toggle':'dropdown', ->
          tc.text entry.label
          tc.b '.caret'
        tc.ul '.dropdown-menu', ->
          for appname in entry.applets
            tc.li appname:applets[appname].appname, ->
              tc.a href:applets[appname].url, applets[appname].name
    else
      tc.li ->
        tc.a href:entry.url, entry.label
    


######################
# start app setup

MainChannel.reply 'mainpage:init', (appmodel) ->
  # get the app object
  app = MainChannel.request 'main:app:object'
  # initialize the main view
  initialize_page app
  # emit the main view is ready
  MainChannel.trigger 'mainpage:displayed'


MainChannel.on 'mainpage:displayed', ->
  # this handler is useful if there are views that need to be
  # added to the navbar.  The navbar should have regions to attach
  # the views
  # --- example ---
  # view = new view
  # aregion = MainChannel.request 'main:app:get-region', aregion
  # aregion.show view

  app = MainChannel.request 'main:app:object'
  appmodel = MainChannel.request 'main:app:appmodel'

  # current user should already be fetched before
  # any view is shown
  if appmodel.get 'hasUser'
    user = MainChannel.request 'current-user'
    #view = new UserMenuView
    view = new Backbone.Marionette.View
      model: user
    navbar = app.getView().getChildView('navbar')
    navbar.showChildView 'usermenu', view
  


module.exports = {}
