os = require 'os'
path = require 'path'
http = require 'http'

express = require 'express'
gzipStatic = require 'connect-gzip-static'
favicon = require 'serve-favicon'

#passport = require 'passport'

Middleware = require './middleware'
#UserAuth = require './userauth'
pages = require './pages'

webpackManifest = require '../build/manifest.json'

# Set the default environment to be `development`
process.env.NODE_ENV = process.env.NODE_ENV || 'development'

UseMiddleware = false or process.env.__DEV_MIDDLEWARE__ is 'true'
PORT = process.env.NODE_PORT or 8081
HOST = process.env.NODE_IP or 'localhost'

# create express app 
app = express()
app.use favicon path.join __dirname, '../assets/favicon.ico'



run_server = () ->

  Middleware.setup app
  
  
  # health url required for openshift
  app.get '/health', (req, res, next) ->
    res.end()

  app.use '/assets', express.static(path.join __dirname, '../assets')
  if UseMiddleware
    #require 'coffee-script/register'
    webpack = require 'webpack'
    middleware = require 'webpack-dev-middleware'
    config = require '../webpack.config'
    compiler = webpack config
    app.use middleware compiler,
      #publicPath: config.output.publicPath
      # FIXME using abosule path?
      publicPath: '/build/'
      stats:
        colors: true
    console.log "Using webpack middleware"
  else
    app.use '/build', gzipStatic(path.join __dirname, '../build')

  app.get '/', pages.make_page 'index'

  server = http.createServer app
  server.listen PORT, HOST, -> 
    console.log "Infidel server running on #{HOST}:#{PORT}."


run_server()
  
module.exports =
  app: app
  
