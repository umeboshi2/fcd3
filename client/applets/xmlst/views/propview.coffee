Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'
  
{ get_thumb_src } = require '../util'


AppChannel = Backbone.Radio.channel 'xmlst'

make_file_list = (model) ->
  files = model.property.Floorplan.File
  # FIXME find thumbnails
  photo = undefined
  if files?
    #console.log "model file", model, files
    if Array.isArray files
      photo = files[0].Src
    else
      console.log "NOT ARRAY", model
      photo = files.Src
  files


make_address = tc.renderable (model) ->
  address = model.property.PropertyID.Address  
  tc.dt "Address"
  tc.dd ->
    tc.address ->
      tc.text address.Address
      tc.br()
      tc.text "#{address.City}, #{address.State}  #{address.PostalCode}"
  

make_rent = tc.renderable (model) ->
  rent = model.property.Floorplan.EffectiveRent
  tc.dt "Rent"
  min_rent = rent.$.Min
  max_rent = rent.$.Max
  if min_rent != max_rent
    tc.dd "$#{rent.$.Min} - $#{rent.$.Max}"
  else
    tc.dd "$#{min_rent}"
  

make_desc_list = tc.renderable (model) ->
  property = model.property
  tc.dl '.dl-horizontal', ->
    make_address model
    if property.Floorplan.Room.length
      # list comprehension (makes Array)
      rooms = (r.Comment for r in property.Floorplan.Room)
      tc.dt "Rooms"
      tc.dd rooms.join ', '
    tc.dt "Units Availabile"
    tc.dd property.Information.UnitCount
    deposit = property.Floorplan.Deposit.Amount.ValueRange.$.Exact
    tc.dt "Deposit"
    tc.dd "$#{deposit}"
    make_rent model
    tc.dt "Description"
    tc.dd property.Information.LongDescription
    

########################################
class PropertyView extends Backbone.Marionette.View
  ui:
    proplist: '.view-property-list'

  events:
    'click @ui.proplist': 'list_properties'

  list_properties: ->
    AppChannel.request 'list-properties'
    
  template: tc.renderable (model) ->
    #window.curprop = model
    #name = property.Floorplan.Name
    #name = property.PropertyID.MarketingName
    #tc.div ->
    #  tc.button ".view-property-list.btn.btn-default", "Back to list"
    tc.div '.col-sm-10.col-sm-offset-1', ->
      tc.div '.row', ->
        tc.div ".view-property-list.col-sm-12.btn.btn-default.btn-justified", ->
          tc.text "Back to list"
      tc.div '.row', ->
        make_desc_list model
      tc.hr()
      tc.div '.row', ->
        for f in make_file_list model
          src = get_thumb_src f.Src
          tc.div '.col-sm-3', ->
            tc.a '.thumbnail', href:f.Src, ->
              tc.img src:src
        
        
module.exports = PropertyView
