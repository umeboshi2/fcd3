Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'
  
Hlpr = require './helpers'


AppChannel = Backbone.Radio.channel 'xmlst'



nopixsrc = "http://foo.bar/thumbs/fd9e3b9bda7f40388982966f0c853be8.png"

make_file_list = (model) ->
  files = model.property.Floorplan.File
  # FIXME find thumbnails
  if not files?
    files = []
  files


make_address = tc.renderable (model) ->
  address = model.property.PropertyID.Address  
  tc.dt "Address"
  tc.dd ->
    Hlpr.make_address address

make_rent = tc.renderable (model) ->
  tc.dt "Rent"
  tc.dd "$#{Hlpr.find_rent model}"
  

make_desc_list = tc.renderable (model) ->
  property = model.property
  tc.dl '.dl-horizontal', ->
    # address
    make_address model
    # rooms
    if property.Floorplan.Room.length
      rooms = Hlpr.find_rooms model
      tc.dt rooms.name
      tc.dd rooms.value
    # area
    area = Hlpr.find_sq_feet model
    if +area
      tc.dt "Area"
      tc.dd "#{Hlpr.find_sq_feet model} sq feet"
    # number units
    tc.dt "Units Availabile"
    tc.dd property.Information.UnitCount
    # deposit
    deposit = property.Floorplan.Deposit.Amount.ValueRange.$.Exact
    if deposit.endsWith '.00'
      deposit = deposit.slice 0, -3
    tc.dt "Deposit"
    tc.dd "$#{deposit}"
    # rent
    make_rent model
    # long description
    tc.dt "Description"
    tc.dd property.Information.LongDescription
    

########################################
class PropertyView extends Backbone.Marionette.View
  ui:
    proplist: '.view-property-list'
    rental_btn: '#rental-app-button'

  events:
    'click @ui.proplist': 'list_properties'
    'click @ui.rental_btn': 'open_rental_application'

  open_rental_application: (event) ->
    appurl = Hlpr.rental_app_link @get_listing_id()
    window.open(appurl, '_blank')

  get_listing_id: ->
    prop = @model.get 'property'
    prop.listing_id
    
  list_properties: ->
    AppChannel.request 'list-properties'
    
  template: tc.renderable (model) ->
    if __DEV__
      window.curprop = model
      #console.log "Current model", model
    tc.div '.col-sm-10.col-sm-offset-1', ->
      tc.div '.row', ->
        tc.div ".view-property-list.col-sm-12.btn.btn-default.btn-justified", ->
          tc.text "Back to list"
      tc.div '.row', ->
        make_desc_list model
      tc.div '#rental-app-button.btn.btn-default', "Apply Now"
      tc.hr()
      tc.div '.row', ->
        flist = make_file_list model
        if not flist.length
          tc.div '.col-xs-3', ->
            tc.div '.thumbnail', ->
              tc.img src:'/assets/images/coming-soon-thumb.png'
              #Hlpr.get_thumb_src nopixsrc
        else
          for f in flist
            src = Hlpr.get_thumb_src f.Src
            tc.div '.col-xs-3', ->
              tc.a '.thumbnail', download:'', href:f.Src, ->
                tc.img src:src
        
        
module.exports = PropertyView
