_ = require 'lodash'
getFromConnection = require('./database').getFromConnection
getToConnection = require('./database').getToConnection
moment = require('moment')

module.exports = (config, callback) ->
  formatObject = config.formatObject
  fromQuery = "SELECT #{config.select} FROM #{config.fromTable}"
  fromQuery += " #{config.join} " if config.join
  fromQuery+= " WHERE #{config.where} " if config.where
  toQuery = "INSERT INTO #{config.toTable} ("
  for i of formatObject
    toQuery += formatObject[i]+","
  toQuery = toQuery.substr(0, toQuery.length - 1)
  toQuery +=") VALUES ?"
  console.log fromQuery
  getFromConnection (fromConnection) ->
    fromConnection.query fromQuery, (error, result) ->
      fromConnection.release()
      console.log result.length
      return callback error, "Select Failed" if error
      data = formatify formatObject, result
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
