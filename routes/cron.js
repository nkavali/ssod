var express = require('express');
var router = express.Router();
var dbPool = require('./dbpool');
var db = dbPool.getPool();
var mysql = require('mysql');
var moment = require('moment-timezone');


module.exports = router;