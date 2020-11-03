const express = require('express');
const router = express.Router();
const auth = require('../../services/auth/github');

router.get('/api/auth/github/', auth.gitLoginCheck);

router.get('/api/auth/github/callback', auth.gitLoginCallback);

module.exports = router;
