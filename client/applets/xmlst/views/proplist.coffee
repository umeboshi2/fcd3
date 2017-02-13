Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'
Url = require 'url'


Util = require '../util'

MainChannel = Backbone.Radio.channel 'global'
AppChannel = Backbone.Radio.channel 'xmlst'

########################################

make_rent_rooms_row = tc.renderable (model) ->
  property = model.property
  rent = property.Floorplan.EffectiveRent
  tc.div '.rental-info-row.row', ->
    tc.div '.col-sm-1', ->
      tc.dl ->
        active_listing = if model.active then 'active' else 'inactive'
        tc.dt "Listing"
        tc.dd active_listing
    tc.div '.col-sm-2', ->
      tc.dl ->
        #tc.dt "Rooms"
        if property.Floorplan.Room.length
          # list comprehension (makes Array)
          rooms = (r.Comment for r in property.Floorplan.Room)
          tc.dt "Bed/Bath"
          tc.dd rooms.join ', '
    tc.div '.col-sm-2', ->
      tc.dl ->
        tc.dt "Rent"
        min_rent = rent.$.Min
        max_rent = rent.$.Max
        if min_rent != max_rent
          tc.dd "$#{rent.$.Min} - $#{rent.$.Max}"
        else
          tc.dd "$#{min_rent}"
    tc.div '.col-sm-4', ->
      tc.dl ->
        address = property.PropertyID.Address  
        tc.dt "Address"
        tc.dd ->
          tc.address ->
            tc.text address.Address
            tc.br()
            tc.text "#{address.City}, #{address.State}  #{address.PostalCode}"

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
        thumb = Util.get_thumb_url model
        tc.img '.media-object', src:thumb
      tc.div '.media-body', ->
        make_rent_rooms_row model
        tc.div '.row', ->
          make_buttons model
    if __DEV__ and false
      unitid = model.custom.id
      propid = model.property.PropertyID.Identification.IDValue
      tc.span '.alert.alert-warning', ->
        tc.small ->
          tc.strong "UnitID #{unitid}, PropertyID #{propid}"
  if __DEV__ and false
    url = model.property.Floorplan.FloorplanAvailabilityURL
    tc.span '.alert.alert-warning', ->
      tc.small ->
        tc.strong url
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
    appurl = Util.rental_app_link @get_listing_id()
    window.open(appurl, '_blank')

  open_listing_page: (event) ->
    prop = @model.get 'property'
    window.open(prop.Floorplan.FloorplanAvailabilityURL, '_blank')
    
    
    
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
      
class PropListView extends Backbone.Marionette.CompositeView
  childView: SimplePropInfoView
  template: tc.renderable () ->
    tc.div '#proplist-container.listview-list.col-sm-10.col-sm-offset-1'
  childViewContainer: '#proplist-container'
  ui:
    proplist: '#proplist-container'

module.exports = PropListView
