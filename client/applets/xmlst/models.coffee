Backbone = require 'backbone'
xml = require 'xml2js-parser'
$ = require 'jquery'


xml_url = 'https://availablerentals.managebuilding.com/Resident/PublicPages/XMLRentals.ashx?listings=all'

if __DEV__
  xml_url = '/assets/XMLRentals.xml'
  

# setup custom parser
# explicitArray only makes arrays when there
# is more than one member
Parser = new xml.Parser
  explicitArray: false
  
########################################
# Models
########################################
class ListingsModel extends Backbone.Model
  url: xml_url

  fetch: (options) ->
    #console.log "OPTIONS", options
    super
      dataType: 'text'
        
  parse: (response, options) ->
    #console.log "RESPONSE", response
    #console.log "OPTIONS", options
    xmlr = Parser.parseStringSync response
    window.xmlresp = xmlr
    #console.log "XMLRESPONSE", xmlr
    xmlr
    
    
module.exports =
  ListingsModel: ListingsModel
  
