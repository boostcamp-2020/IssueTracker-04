const express = require('express');
const router = express.Router();
const issue = require('../../services/issue/issue');
const { isAuth } = require('../../services/auth/index');

router.post('/api/issue/', isAuth, issue.issueCreate);

router.post('/api/issue/create/', isAuth, issue.issueCreateAll);

router.get('/api/issue/list/', isAuth, issue.issueListGet);

router.get('/api/issue/', isAuth, issue.issueGet);

module.exports = router;
