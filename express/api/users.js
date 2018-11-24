const express = require('express');
const router = express.Router();

router.get('', (req, res) => {
    res.status(200).json([{email: 'test@test.com', password: '123456'}]);
}, (err) => {
    res.status(500).json(err);
});

module.exports = router;
