const express = require('express');
const { isLogged } = require('../../services/auth');
const router = express.Router();
const issue = require('../../services/issue/issue');
const auth = require('../../services/auth/index')

router.post('/api/issue/', auth.isLogged, issue.issueCreate);

module.exports = router;
