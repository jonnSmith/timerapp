const express = require('express');
const router = express.Router();

router.post('', (req, res) => {
    res.status(200).json({
        user: req.body
    });
}, (err) => {
    res.status(500).json(err);
});

router.get('/user', (req, res) => {
    res.status(200).json({
        user: {email: 'test@test.com', password: '123456'}
    });
}, (err) => {
    res.status(500).json(err);
});

module.exports = router;
