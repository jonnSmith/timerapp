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
            let item =  Object.assign({}, user);
            item.token = token;
            db.updateItemById('users/', item.id, item).then(_ => {
                return res.status(200).json({user, token});
            }, (err) => {
                return res.status(400).send(err);
            });
        });
    })
    (req, res);
});

router.get('/user', passport.authenticate('jwt', {session: false}), (req, res) => {
   res.status(200).json(req.user);
});

module.exports = {router: router};
