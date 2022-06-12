const express = require("express");
const router = express.Router();


router.get('/', function (req, res, next) {
    res.render('front/index', { title: 'Guitar' })
})

module.exports = router;