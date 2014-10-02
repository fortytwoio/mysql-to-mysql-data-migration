mysql = require 'mysql'
config = require './config'
fromPool = mysql.createPool(config.fromDatabase)
toPool = mysql.createPool(config.toDatabase)

getFromConnection = (callback) ->
	fromPool.getConnection (error, connection) ->
		if error
			throw error
		callback(connection)

getToConnection = (callback) ->
	toPool.getConnection (error, connection) ->
		if error
			throw error
		callback(connection)

exports.getFromConnection = getFromConnection
exports.getToConnection = getToConnection