_ = require 'lodash'
getFromConnection = require('./database').getFromConnection
getToConnection = require('./database').getToConnection
moment = require('moment')

buildFromQuery = (config) ->
  fromQuery = "SELECT #{config.select} FROM #{config.fromTable}"
  fromQuery += " #{config.join} " if config.join
  fromQuery+= " WHERE #{config.where} " if config.where


module.exports = (config, callback) ->
  fromQuery = buildFromQuery config unless config.query
  fromQuery = config.query if config.query
  formatObject = config.formatObject
  toQuery = "INSERT INTO #{config.toTable} ("
  for i of formatObject
    toQuery += formatObject[i]+","
  toQuery = toQuery.substr(0, toQuery.length - 1)
  toQuery +=") VALUES ?"
  console.log fromQuery if config.log
  getFromConnection (fromConnection) ->
    fromConnection.query fromQuery, (error, result) ->
      fromConnection.release()
      return callback error, "Select Failed" if error
      console.log result.length if config.log
      data = formatify formatObject, result
      console.log data if config.log
      getToConnection (toConnection) ->
        toConnection.query toQuery, [data], (error, result) ->
          toConnection.release()
          return callback error, "Insert Failed" if error
          callback null, "Success"

formatify = (formatObject, data) ->
	result = []
	for i of data
		row = []
		for j of formatObject
			row.push data[i][j]
		result.push row
	return result
