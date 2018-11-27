const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const db = require('../modules/fdb');
const config = require('../modules/config');
const addRequestId = require('express-request-id')();

router.get('', (req, res) => {
    db.getItemsFromFolder('users/').then((snap) => {
        res.status(201).json(snap);
    }, (err) => {
        res.status(500).json(err);
    });
});

router.post('/create', addRequestId, (req, res) => {
    let user = req.body;
    user.id = req.id;
    user.remember_token = jwt.sign(user, config.jwt.secretOrKey);
    db.setItemInFolder(user, 'users/', user.id).then((snap) => {
        res.status(201).json(snap);
    }, (err) => {
        res.status(500).json(err);
    });
});

module.exports = {router: router};
