$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'
#xml = require 'xml2js'
xml = require 'xml2js-parseonly/src/xml2js'

Util = require 'agate/src/apputil'
{ MainController } = require 'agate/src/controllers'
{ make_sidebar_template } = require 'agate/src/templates/layout'

Collections = require './collections'


AppChannel = Backbone.Radio.channel 'xmlst'



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
  
xml_url = 'https://availablerentals.managebuilding.com/Resident/PublicPages/XMLRentals.ashx?listings=all'
# use local file for testing
if __DEV__
  xml_url = '/assets/XMLRentals.xml'

class XMLstLayout extends Backbone.Marionette.View
  template: tc.renderable ->
    tc.div '#header'
    tc.div '#main-content'
  regions:
    header: '#header'
    sidebar: '#sidebar'
    content: '#main-content'

class Controller extends MainController
  layoutClass: XMLstLayout
  combined_collection: undefined
  

  get_xml_listing: (cb) ->
    xhr = Backbone.ajax
      type: 'GET'
      dataType: 'text'
      url: xml_url
    xhr.done =>
      @parse_xml_listing xhr, cb

  # FIXME
  # double arrows to preserve link to
  # controller
  parse_xml_listing: (xhr, cb) =>
    #console.log "parse_xml_listing", xhr
    Parser = new xml.Parser
      explicitArray: false
      async: false
    xhr.done =>
      Parser.parseString xhr.responseText, (err, json) =>
        model = new Backbone.Model json
        @combined_collection = Collections.make_combined_list model
        cb()
      
    
      
  set_header: (title) ->
    view = make_header_view title
    @layout.showChildView 'header', view

  start: ->
    @setup_layout_if_needed()
    # start with list_properties
    if not @combined_collection?
      # grab xml if collection undefined
      @get_xml_listing @list_properties
    else
      # data exists, go ahead and make list
      @list_properties()
      
  list_properties: () =>
    @setup_layout_if_needed()
    @set_header 'Property Listings'
    cmblist = @combined_collection
    PropListView = require './views/proplist'
    view = new PropListView
      collection: cmblist
    @layout.showChildView 'content', view
    Util.scroll_top_fast()

  view_property: (prop_id) ->
    @setup_layout_if_needed()
    @set_header 'Property View'
    #console.log "Combined_Collection", @combined_collection
    model = @combined_collection.get Number prop_id
    #console.log "model is", model
    PropView = require './views/propview'
    view = new PropView
      model: model
    @layout.showChildView 'content', view
    Util.scroll_top_fast()
    
module.exports = Controller

