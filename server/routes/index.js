const express = require('express');
const router = express.Router();

//home
router.get('/', function (req, res, next) {
  res.status(200).json({ ab: 'c' });
  return;
});

router.get('/logout', function (req, res) {
  req.logout();
  res.redirect('/');
});

module.exports = router;
