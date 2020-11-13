const express = require('express');
const router = express.Router();

const gitAuth = require('../../services/auth/github');

// router.get('/api/auth/github/', gitAuth.gitLoginCheck);

// router.get(
//   '/api/auth/github/callback',
//   gitAuth.gitLoginCallback,
//   gitAuth.gitRedirect
// );

// 라우터
router.post('/api/auth/github/code', gitAuth.gitCode, gitAuth.gitIosLogin);

// 라우터 이름 추후 확정하기
router.post('/api/auth/github/ios', gitAuth.gitIosLogin);

module.exports = router;
