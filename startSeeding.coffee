migrate = require './migrate'
config = require './dataConfig'
async = require 'async'
cleanup = require './cleanup'

async.series [
  (callback) ->
    cleanup callback
  (callback) ->
    migrate config.company, callback
  (callback) ->
    migrate config.facility, callback
  (callback) ->
    migrate config.sport, callback
  (callback) ->
    migrate config.court, callback
  (callback) ->
    migrate config.courtSports, callback
], (error, results) ->
  console.log "done-------------------------------"
  console.log error, results
