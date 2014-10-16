migrate = require './migrate'
config = require './dataConfig'
async = require 'async'
cleanup = require './cleanup'

cleanup (error, result) ->
  console.log error
  console.log result
  if error
    return "error"
  else
    async.timesSeries config.length, ((n, next) ->
      migrate config[n], next
    ), (error, results) ->
      console.log "done-------------------------------"
      console.log error, results