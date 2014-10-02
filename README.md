mysql-to-mysql-data-migration
=============================

A node.js module that helps you move data from one mysql to another mysql database

### Run:
```javascript
coffee startSeeding.coffee
```

### Configure:

##### dataConfig: 
formatObject ist the mapping of the old column names and the new column names
```javascript
module.exports = 
  facility:
    fromTable: "old_table"
    toTable: "new_table"
    formatObject:
      id: "id"
      username: "name"
```


##### config: 
basic mysql connection object
```javascript
exports.fromDatabase =
	connectionLimit: 20
	host: ""
	user: ""
	password: ""
	database: ""

exports.toDatabase =
	connectionLimit: 20
	host: ""
	user: ""
	password: ""
	database: ""
```

### Status:
Works from a single table to another single table!

### Coming Soon:
* joining tables
* postgres support