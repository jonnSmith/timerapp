const express = require('express');
const router = express.Router();
const db = require('../modules/fdb');
const config = require('../modules/config');
const addRequestId = require('express-request-id')();

router.post('/start', addRequestId, (req, res) => {
    let time = req.body;
    console.log(time);
    res.status(201).json(time);
    // time.id = req.id;
    // db.setItemInFolder(time, 'time/', time.id).then((snap) => {
    //     console.log(JSON.parse(snap));
    //     res.status(201).json(group);
    // }, (err) => {
    //     res.status(500).json(err);
    // });
});

router.post('/end', addRequestId, (req, res) => {
    let time = req.body;
    console.log(time);
    res.status(201).json(time);
    // time.id = req.id;
    // db.setItemInFolder(time, 'time/', time.id).then((snap) => {
    //     console.log(JSON.parse(snap));
    //     res.status(201).json(group);
    // }, (err) => {
    //     res.status(500).json(err);
    // });
});

module.exports = {router: router};