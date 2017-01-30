$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'

Util = require 'agate/src/apputil'
{ MainController } = require 'agate/src/controllers'
{ make_sidebar_template } = require 'agate/src/templates/layout'

Models = require './models'
Collections = require './collections'

MiscViews = require './views/misc'
SideBarView = require './views/sidebar'


BumblrChannel = Backbone.Radio.channel 'bumblr'


class HeaderView extends Backbone.Marionette.View
  template: tc.renderable (model) ->
    #tc.strong model.title
    tc.div '.listview-header', model.title
    
make_header_view = (title) ->
  model = new Backbone.Model
    title: title
  view = new HeaderView
    model: model
  view
  

class XMLstLayout extends Backbone.Marionette.View
  template: tc.renderable ->
    tc.div '#header'
    tc.div '#main-content'
  regions:
    header: '#header'
    sidebar: '#sidebar'
    content: '#main-content'
    
class Controller extends MainController
  main_model: new Collections.MainListingsModel
  layoutClass: XMLstLayout
  combined_collection: null
  
  
  set_header: (title) ->
    view = make_header_view title
    @layout.showChildView 'header', view

  get_property_list: (callback) ->
    response = @main_model.fetch()
    response.done =>
      @combined_collection = Collections.make_combined_list @main_model
      if __DEV__
        console.log "SUCCESS", @main_model
      callback()
    response.error =>
      if __DEV__
        console.log "ERROR", @main_model
        console.warn "Make a dialog or send error message"
    
  start: ->
    @setup_layout_if_needed()
    response = @main_model.fetch()
    response.done =>
      @combined_collection = Collections.make_combined_list @main_model
      if __DEV__
        console.log "SUCCESS", @main_model
      @list_properties()
    response.error =>
      if __DEV__
        console.log "ERROR", @main_model
        console.warn "Make a dialog or send error message"
    #@get_property_list @list_properties
    
  list_properties: () ->
    @setup_layout_if_needed()
    @set_header 'Property Listings'
    cmblist = @combined_collection
      
    require.ensure [], () =>
      console.log 'list_properties'
      physical_property = @main_model.get 'PhysicalProperty'
      properties = physical_property.Property
      PropListView = require './views/proplist'
      view = new PropListView
        collection: cmblist
      @layout.showChildView 'content', view
    # name the chunk
    , 'xmlst-view-list-props'
    
  view_property: (prop_id) ->
    #console.log 'view blog called for ' + blog_id
    @setup_layout_if_needed()
    require.ensure [], () =>
      BlogPostListView = require './views/postlist'
      response = collection.fetch()
      response.done =>
        view = new BlogPostListView
          collection: collection
        @layout.showChildView 'content', view
        Util.scroll_top_fast()
    # name the chunk
    , 'xmlst-view-prop-view'
    
module.exports = Controller

