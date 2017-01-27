Marionette = require 'backbone.marionette'

require './base'

prepare_app = require 'agate/src/app-prepare'

appmodel = require './base-appmodel'
#appmodel.set 'applets',
applets = 
  [
    {
      appname: 'bumblr'
      name: 'Bumblr'
      url: '#bumblr'
    }
    {
      appname: 'xmlst'
      name: 'XMLst'
      url: '#xmlst'
    }
  ]
appmodel.set 'applets', applets

brand = appmodel.get 'brand'
brand.url = '#'
appmodel.set brand: brand
  
MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
DocChannel = Backbone.Radio.channel 'static-documents'

main_entry =
  label: 'Main'
  applets: ['bumblr']
  single_applet: false
  
applet_menus = [
  main_entry
  {
    label: 'Stuff'
    single_applet: true
    applets: ['bumblr', 'xmlst']
  }
  ]

appmodel.set 'applet_menus', applet_menus

# use a signal to request appmodel
MainChannel.reply 'main:app:appmodel', ->
  appmodel

######################
# require applets
#require 'agate/src/applets/frontdoor/main'
require '../applets/frontdoor/main'
require '../applets/bumblr/main'
require '../applets/xmlst/main'

app = prepare_app appmodel

if __DEV__
  # DEBUG attach app to window
  window.App = app

# start the app
app.start()

module.exports = app


