var express = require('express');
var router = express.Router();
var http = require('http');
var dbPool = require('./dbpool');
var db = dbPool.getPool();
var ES = dbPool.getESClient();
var mysql = require('mysql');
var elasticsearch = require('elasticsearch');
var moment = require('moment-timezone');

router.post('/login', function(req, res, next) {
    var b = req.body;
    console.log(JSON.stringify(b, null, 4));
    var data = { 'email': b.email, 'password': b.password };

    hasISiteWatchAccount(req, res, function(p) {
        console.log(p);
        if (p.length > 0) {
            req.session.user = p[0];
            res.render('./' + p[0]['role'] + '/home', { title: global.app_name, user: req.session.user });
        } else {
            res.render('login', { title: global.app_name, message: "Invalid Credentials !" });
        }
    });
});

router.get('/logout', function(req, res, next) {
    req.session.destroy();
    res.render('index', { title: global.app_name });
});

function hasISiteWatchAccount(req, res, cb) {
    var b = req.body;
    var data = { 'email': b.email, 'password': b.password };

    //DB call
    if (data.email == 'supervisor@isitewatch.com' && data.password == 'password') {
        cb([{ "id": "1000", "first_name": "Supervisor", "last_name": "iSiteWatch", "role": "supervisor" }]);
    } else {
        cb([]);
    }
}

module.exports = router;