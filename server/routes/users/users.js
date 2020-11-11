const express = require('express');
const router = express.Router();

const userModel = require('../../models').user;
const auth = require('../../services/auth');

// 로컬 회원가입
router.post('/api/users/signup', async (req, res, next) => {
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

// 조회
router.get('/api/user', auth.isAuth, async (req, res, next) => {
  const userNo = res.locals.userNo;
  try {
    const user = await userModel.findOne({
      where: { user_no: userNo },
      raw: true,
    });
    delete user.user_password;
    res.status(200).json({ success: true, user: user });
  } catch (error) {
    console.log(error);
    res
      .status(400)
      .json({ success: false, message: '사용자 정보를 찾을 수 없음' });
  }
});

router.get('/api/userList', auth.isAuth, async (req, res, next) => {
  try {
    const users = await userModel.findAll({ raw: true });
    users.map((ele) => (ele.user_password = undefined));
    const userList = users;
    return res.status(200).json({ success: true, userList: userList });
  } catch (error) {
    res
      .status(400)
      .json({ success: false, message: '사용자 리스트 조회 실패' });
  }
});

router.get('/api/user/logout', auth.isAuth, (req, res) => {
  // 삭제된 jwt 관리하기
  res.status(200).json({ success: true, message: '로그아웃' });
});

module.exports = router;
