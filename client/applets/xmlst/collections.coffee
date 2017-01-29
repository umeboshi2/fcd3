Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
PageableCollection = require 'backbone.paginator'

qs = require 'qs'
xml = require 'xml2js-parser'
#$ = require 'jquery'


Models = require './models'


MainChannel = Backbone.Radio.channel 'global'
BumblrChannel = Backbone.Radio.channel 'bumblr'

xml_url = 'https://availablerentals.managebuilding.com/Resident/PublicPages/XMLRentals.ashx?listings=all'
# use local file for testing
if __DEV__
  xml_url = '/assets/XMLRentals.xml'
  
# setup custom parser
# explicitArray only makes arrays when there
# is more than one member
Parser = new xml.Parser
  explicitArray: false
  


# MainListingsModel fetches and parses xml list
# and convert to js objects
class MainListingsModel extends Backbone.Model
  url: xml_url

  fetch: (options) ->
    console.log "OPTIONS", options
    super
      dataType: 'text'
        
  parse: (response, options) ->
    #console.log "RESPONSE", response
    console.log "OPTIONS", options
    xmlr = Parser.parseStringSync response
    window.xmlresp = xmlr
    console.log "XMLRESPONSE", xmlr
    xmlr

class PropertyModel extends Backbone.Model

class PropertyCollection extends Backbone.Collection
  model: PropertyModel

class CustomRecord extends Backbone.Model

make_custom_record_object = (obj) ->
  record = obj.Record
  crobj = {}
  crobj.PropertyIDValue = record[0].Value._
  crobj.AvailabilityDate = record[1].Value._
  crobj.ListDate = record[2].Value._
  crobj.DelistDate = record[3].Value._
  crobj.UnitIDValue = record[4].Value._
  return crobj

class CustomRecord extends Backbone.Model
  parse: (obj) ->
    make_custom_record_object obj
    
class CustomRecordCollection extends Backbone.Collection
  model: CustomRecord
  # sort by date
  # http://stackoverflow.com/a/10124236
  # multiply by -1 for reverse order
  comparator: (model) ->
    -1 * new Date(model.get('DelistDate')).getTime()
    
class CombinedProp extends Backbone.Model

class CombinedListing extends Backbone.Collection
  model: CombinedProp
  
make_custom_records = (xmlmodel) ->
  crarray = []
  for cr in xmlmodel.get('PhysicalProperty').CustomRecords
    crobj = make_custom_record_object cr
    crobj.id = crobj.UnitIDValue
    crarray.push new CustomRecord crobj
  return new CustomRecordCollection crarray
  
make_property_models = (xmlmodel) ->
  pp = xmlmodel.get 'PhysicalProperty'
  parray = pp.Property
  #console.log 'parray', parray
  models = []
  model_ids = []
  count = 0
  for prop in parray
    count += 1
    #prop.id = prop.Identification.IDValue
    purl = qs.parse prop.Floorplan.FloorplanAvailabilityURL
    prop.id = purl.unitid
    if prop.id in model_ids
      console.log "Dupe id", count, prop
    model_ids.push prop.id
    model = new PropertyModel prop
    models.push model
  return new PropertyCollection models
  

make_combined_list = (xmlmodel) ->
  pcoll = make_property_models xmlmodel
  crcoll = make_custom_records xmlmodel
  cmbarray = []
  for crmodel in crcoll.models
    pmodel = pcoll.get crmodel.id
    delist = new Date(crmodel.get('DelistDate')).getTime()
    now = new Date().getTime()
    active = (delist - now) > 0
    obj =
      custom: crmodel.attributes
      property: pmodel.attributes
      active: active
    cmbarray.push obj
  #return cmbarray
  return new CombinedListing cmbarray
  
      
module.exports =
  MainListingsModel: MainListingsModel
  PropertyCollection: PropertyCollection
  CustomRecordCollection: CustomRecordCollection
  make_custom_records: make_custom_records
  make_property_models: make_property_models
  CombinedListing: CombinedListing
  make_combined_list: make_combined_list
  
