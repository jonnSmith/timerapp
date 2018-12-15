const express = require('express');
const path = require('path');
const logger = require('morgan');
const passport = require('passport');
const bodyParser = require('body-parser');
const http = require('http');
require('./express/modules/passport');
const config = require('./express/modules/config');

let api = {};
api.authenticate = require('./express/api/authenticate').router;
api.users = require('./express/api/users').router;
api.groups = require('./express/api/groups').router;
api.time = require('./express/api/time').router;

const templates = require('./express/modules/templates');

const app = express();
app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, 'public')));
app.set('views', __dirname + config.app.path);
app.set('view engine', 'jade');
app.use(logger('dev'));

app.use('', templates);

// Rest API routes
app.use('/api/authenticate', api.authenticate);
app.use('/api/users', passport.authenticate('jwt', {session: false}), api.users);
app.use('/api/groups', passport.authenticate('jwt', {session: false}), api.groups);
app.use('/api/time', passport.authenticate('jwt', {session: false}), api.time);

// Init textures
const fixtures = require('./express/modules/fixtures').router;
app.use('/fixtures', fixtures);
app.set('port', config.app.port);
const server = http.createServer(app);
server.listen(config.app.port);
