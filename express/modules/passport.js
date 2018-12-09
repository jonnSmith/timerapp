const passport    = require('passport');
const passportJWT = require("passport-jwt");
const ExtractJWT = passportJWT.ExtractJwt;
const LocalStrategy = require('passport-local').Strategy;
const JWTStrategy   = passportJWT.Strategy;
const bcrypt = require('bcrypt');
const config = require('./config');
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
        secretOrKey   : config.jwt.secretOrKey
    },
    function (jwtPayload, cb) {
        db.getItemById('users/', jwtPayload.id).then((user) => {
            return cb(null, user);
        }, (err) => {
            return cb(null, err);
        });
    }
));

checkUser = function({email, password}) {
    return new Promise((res, rej) => {
        db.getItemByField('users/', 'email', email).then((user) => {
            if(bcrypt.compareSync(password, user.password)) {
                res(user);
            } else {
                rej({error: 'User check error'});
            }
            res(user);
        }, (err) => {
            rej(err);
        });
    });
};
