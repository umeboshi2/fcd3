$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'
#xml = require 'xml2js'
xml = require 'xml2js-parseonly/src/xml2js'

fs = require 'fs'

Collections = require './client/applets/xmlst/collections'

Parser = new xml.Parser
  explicitArray: false
  async: false

combined_collection = undefined

get_model_objs = (collection) ->
  (m.attributes for m in collection.models)

get_rank_1_src = (model) ->
  files = model.property.Floorplan.File
  if not files?
    return false
  #console.log "Files #{model.id}", files,
  if files?.length
    file_1 = files[0]
  else
    file_1 = files
  #console.log "FILE1", file_1
  if file_1.Rank != '1'
    console.error "Bad Rank", file_1.Rank
  file_1.Src

get_photos = (model) ->
  files = model.property.Floorplan.File
  if not files?
    return false
  photos = []
  #console.log "Files #{model.id}", files,
  if not files?.length
    photos.push files.Src
  else
    for f in files
      photos.push f.Src
  photos

get_rank_1_list = (collection) ->
  models = get_model_objs collection
  ml = []
  for m in models
    src = get_rank_1_src m
    if src
      ml.push src
  ml
  
get_all_pix = (collection) ->
  models = get_model_objs collection
  phlist = []
  for m in models
    photos = get_photos m
    if photos
      phlist = phlist.concat photos
  phlist
  
  
parse_xml = (filename) ->
  buffer = fs.readFileSync filename
  Parser.parseString buffer.toString(), (err, json) =>
    model = new Backbone.Model json
    combined_collection = Collections.make_combined_list model
    fs.writeFileSync 'xmlrentals.json', JSON.stringify json
filename = 'assets/XMLRentals.xml'
parse_xml filename

c = combined_collection

