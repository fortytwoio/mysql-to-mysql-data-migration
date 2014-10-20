migrate = require './migrate'
config = require './dataConfig'
async = require 'async'

async.timesSeries config.length, ((n, next) ->
  migrate config[n], next
), (error, results) ->
  if error 
    console.log "---------------ERROR---------------"
    console.log error
  else
    console.log "---------------DONE---------------"
    console.log results
    console.log results.length
