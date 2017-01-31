Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'


#require 'jquery-ui'

AppChannel = Backbone.Radio.channel 'xmlst'

########################################
simple_post_page_view = tc.renderable () ->
  tc.div '.mytoolbar.row', ->
    tc.ul '.pager', ->
      tc.li '.previous', ->
        tc.i '#prev-page-button.fa.fa-arrow-left.btn.btn-default'
      tc.li ->
        tc.i '#slideshow-button.fa.fa-play.btn.btn-default'
      tc.li '.next', ->
        tc.i '#next-page-button.fa.fa-arrow-right.btn.btn-default'
    #icon '#prev-page-button.fa.fa-arrow-left.btn.btn-default.pull-left'
    #icon '#slideshow-button.fa.fa-play.btn.btn-default'
  tc.div '#posts-container.row'

simple_post_view = tc.renderable (post) ->
  tc.div '.listview-list-entry', ->
    #p ->
    # a href:post.post_url, target:'_blank', post.blog_name
    tc.span ->
      #for photo in post.photos
      photo = post.photos[0]
      current_width = 0
      current_size = null
      for size in photo.alt_sizes
        if size.width > current_width and size.width < 250
          current_size = size
          current_width = size.width
      size = current_size 
      tc.a href:post.post_url, target:'_blank', ->
        tc.img src:size.url

########################################
class PropertyView extends Backbone.Marionette.View
  ui:
    proplist: '.view-property-list'

  events:
    'click @ui.proplist': 'list_properties'

  list_properties: ->
    AppChannel.request 'list-properties'
    
  template: tc.renderable (model) ->
    window.curprop = model
    property = model.property
    #name = property.Floorplan.Name
    name = property.PropertyID.MarketingName
    tc.div ->
      tc.button ".view-property-list.btn.btn-default", "Back to list"
    address = property.PropertyID.Address  
    tc.dl '.dl-horizontal', ->
      tc.dt "Address"
      #tc.dd name
      tc.dd ->
            tc.address ->
              tc.text address.Address
              tc.br()
              tc.text "#{address.City}, #{address.State}  #{address.PostalCode}"
      tc.dt "Units Availabile"
      tc.dd property.Information.UnitCount
      tc.dt "Description"
      tc.dd property.Information.LongDescription
      window.RR = property.Floorplan.Room
      if property.Floorplan.Room.length
        # list comprehension (makes Array)
        rooms = (r.Comment for r in property.Floorplan.Room)
        tc.dt "Rooms"
        tc.dd rooms.join ', '
      deposit = property.Floorplan.Deposit.Amount.ValueRange.$.Exact
      tc.dt "Deposit"
      tc.dd "$#{deposit}"
      rent = property.Floorplan.EffectiveRent
      tc.dt "Rent"
      min_rent = rent.$.Min
      max_rent = rent.$.Max
      if min_rent != max_rent
        tc.dd "$#{rent.$.Min} - $#{rent.$.Max}"
      else
        tc.dd "$#{min_rent}"
        
module.exports = PropertyView
