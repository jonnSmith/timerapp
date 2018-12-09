const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const db = require('./fdb');
const config = require('./config');

router.get('', (req, res) => {
    const data = config.fixtures;
    db.setItemInFolder(data.group, 'groups/', data.group.id).then(_ => {
        let user = Object.assign({}, data.user);
        user.password = bcrypt.hashSync(user.password, config.bcrypt.rounds);
        console.log('user.password', user.password);
        db.setItemInFolder(user, 'users/', data.user.id).then(_ => {
            let time = Object.assign({}, data.time);
            let now = new Date();
            time.start = now.setHours(now.getHours() - 1);
            time.end = new Date();
            db.setItemInFolder(time, 'time/', time.id).then(_ => {
                res.status(201).json({message: 'Fixtures inserted'});
            }, (err) => {
                res.status(500).json(err);
            });
        }, (err) => {
            res.status(500).json(err);
        });
    }, (err) => {
        res.status(500).json(err);
    });
});

module.exports = {router: router};