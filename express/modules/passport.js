const passport    = require('passport');
const passportJWT = require("passport-jwt");
const ExtractJWT = passportJWT.ExtractJwt;
const LocalStrategy = require('passport-local').Strategy;
const JWTStrategy   = passportJWT.Strategy;
const db = require('./fdb');

passport.use(new LocalStrategy({
        usernameField: 'email',
        passwordField: 'password'
    }, (email, password, cb) => checkUser({email, password}).then( user => {
        if (!user) {
            return cb(null, false, {message: 'Incorrect email or password.'});
        }
        return cb(null, user, {
            message: 'Logged In Successfully'
        });
    }).catch(err => cb(err) )
));

passport.use(new JWTStrategy({
        jwtFromRequest: ExtractJWT.fromAuthHeaderAsBearerToken(),
        secretOrKey: 'timerapp-jwt'
    }, (jwtPayload, cb) => getUser(jwtPayload.id)
        .then( user => {
            return cb(null, user);
        })
        .catch(err => {
            return cb(err);
        })

));

checkUser = function({email, password}) {
    return new Promise((res, rej) => {
        db.getItemByField('users/', 'email', email).then((user) => {
            if(user.password === password) {
                console.log('password', password);
                res(user);
            }
            else { rej({error: 'User check error'}); }
            res(user);
        }, (err) => {
            rej(err);
        });
    });
};

getUser = function(token) {
    return new Promise((res, rej) => {
        db.getItemByField('users/', 'token', token).then((user) => {
            res(user);
        }, (err) => {
            rej(err);
        });
    });
};

