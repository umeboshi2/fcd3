Url = require 'url'

MainChannel = Backbone.Radio.channel 'global'
AppChannel = Backbone.Radio.channel 'xmlst'

########################################

get_thumb_src = (src) ->
  url = Url.parse src
  parts = url.path.split '/'
  filename = parts[parts.length - 1]
  thumb = "/thumbs/#{filename}"

get_thumb_url = (model) ->
  src = AppChannel.request 'get-main-photo', model
  get_thumb_src src


module.exports =
  get_thumb_src: get_thumb_src
  get_thumb_url: get_thumb_url
  
