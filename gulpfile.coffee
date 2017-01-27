# inspired by https://github.com/KyleAMathews/coffee-react-quickstart
# 
fs = require 'fs'

gulp = require 'gulp'
gutil = require 'gulp-util'
size = require 'gulp-size'
compass = require 'gulp-compass'
nodemon = require 'gulp-nodemon'
sourcemaps = require 'gulp-sourcemaps'

coffee = require 'gulp-coffee'
#runSequence = require 'run-sequence'
#concat = require 'gulp-concat'
#uglify = require 'gulp-uglify'

webpack = require 'webpack'
tc = require 'teacup'

gulp.task 'compass', () ->
  gulp.src('./sass/*.scss')
  .pipe compass
    config_file: './config.rb'
    css: 'assets/stylesheets'
    sass: 'sass'
  .pipe size()
  .pipe gulp.dest 'assets/stylesheets'


gulp.task 'coffee', () ->
  gulp.src('./src/**/*.coffee')
  .pipe sourcemaps.init()
  .pipe coffee
    bare: true
  .pipe sourcemaps.write()
  .on 'error', gutil.log
  .pipe size
    showFiles: true
  .pipe gulp.dest './js'


#gulp.task 'serve', ['coffee', 'ghost-config'], (callback) ->
gulp.task 'serve', (callback) ->
  process.env.__DEV_MIDDLEWARE__ = 'true'
  #gulp.watch './ghost-config.coffee', ->
  #  gulp.start 'ghost-config'
  nodemon
    script: 'server.js'
    ext: 'js coffee'
    watch: [
      'src'
      'webpack-config'
      'webpack.config.coffee'
      ]
  
gulp.task 'serve:prod', (callback) ->
  process.env.__DEV_MIDDLEWARE__ = 'false'
  gulp.watch './ghost-config.coffee', ->
    gulp.start 'ghost-config'
  nodemon
    script: 'server.js'
    ext: 'js coffee'
    watch: [
      'src/'
      'webpack-config/'
      'webpack.config.coffee'
      ]
  
gulp.task 'webpack:build-prod', (callback) ->
  # run webpack
  process.env.PRODUCTION_BUILD = 'true'
  ProdConfig = require './webpack.config'
  prodCompiler = webpack ProdConfig
  prodCompiler.run (err, stats) ->
    throw new gutil.PluginError('webpack:build-prod', err) if err
    gutil.log "[webpack:build-prod]", stats.toString(colors: true)
    callback()
    return
  return

gulp.task 'default', ->
  gulp.start 'serve'
  
gulp.task 'production', ->
  gulp.start 'compass'
  gulp.start 'webpack:build-prod'
