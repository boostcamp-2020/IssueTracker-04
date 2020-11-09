const express = require('express');
const router = express.Router();
const issue = require('../../services/issue/issue');

router.post('/api/issue/create/', issue.issueCreate);

router.get('/api/issue/list/', issue.issueListGet);

module.exports = router;
