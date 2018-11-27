const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const db = require('../modules/fdb');
const config = require('../modules/config');
const addRequestId = require('express-request-id')();

router.get('', (req, res) => {
    db.getItemsFromFolder('groups/').then((snap) => {
        res.status(201).json(snap);
    }, (err) => {
        res.status(500).json(err);
    });
});

router.post('/create', addRequestId, (req, res) => {
    let group = req.body;
    group.id = req.id;
    db.setItemInFolder(group, 'groups/', group.id).then((snap) => {
        console.log(JSON.parse(snap));
        res.status(201).json(group);
    }, (err) => {
        res.status(500).json(err);
    });
});

module.exports = {router: router};
