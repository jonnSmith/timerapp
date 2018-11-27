const express = require('express');
const router = express.Router();
const path = require('path');
const fs = require('mz/fs');
const config = require('./config');

router.get('/', (req, res) => {
    res.render('index');
}, (err) => {
    res.status(500).json(err);
});

router.get('/views/:template', (req, res) => {
    const template = req.params.template && fs.existsSync(path.join(__dirname, '../..' + config.app.path + '/jade/' + req.params.template + '.jade')) ? req.params.template : null;
    if (template)  {
            try {
                res.render('jade/' + template, config.jade);
            } catch(e) {
                res.status(500).json(e);
            }
    } else {
        res.status(404).json({error: 'Template not found'});
    }
}, (err) => {
    res.status(500).json(err);
});

module.exports = router;
