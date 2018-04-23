var express = require('express');
var router = express.Router();
var dbPool = require('./dbpool');
var ES = dbPool.getESClient();
var elasticsearch = require('elasticsearch');
var moment = require('moment-timezone');

router.use(function(req, res, next) {
    hasAccess(req, function(t) {
        if (t.updated > 0) {
            next();
        } else {
            res.status(401).json({ 'message': 'SESSION_EXPIRED' });
        }
    });
});

function hasAccess(req, cb) {
    var b = req.body;
    var data = { 'auth': b.auth };

    var now = moment().tz('Asia/Colombo');
    var time_now = now.format('YYYY-MM-DD H:mm:ss');
    var time_extend = now.add(0.5, 'hours').format('YYYY-MM-DD H:mm:ss');

    //Web Session
    if (req.user.session) {
        cb({ updated: 1 });
        return;
    }

    //App Session
    // Need to check against token table.
    if (b.auth == "abcd") {
        cb({ updated: 2 });
        return;
    }

    cb({ updated: 0 });


}


module.exports = router;