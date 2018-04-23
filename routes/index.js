var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
    res.render('index', { title: global.app_name, user: req.session.user });
});

router.get('/:page', function(req, res, next) {
    console.log('> ' + req.path);
    res.render(req.params.page, { title: global.app_name, user: req.session.user });
});

router.get('/supervisor/:page', function(req, res, next) {
    res.render('./supervisor/' + req.params.page, { title: global.app_name, user: req.session.user });
});



module.exports = router;