const passport = require('passport');

exports.gitLoginCheck = (req, res, next) => {
  passport.authenticate('github', { scope: ['user:email'] })(req, res, next);
};

exports.gitLoginCallback = (req, res, next) => {
  passport.authenticate('github', (err, user, msg) => {
    if (err) {
      res.status(400).json({ success: false, msg: msg });
    } else {
      // 세션 등록
      // todo: 데이터 가공을 해서 세션에 추가
      req.login(user, (err) => {
        console.log('세션 등록 실패');
      });
      // user_no
      res.status(200).json({
        success: true,
        msg: msg,
        user_no: 0,
        session: req.user,
      });
    }
  })(req, res, next);
};
