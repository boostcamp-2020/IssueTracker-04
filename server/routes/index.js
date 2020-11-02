const express = require('express');
const router = express.Router();

//home
router.get('/', async (req, res, next) => {
  return res.status(200).json({ message: 'welcome home' });
});

module.exports = router;
