Url = require 'url'
tc = require 'teacup'

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

make_address = tc.renderable (address) ->
  tc.address ->
    tc.text address.Address
    tc.br()
    tc.text "#{address.City}, #{address.State}  #{address.PostalCode}"

make_simple_dl = tc.renderable (dt, dd) ->
  if dt == "Address"
    console.log "Address is", dd
  tc.dl ->
    tc.dt dt
    tc.dd dd

find_rent = (model) ->
  property = model.property
  rent = property.Floorplan.EffectiveRent
  r = rent.$.Max
  if rent.$.Min != rent.$.Max
    r = rent.$.Min - rent.$.Max
  return r


find_rooms = (model) ->
  # list comprehension (makes Array)
  rooms = (r.Comment for r in model.property.Floorplan.Room)
  if rooms[0] or rooms[1]
    value = rooms.join ', '
    name = "Bed/Bath"
  else
    name = "Office"
    value = "#{rooms.length} rooms"
  return {name: name, value: value}

find_sq_feet = (model) ->
  s = model.property.Floorplan.SquareFeet.$
  area = s.Max
  if s.Max != s.Min
    area = "#{s.Min}-#{s.Max}"
  return area
  
module.exports =
  get_thumb_src: get_thumb_src
  get_thumb_url: get_thumb_url
  rental_app_link: rental_app_link
  make_address: make_address
  make_simple_dl: make_simple_dl
  find_rent: find_rent
  find_rooms: find_rooms
  find_sq_feet: find_sq_feet
  
