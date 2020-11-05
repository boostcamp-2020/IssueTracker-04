const express = require('express');
const router = express.Router();

const auth = require('../services/auth');

//home
router.get('/', auth.isAuth, (req, res, next) => {
  return res
    .status(200)
    .json({ message: 'welcome home', userNo: res.locals.userNo });
});

module.exports = router;
