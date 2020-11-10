const express = require('express');
const router = express.Router();
const issue = require('../../services/issue/issue');
const { isAuth } = require('../../services/auth/index');

router.post('/api/issue/create/', issue.issueCreate);

router.get('/api/issue/list/', isAuth, issue.issueListGet);

module.exports = router;
