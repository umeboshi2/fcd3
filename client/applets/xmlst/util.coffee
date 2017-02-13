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

rental_app_link = (id) ->
  "https://availablerentals.managebuilding.com/Resident/apps/rentalapp/?listingId=#{id}"


module.exports =
  get_thumb_src: get_thumb_src
  get_thumb_url: get_thumb_url
  rental_app_link: rental_app_link
  
