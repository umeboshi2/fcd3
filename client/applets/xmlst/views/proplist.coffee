Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'

#require 'jquery-ui'

{ navigate_to_url } = require 'agate/src/apputil'

BumblrChannel = Backbone.Radio.channel 'bumblr'
AppChannel = Backbone.Radio.channel 'xmlst'

########################################
modal_dialog_view = tc.renderable (blog) ->
  tc.div '.modal-header', ->
    tc.h2 'This is a modal!'
  tc.div '.modal-body', ->
    tc.p 'here is some content'
  tc.div '.modal-footer', ->
    tc.button '#modal-cancel-button.btn', 'cancel'
    tc.button '#modal-ok-button.btn.btn-default', 'Ok'

########################################
class ModalView extends Backbone.Marionette.View
  template: modal_dialog_view

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
    tc.div ".propinfo.alert.alert-#{level}", unitid:model.custom.id, ->
      name = model.property.Floorplan.Name
      #tc.a href:"#xmlst/viewprop/#{model.custom.id}", name
      tc.span name
      files = model.property.Floorplan.File
      # FIXME find thumbnails
      if files? and false
        console.log "model file", model, files
        if Array.isArray files
          photo = files[0].Src
        else
          photo = files.Src
        tc.img src:photo
      

class PropListView extends Backbone.Marionette.CompositeView
  childView: SimplePropInfoView
  template: tc.renderable () ->
    tc.div '#proplist-container.listview-list'
  childViewContainer: '#proplist-container'
  ui:
    proplist: '#proplist-container'

module.exports = PropListView
