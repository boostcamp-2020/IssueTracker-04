const passport = require('passport');
const userModel = require('../../models').user;

exports.gitLoginCheck = (req, res, next) => {
  passport.authenticate('github', { scope: ['user:email'] })(req, res, next);
};

exports.gitLoginCallback = (req, res, next) => {
  passport.authenticate('github', async (err, user, msg) => {
    if (err) {
      res.status(400).json({ success: false, msg: msg });
    } else {
      let userData;
      try {
        userData = await userModel.findOne({
          where: { user_id: user.username, oauth_site: 'GITHUB' },
        });
        // console.log('유저 데이터: ', userData.dataValues.user_no);
        // res.status(201).json({ success: true, user: result.dataValues });
      } catch (error) {
        res.status(400).json({ success: false, message: "can't find user" });
      }
      if (!userData) {
        console.log('회원 가입');
        // gitSignup();
      }
      console.log('세션 추가');
      // gitLogin(); // 세션 추가

      // 1. 공통 DB 조회
      // 2. 선택적 DB추가
      // 3. 공통 세션 등록

      // 세션 등록
      // todo: 데이터 가공을 해서 세션에 추가
      req.login(user, (err) => {
        if (err) {
          console.log('세션 등록 실패');
        }
      });

      res.status(200).json({
        success: true,
        msg: msg,
        user_no: 0,
        session: req.user,
      });
    }
  })(req, res, next);
};

// 함수 작성 시
// function func1(){}
// const func1 = ()=>{} -> 통일

const gitSignup = () => {};

const gitLogin = () => {};
