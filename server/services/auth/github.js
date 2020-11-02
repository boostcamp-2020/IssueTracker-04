const passport = require('passport');
const userModel = require('../../models').user;

exports.gitLoginCheck = (req, res, next) => {
  passport.authenticate('github', { scope: ['user:email'] })(req, res, next);
};

exports.gitLoginCallback = (req, res, next) => {
  passport.authenticate('github', async (err, userGitHub, msg) => {
    if (err) {
      res.status(400).json({ success: false, msg: msg });
    } else {
      let userDB;
      let userNo;
      try {
        userDB = await userModel.findOne({
          where: { user_id: userGitHub.username, oauth_site: 'GITHUB' },
        });
        userNo = userDB.dataValues.user_no;
      } catch (error) {
        res.status(400).json({ success: false, message: "can't find user" });
      }
      if (!userDB) {
        userNo = gitSignup(userGitHub);
      }
      gitLogin(req, userNo);

      res.status(200).json({
        success: true,
        msg: msg,
        user_no: req.user,
      });
    }
  })(req, res, next);
};

const gitSignup = async (user) => {
  console.log('유저', user._json);
  const userData = {
    user_id: user._json.login,
    user_name: user._json.login,
    user_img: user._json.avatar_url,
    oauth_site: 'GITHUB',
  };
  try {
    const result = await userModel.create(userData);
    return result.dataValues.user_no;
  } catch (error) {
    console.log(error);
  }
};

const gitLogin = (req, userNo) => {
  req.login(userNo, (err) => {
    if (err) {
      console.log('세션 등록 실패');
    }
  });
};
