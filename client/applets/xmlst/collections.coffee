Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
PageableCollection = require 'backbone.paginator'

qs = require 'qs'

MainChannel = Backbone.Radio.channel 'global'
AppChannel = Backbone.Radio.channel 'xmlst'

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
    # FIXME split url fails if no "?"
    purl = qs.parse prop.Floorplan.FloorplanAvailabilityURL.split('?')[1]
    prop.id = purl.unitid
    prop.listing_id = purl.listingId
    prop.building_id = purl.buildingid
    if prop.id in model_ids
      console.warn "Dupe id", count, prop
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
    delist_date = new Date(crmodel.get('DelistDate'))
    delist = delist_date.getTime()
    now = new Date().getTime()
    active = (delist - now) > 0
    obj =
      custom: crmodel.attributes
      property: pmodel.attributes
      active: active
      id: crmodel.id
      delist: delist_date
    cmbarray.push obj
  return new CombinedListing cmbarray

get_photo_1_src = (model) ->
  files = model.property.Floorplan.File
  if files?
    if Array.isArray files
      photo = files[0].Src
    else
      photo = files.Src
    return photo
  # "coming soon" png
  "http://foo.bar/thumbs/fd9e3b9bda7f40388982966f0c853be8.png"

AppChannel.reply 'get-main-photo', (model) ->
  get_photo_1_src model
  
         
      
module.exports =
  PropertyCollection: PropertyCollection
  CustomRecordCollection: CustomRecordCollection
  make_custom_records: make_custom_records
  make_property_models: make_property_models
  CombinedListing: CombinedListing
  make_combined_list: make_combined_list
  
