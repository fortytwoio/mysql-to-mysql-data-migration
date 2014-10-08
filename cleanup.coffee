getToConnection = require('./database').getToConnection
cp = require("child_process")

module.exports = (callback) ->
  cmdLine = "mysql --user=root --password= eversport < /Users/michaelhettegger/Dropbox/forty-two.io/Eversport/v2/DropAndCreateSchema.sql"
  cp.exec cmdLine, (error, stdout, stderr) ->
    return callback error, null if error
    return callback stderr, null if stderr and stderr is not "Warning: Using a password on the command line interface can be insecure."
    return callback null, null
