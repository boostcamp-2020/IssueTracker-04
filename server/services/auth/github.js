const passport = require('passport');
const userModel = require('../../models').user;

exports.gitLoginCheck = (req, res, next) => {
  passport.authenticate('github', { scope: ['user:email'] })(req, res, next);
};

exports.gitLoginCallback = (req, res, next) => {
  passport.authenticate('github', async (err, userGitHub, msg) => {
    if (err) {
      res.status(400).json({ success: false, message: msg });
    } else {
      let userNo = await findUserOne(userGitHub);

      if (!userNo) {
        userNo = await gitSignup(userGitHub);
      }
      console.log(userNo);
      gitLogin(req, userNo);

      res.status(200).json({
        success: true,
        message: msg,
        user_no: req.user,
      });
    }
  })(req, res, next);
};

const findUserOne = async (userGitHub) => {
  try {
    const userDB = await userModel.findOne({
      where: { user_id: userGitHub.username, oauth_site: 'GITHUB' },
    });
    if (userDB) return userDB.dataValues.user_no;
    else return null;
  } catch (error) {
    console.log("can't find user");
    return null;
  }
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
