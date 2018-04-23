var mysql = require('mysql');
var elasticsearch = require('elasticsearch');

var db = {};

db.initPool = function(options) {
    options.acquireTimeout = 1200000;
    options.maxIdleTime = 30 * 60 * 1000;
    options.multipleStatements = true;
    options.dateStrings = true;
    db.options = options;
    console.log('Step.1 : DB Pool Initialization ...');
    db.pool = mysql.createPool(options);
};

db.initESClient = function(options) {
    db.es = elasticsearch.Client(options);
};

db.getESClient = function() {
    return db.es;
};

db.getPool = function(env) {
    // If there was a failure during start up
    if (!db.pool) {
        console.log('Step.1-1 : Trying again to initialize db pool ');
        db.pool = mysql.createPool(db.options);
    }
    return db.pool;
};

db.prepareValues = function(r, atts) {
    var _r = [];
    var _c1 = []; // columns
    var _c2 = []; // columns

    for (var i = 0; i < r.length; i++) {

        if (i == 0) {
            for (var j in r[i]) {
                _c1.push(j);
            }

            if (atts) {
                for (var j in atts) {
                    _c2.push(j);
                }
            }
        }

        var _rN = [];
        for (var j = 0; j < _c1.length; j++) {
            _rN.push(r[i][_c1[j]]);
        }

        if (atts) {
            for (var j in atts) {
                _rN.push(atts[j]);
            }
        }
        _r.push(_rN);
    }

    return { columns: _c1.concat(_c2), rows: _r };
};

module.exports = db;