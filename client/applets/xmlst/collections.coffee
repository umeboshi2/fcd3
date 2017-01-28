Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
PageableCollection = require 'backbone.paginator'

xml = require 'xml2js-parser'
$ = require 'jquery'


Models = require './models'


MainChannel = Backbone.Radio.channel 'global'
BumblrChannel = Backbone.Radio.channel 'bumblr'

xml_url = 'https://availablerentals.managebuilding.com/Resident/PublicPages/XMLRentals.ashx?listings=all'

if __DEV__
  xml_url = '/assets/XMLRentals.xml'
  

# setup custom parser
# explicitArray only makes arrays when there
# is more than one member
Parser = new xml.Parser
  explicitArray: false
  


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

class ListingsCollection extends Backbone.Collection
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
    
class BlogPosts extends PageableCollection
  mode: 'server'
  full: true
  baseURL: baseURL
  url: () ->
    "#{@baseURL}/blog/#{@base_hostname}/posts/photo?api_key=#{@api_key}"

  fetch: (options) ->
    options || options = {}
    data = (options.data || {})
    current_page = @state.currentPage
    offset = current_page * @state.pageSize
    options.offset = offset
    options.dataType = 'jsonp'
    super options
    
  parse: (response) ->
    total_posts = response.response.total_posts
    @state.totalRecords = total_posts
    super response.response.posts
   state:
    firstPage: 0
    pageSize: 15
    
  queryParams:
    pageSize: 'limit'
    offset: () ->
      @state.currentPage * @state.pageSize
      
module.exports =
  PhotoPostCollection: PhotoPostCollection
