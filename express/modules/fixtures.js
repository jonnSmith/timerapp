const express = require('express');
const router = express.Router();
const db = require('./fdb');
const config = require('./config');

router.get('', (req, res) => {
    const data = config.fixtures;
    db.setItemInFolder(data.group, 'groups/', data.group.id).then(_ => {
        db.setItemInFolder(data.user, 'users/', data.user.id).then(_ => {
            res.status(201).json({message: 'Fixtures inserted'});
        }, (err) => {
            res.status(500).json(err);
        });
    }, (err) => {
        res.status(500).json(err);
    });
});

module.exports = {router: router};