const express = require('express');
const router = express.Router();
const issue = require('../../services/issue/issue');

router.post('/api/issue/', issue.issueCreate);

module.exports = router;
