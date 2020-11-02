const express = require('express');
const router = express.Router();

const userModel = require('../../models').user;

router.post('/api/users/signup', async (req, res, next) => {
  // const { id, pw, name} = req.query;

  // 패스워드 암호화: bcrypt
  const userData = {
    user_id: 'test2',
    user_password: '1234',
    oauth_site: 'GITHUB',
    user_img: 'http://',
    user_name: '테스트 사용자',
  };

  try {
    const result = await userModel.create(userData);
    res.status(201).json({ success: true, user_no: result.dataValues.user_no });
  } catch (error) {
    console.log(error);
    res.status(201).json({ success: false, message: "Can't create user" });
  }
});

// 삭제
// 하드코딩 하지 말고 파라미터로 받기
router.delete('/api/users/signup', async (req, res, next) => {
  // const userNo = req.params.userNo;
  try {
    const result = await userModel.destroy({ where: { user_no: 5 } });
    res.status(200).json({ success: true, user_no: result.dataValues.user_no });
  } catch (error) {
    console.log(error);
    res.status(201).json({ success: false, message: "Can't delete user" });
  }
});

// 조회, API 이름 바꿀 것
router.get('/api/users/user:userNo', async (req, res, next) => {
  const userNo = req.params.userNo;
  try {
    const result = await userModel.findOne({ where: { user_no: userNo } });
    res.status(201).json({ success: true, user: result.dataValues });
  } catch (error) {
    console.log(error);
    res.status(201).json({ success: false, message: "Can't read user" });
  }
});

router.get('/api/users/logout', function (req, res) {
  req.logout();
  res.redirect('/');
});

module.exports = router;
