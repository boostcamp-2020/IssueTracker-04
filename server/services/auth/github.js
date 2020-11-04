const passport = require('passport');
const userModel = require('../../models').user;

exports.gitLoginCheck = (req, res, next) => {
  req.session.oauthRedirect = req.query.redirect;
  passport.authenticate('github', { scope: ['user:email'] })(req, res, next);
};

exports.gitLoginCallback = (req, res, next) => {
  passport.authenticate('github', async (err, userGitHub, msg) => {
    if (err) {
      // todo: 인증 에러 페이지 띄우기
      return res.status(400).json({ success: false, message: msg });
    } else {
      if (!(await createSession(req, userGitHub))) {
        // todo: 세션 에러 페이지 띄우기
        return res
          .status(400)
          .json({ success: false, message: '세션 생성 실패' });
      }
    }
    next();
  })(req, res, next);
};

exports.gitRedirect = (req, res, next) => {
  res.redirect(req.session.oauthRedirect);
};

const createSession = async (req, userGitHub) => {
  try {
    let userNo = await findUserOne(userGitHub);
    if (!userNo) {
      userNo = await gitSignup(userGitHub);
    }
    if (userNo) return await gitLogin(req, userNo);
    return false;
  } catch (error) {
    console.log(error);
    return false;
  }
};

const findUserOne = async (userGitHub) => {
  try {
    const userDB = await userModel.findOne({
      where: { user_id: userGitHub.username, oauth_site: 'GITHUB' },
    });
    if (userDB) return userDB.dataValues.user_no;
    else return null;
  } catch (error) {
    console.log(error);
    return null;
  }
};

const gitSignup = async (user) => {
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
    return null;
  }
};

const gitLogin = (req, userNo) => {
  return new Promise((resolve) => {
    req.login({ userNo: userNo }, (err) => {
      if (err) {
        console.log('세션 등록 실패');
        resolve(false);
      } else resolve(true);
    });
  });
};
