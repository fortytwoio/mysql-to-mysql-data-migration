_ = require 'lodash'
getFromConnection = require('./database').getFromConnection
getToConnection = require('./database').getToConnection
moment = require('moment')

module.exports = (config, callback) ->
  migrate config, (error, status) ->
    console.log status, error

migrate = (config, callback) ->
  formatObject = config.formatObject
  fromQuery = "SELECT * FROM #{config.fromTable} WHERE nid = 1"
  toQuery = "INSERT INTO #{config.toTable} ("
  for i of formatObject
    toQuery += formatObject[i]+","
  toQuery = toQuery.substr(0, toQuery.length - 1)
  toQuery +=") VALUES ?"
  getFromConnection (fromConnection) ->
    fromConnection.query fromQuery, (error, result) ->
      fromConnection.release()
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
