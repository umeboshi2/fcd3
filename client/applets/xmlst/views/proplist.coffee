Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'

AppChannel = Backbone.Radio.channel 'xmlst'

########################################

make_rent_rooms_row = tc.renderable (model) ->
  property = model.property
  rent = property.Floorplan.EffectiveRent
  tc.div '.row', ->
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
    tc.div '.col-sm-3', ->
      tc.dl ->
        address = property.PropertyID.Address  
        tc.dt "Address"
        tc.dd ->
          tc.address ->
            tc.text address.Address
            tc.br()
            tc.text "#{address.City}, #{address.State}  #{address.PostalCode}"

make_propinfo = tc.renderable (model) ->
  level = if model.active then "success" else "danger"
  tc.div ".propinfo.panel.panel-#{level}", unitid:model.custom.id, ->
    name = model.property.Floorplan.Name
    tc.div ".panel-heading.panel-#{level}", name
    files = model.property.Floorplan.File
    # FIXME find thumbnails
    if files? and false
      console.log "model file", model, files
      if Array.isArray files
        photo = files[0].Src
      else
        photo = files.Src
      tc.img src:photo
    tc.div '.panel-content', ->
      make_rent_rooms_row model
      #tc.p name
      
  

########################################

class SimplePropInfoView extends Backbone.Marionette.View
  ui:
    propinfo: '.propinfo'

  triggers:
    'click @ui.propinfo': 'click:propinfo'

  events:
    'click @ui.propinfo': 'view_property'
    
  view_property: (event) ->
    # FIXME - determine proper target for event
    unitid = event.currentTarget.attributes.unitid.value
    AppChannel.request 'view-property', unitid
    
  template: tc.renderable (model) ->
    #tc.div '.propinfo.listview-list-entry', ->
    level = 'info'
    if not model.active
      level = 'danger'
    make_propinfo model

  onDomRefresh: ->
    @ui.propinfo.css
      cursor: 'pointer'
    
class PropListView extends Backbone.Marionette.CompositeView
  childView: SimplePropInfoView
  template: tc.renderable () ->
    tc.div '#proplist-container.listview-list.col-sm-10.col-sm-offset-1'
  childViewContainer: '#proplist-container'
  ui:
    proplist: '#proplist-container'

module.exports = PropListView
