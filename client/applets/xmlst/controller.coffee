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
    tc.strong model.title
    
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
  
  set_header: (title) ->
    view = make_header_view title
    @layout.showChildView 'header', view
    
  start: ->
    @setup_layout_if_needed()
    window.mainModel = @main_model
    response = @main_model.fetch()
    response.done =>
      console.log "SUCCESS", @main_model
      @list_properties()
    response.error =>
      console.log "ERROR", @main_model
    #console.log "response", response
    
    
  list_properties: () ->
    @setup_layout_if_needed()
    if __DEV__
      #crcoll = Collections.make_custom_records @main_model
      #console.log 'crcoll', crcoll
      #pcoll = Collections.make_property_models @main_model
      #console.log 'pcoll', pcoll
      #window.pcoll = pcoll
      #window.crcoll = crcoll
      cmblist = Collections.make_combined_list @main_model
      window.cmblist = cmblist
      console.log 'cmblist', cmblist
      
    require.ensure [], () =>
      console.log 'list_properties'
      #console.log "sidebar created"
      physical_property = @main_model.get 'PhysicalProperty'
      properties = physical_property.Property
      #console.log "Properties", properties
      SimpleBlogListView = require './views/bloglist'
      view = new SimpleBlogListView
        collection: cmblist
      #@_show_content view
      @layout.showChildView 'content', view
    # name the chunk
    , 'xmlst-view-list-props'
    
  view_property: (blog_id) ->
    #console.log 'view blog called for ' + blog_id
    @setup_layout_if_needed()
    require.ensure [], () =>
      host = blog_id + '.tumblr.com'
      collection = BumblrChannel.request 'make_blog_post_collection', host
      BlogPostListView = require './views/postlist'
      response = collection.fetch()
      response.done =>
        view = new BlogPostListView
          collection: collection
        #@_show_content view
        @layout.showChildView 'content', view
        Util.scroll_top_fast()
    # name the chunk
    , 'xmlst-view-prop-view'
    
  settings_page: () ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      ConsumerKeyFormView = require './views/settingsform'
      settings = BumblrChannel.request 'get_app_settings'
      view = new ConsumerKeyFormView model:settings
      #@_show_content view
      @layout.showChildView 'content', view
      Util.scroll_top_fast()
    # name the chunk
    , 'xmlst-view-settings'
    
module.exports = Controller

