const express = require('express');
const router = express.Router();

const gitAuth = require('../../services/auth/github');

router.get('/api/auth/github/', gitAuth.gitLoginCheck);

router.get(
  '/api/auth/github/callback',
  gitAuth.gitLoginCallback,
  gitAuth.gitRedirect
);

module.exports = router;
