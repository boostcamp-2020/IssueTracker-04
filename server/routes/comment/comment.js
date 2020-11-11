const express = require('express');
const router = express.Router();

const comment = require('../../services/comment/comment');
const { isAuth } = require('../../services/auth/index');

router.get('/api/comment/:issue_no/', isAuth, comment.getCommentList);

router.post('/api/comment/', isAuth, comment.addComment);

router.put('/api/comment/:comment_no', isAuth, comment.updateComment);

router.delete('/api/comment/:comment_no', isAuth, comment.deleteComment);

module.exports = router;
