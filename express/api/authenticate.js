const express = require('express');
const router = express.Router();
const passport = require('passport');
const jwt = require('jsonwebtoken');
const db = require('../modules/fdb');
const config = require('../modules/config');

router.post('/', (req, res, next) => {
    passport.authenticate('local', {session: false}, (err, user, info) => {
        if (err || !user) {
            return res.status(400).json({
                message: info ? info.message : 'Login failed',
                user   : user
            });
        }
        req.login(user, {session: false}, (err) => {
            if (err) {
                res.send(err);
            }
            const token = jwt.sign(user, config.jwt.secretOrKey);
            return db.updateItemFieldByKey('users/', 'email', user.email, 'token', token).then( _ => {
                return res.json({user, token});
            });
        });
    })
    (req, res);
});

router.get('/user/:email', passport.authenticate('jwt', {session: false}), (req, res) => {
    const email = req.params.email;
    db.getItemByField('users/', 'email', email).then((user) => {
        res(user);
    }, (err) => {
        rej(err);
    });
}, (err) => {
    res.status(500).json(err);
});

module.exports = {router: router};
