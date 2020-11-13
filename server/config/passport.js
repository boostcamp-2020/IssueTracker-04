const passport = require('passport');
const GitHubStrategy = require('passport-github2').Strategy;

require('dotenv').config({ path: './config/.env' });

module.exports = () => {
  passport.use(
    new GitHubStrategy(
      {
        clientID: process.env.GITHUB_CLIENT_ID,
        clientSecret: process.env.GITHUB_CLIENT_SECRET,
        callbackURL: process.env.GITHUB_CALLBACK_URL,
      },
      function (accessToken, refreshToken, profile, done) {
        let err, user, msg;

        if (accessToken) {
          err = false;
          user = profile;
          msg = 'accessToken 발급 완료';
        } else {
          err = true;
          user = null;
          msg = 'accessToken 발급 실패';
        }
        done(err, user, msg);

        // todo:
        // if 유저정보
        // DB 정보 접근 -> 찾아서 return done(err, user);
        // if not 유저정보
        // 회원 등록 및 return done(err, user)
      }
    )
  );
};
