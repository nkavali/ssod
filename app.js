var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var session = require('client-sessions');
var config = require('./config.json');
var router = express.Router();

var app = express();
// node app.js <env_name> or pm2 start app.js -x -- <env_name>
// For Development, from root folder use "node app.js" or "pm2 start app.js" if pm2 installed.
var args = process.argv;
var env = args.length > 2 ? args[2] : config.env;

app.locals.env = env;
app.locals.appname = config.app_name;
app.locals.fileUploadLocation = config[env]['upload_folder'];
app.locals.server_port = config[env]['port'];

global.app_name = config.app_name;

console.log('Environment : %s', env.toUpperCase());
/*
----------------------------------------------------------------------------------
|                             AWS SES
----------------------------------------------------------------------------------
*/

//var mailer = require('./routes/mailer');
//mailer.setup(app);

/*
----------------------------------------------------------------------------------
|                             MySQL Connection Pooling
----------------------------------------------------------------------------------
*/
var dbpool = require('./routes/dbpool');
dbpool.initPool(config[env]['db']);

/*
----------------------------------------------------------------------------------
|                             Session Management
----------------------------------------------------------------------------------
*/

app.use(session({
    cookieName: 'session',
    secret: 'goalpost-session-1000',
    duration: 30 * 60 * 1000,
    activeDuration: 30 * 60 * 1000,
}));

/*
----------------------------------------------------------------------------------
|                             App Cache
----------------------------------------------------------------------------------
*/

//var cache = require('./routes/cache');
//cache.init();

/*
----------------------------------------------------------------------------------
|                             Other Parms
----------------------------------------------------------------------------------
*/

var allowCrossDomain = function(req, res, next) {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Methods', 'GET,POST,OPTIONS');
    res.header('Access-Control-Allow-Headers', 'Content-Type');
    next();
};


// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.engine('html', require('ejs').renderFile);
app.set('view engine', 'html');

// uncomment after placing your favicon in /public
app.use(favicon(path.join(__dirname, 'public', 'assets/img/favicon.png')));

//app.use(allowCrossDomain);
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
    extended: false,
    limit: '100mb'
}));

app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.static(path.join(__dirname, 'tmp')));

app.use(router);
app.use(function(req, res) {
    // Use res.sendfile, as it streams instead of reading the file into memory.
    res.sendfile(__dirname + '/public/index.html');
});

var routes = require('./routes/index');
var auth = require('./routes/auth');
var cron = require('./routes/cron');
var sessionCheck = require('./routes/token');

app.use('/', routes);
app.use('/page', routes);
app.use('/auth', auth);
app.use('/rest/api/v1', auth);
app.use('/rest/api/v1/*', sessionCheck);
app.use('/cron', cron);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
});

/*
---------------------------------------------------------------------------------------
|                                   Error Handlers
---------------------------------------------------------------------------------------
*/

// development error handler : will print stacktrace
// production error handler : no stacktraces leaked to user
app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    var isREST = req.originalUrl.indexOf("/rest/api") != -1;

    if (app.locals.env === 'dev') {
        if (isREST) {
            res.status(500).json({
                status: 'error',
                message: 'An error occured .. Please try again !',
                details: err.message
            });
        } else {
            res.render('error', {
                title: 'Error Page',
                message: err.message,
                error: err
            });
        }
    } else {
        if (isREST) {
            res.status(500).json({
                status: 'error',
                message: 'An error occured .. Please try again !',
                details: err
            });
        } else {
            res.render('error', {
                title: 'Error Page',
                message: 'An error occured .. Please try again !',
                error: {
                    status: 420
                }
            });
        }
    }

});

module.exports = app;

var server = app.listen(config[env]['port'], function() {
    var host = server.address().address;
    host = host == '::' ? 'localhost' : host;
    var port = server.address().port;
    console.log(config['app_name'] + ' listening at http://%s:%s', host, port);
});