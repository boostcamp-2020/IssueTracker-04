const passport = require('passport');

exports.gitLoginCheck = (req, res, next) => {
  passport.authenticate('github', { scope: ['user:email'] })(req, res, next);
};

exports.gitLoginCallback = (req, res, next) => {
  passport.authenticate('github', (err, user, msg) => {
    if (err) {
      res.status(400).json({ success: false, msg: msg });
    } else {
      // user_no
      res.status(200).json({ success: true, msg: msg, user_no: 0 });
    }
  })(req, res, next);
};
