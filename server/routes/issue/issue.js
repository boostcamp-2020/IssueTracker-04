const express = require('express');
const router = express.Router();
const issue = require('../../services/issue/issue');

router.post('/api/issue/create/', issue.issueCreate);

module.exports = router;
