Backbone = require 'backbone'
xml = require 'xml2js-parser'
$ = require 'jquery'


Parser = new xml.Parser
  explicitArray: false
  
########################################
# Models
########################################
class ListingsModel extends Backbone.Model
  url: 'https://availablerentals.managebuilding.com/Resident/PublicPages/XMLRentals.ashx?listings=all'

  fetch: (options) ->
    console.log "OPTIONS", options
    super
      dataType: 'text'
        
  parse: (response, options) ->
    console.log "RESPONSE", response
    console.log "OPTIONS", options
    #xmlr = $.parseXML response
    xmlr = Parser.parseStringSync response
    window.xmlresp = xmlr
    console.log "XMLRESPONSE", xmlr
    xmlr
    
    
module.exports =
  ListingsModel: ListingsModel
  
