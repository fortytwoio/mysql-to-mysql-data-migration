getToConnection = require('./database').getToConnection
cp = require("child_process")
config = require("./config")
db = config.toDatabase

module.exports = (script, callback) ->
  cmdLine = "mysql --user="+db.user+" --password="+db.password+" "+db.database+" < "+script
  cp.exec cmdLine, (error, stdout, stderr) ->
    return callback error, null if error
    return callback stderr, null if stderr and stderr is not "Warning: Using a password on the command line interface can be insecure."
    return callback null, null
