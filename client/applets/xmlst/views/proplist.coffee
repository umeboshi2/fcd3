Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Masonry = require 'masonry-layout'
tc = require 'teacup'

#require 'jquery-ui'

{ navigate_to_url } = require 'agate/src/apputil'

BumblrChannel = Backbone.Radio.channel 'bumblr'

########################################
blog_dialog_view = tc.renderable (blog) ->
  tc.div '.modal-header', ->
    tc.h2 'This is a modal!'
  tc.div '.modal-body', ->
    tc.p 'here is some content'
  tc.div '.modal-footer', ->
    tc.button '#modal-cancel-button.btn', 'cancel'
    tc.button '#modal-ok-button.btn.btn-default', 'Ok'

simple_blog_info = tc.renderable (blog) ->
  tc.div '.blog.listview-list-entry', ->
    tc.a href:'#bumblr/viewblog/' + blog.name, blog.name
    tc.i ".delete-blog-button.fa.fa-close.btn.btn-default.btn-xs",
    blog:blog.name

simple_blog_list = tc.renderable () ->
  tc.div ->
    tc.a '.btn.btn-default', href:'#bumblr/addblog', "Add blog"
    tc.div '#bloglist-container.listview-list'

########################################
class BlogModal extends Backbone.Marionette.View
  template: blog_dialog_view

class SimplePropInfoView extends Backbone.Marionette.View
  template: tc.renderable (model) ->
    #tc.div '.propinfo.listview-list-entry', ->
    level = 'info'
    if not model.active
      level = 'danger'
    tc.div ".propinfo.alert.alert-#{level}", ->
      name = model.property.Floorplan.Name
      tc.a href:"#xmlst/viewprop/#{model.custom.id}", name
      #console.log model.property.Floorplan.File
      #photo = model.property.Floorplan.File[0].Src
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
