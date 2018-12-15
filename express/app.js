const express = require('express');
const path = require('path');
const logger = require('morgan');
const passport = require('passport');
const bodyParser = require('body-parser');
const http = require('http');
require('./modules/passport');
const config = require('./modules/config');

let api = {};
api.authenticate = require('./api/authenticate').router;
api.users = require('./api/users').router;
api.groups = require('./api/groups').router;
api.time = require('./api/time').router;

const templates = require('./modules/templates');

const app = express();
app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, '../public')));
app.set('views', path.join(__dirname, '../' + config.app.path));
app.set('view engine', 'jade');
app.use(logger('dev'));

app.use('', templates);

// Rest API routes
app.use('/api/authenticate', api.authenticate);
app.use('/api/users', passport.authenticate('jwt', {session: false}), api.users);
app.use('/api/groups', passport.authenticate('jwt', {session: false}), api.groups);
app.use('/api/time', passport.authenticate('jwt', {session: false}), api.time);

module.exports = app;