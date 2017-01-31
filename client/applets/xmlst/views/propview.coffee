Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Masonry = require 'masonry-layout'
imagesLoaded = require 'imagesloaded'
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
    name = property.Floorplan.Name
    deposit = property.Floorplan.Deposit.Amount.ValueRange.$.Exact
    tc.div ->
      tc.a ".view-property-list", "Back to list"
    tc.table ->
      tc.tr ->
        tc.td "Address"
        tc.td name
      tc.tr ->
        tc.td "Deposit"
        tc.td deposit
      

module.exports = PropertyView
