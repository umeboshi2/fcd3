Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'
Url = require 'url'


Hlpr = require './helpers'

MainChannel = Backbone.Radio.channel 'global'
AppChannel = Backbone.Radio.channel 'xmlst'

########################################

    
make_rent_rooms_row = tc.renderable (model) ->
  property = model.property
  rent = property.Floorplan.EffectiveRent
  tc.div '.rental-info-row.row', ->
    tc.div '.col-sm-1', ->
      active_listing = if model.active then 'active' else 'inactive'
      Hlpr.make_simple_dl "Listing", active_listing
    tc.div '.col-sm-2', ->
      if property.Floorplan.Room.length
        rooms = Hlpr.find_rooms model
        Hlpr.make_simple_dl rooms.name, rooms.value
      else
        tc.strong "No Room Info"
    tc.div '.col-sm-2', ->
      Hlpr.make_simple_dl "Rent", "$#{Hlpr.find_rent model}"
    tc.div '.col-sm-4', ->
      address = property.PropertyID.Address
      tc.dl ->
        tc.dt "Address"
        tc.dd Hlpr.make_address address
        
make_buttons = tc.renderable (model) ->
  btn_style = '.btn.btn-default.btn-sm'
  tc.span '.btn-group.col-sm-7.pull-right', ->
    if __DEV__ and false
      tc.span "#dummy.#{btn_style}", "Dummy"
    tc.span "#local-details.#{btn_style}", "Quick Details"
    if model.active
      tc.span "#appleton-details.#{btn_style}", "Details (in new window)"
      tc.span "#rental-app-button.#{btn_style}", "Apply Now"

make_propinfo = tc.renderable (model) ->
  level = if model.active then "success" else "danger"
  tc.div ".propinfo.panel.panel-#{level}", ->
    name = model.property.Floorplan.Name
    tc.div ".panel-heading.panel-#{level}.row", ->
      tc.span '.col-sm-5', name
    files = model.property.Floorplan.File
    tc.div '.panel-content.media', ->
      tc.div '.media-left', ->
        thumb = Hlpr.get_thumb_url model
        tc.img '.media-object.thumbnail', src:thumb
      tc.div '.media-body', ->
        make_rent_rooms_row model
        tc.div '.row', ->
          make_buttons model

########################################

class SimplePropInfoView extends Backbone.Marionette.View
  ui:
    propinfo: '.propinfo'
    panel_content: '.panel-content'
    rental_info_row: '.rental-info-row'
    media_left: '.media-left'
    media_body: '.media-body'
    panel_heading: '.panel-heading'
    rental_btn: '#rental-app-button'
    local_btn: '#local-details'
    appleton_btn: '#appleton-details'

  clickable_local_view: [
    'rental_info_row'
    'media_left'
    'local_btn']

  base_events:
    'click @ui.rental_btn': 'open_rental_application'
    'click @ui.appleton_btn': 'open_listing_page'
    'click @ui.panel_heading': 'toggle_content'
    
  events: ->
    events = @base_events
    for area in @clickable_local_view
      events["click @ui.#{area}"] = 'view_property'
    return events

  template: tc.renderable (model) ->
    make_propinfo model

  onDomRefresh: ->
    for area in @clickable_local_view
      @ui[area].css
        cursor: 'pointer'
    @ui.panel_heading.css
      cursor: 'pointer'
    if not @model.get 'active'
      @ui.panel_content.hide()

  toggle_content: ->
    @ui.panel_content.toggle()
    
  get_unit_id: ->
    @ui.propinfo.attr 'unitid'

  get_listing_id: ->
    prop = @model.get 'property'
    prop.listing_id
    
  view_property: (event) ->
    AppChannel.request 'view-property', @model.id

  open_rental_application: (event) ->
    appurl = Hlpr.rental_app_link @get_listing_id()
    window.open(appurl, '_blank')

  open_listing_page: (event) ->
    prop = @model.get 'property'
    window.open(prop.Floorplan.FloorplanAvailabilityURL, '_blank')
    
      
class PropListView extends Backbone.Marionette.CompositeView
  childView: SimplePropInfoView
  template: tc.renderable () ->
    tc.div '#proplist-container.listview-list.col-sm-10.col-sm-offset-1'
  childViewContainer: '#proplist-container'
  ui:
    proplist: '#proplist-container'

module.exports = PropListView
