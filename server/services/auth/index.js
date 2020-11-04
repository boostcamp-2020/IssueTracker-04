const { statusCode } = require('../../config/statusCode');

exports.isLogged = (req, res, next) => {
  if (!req.user) {
    return res
      .status(statusCode.FORBIDDEN)
      .json({ success: false, message: '로그인 하지 않은 사용자' });
  }
  next();
};

exports.isNotLogged = (req, res, next) => {
  if (req.user) {
    return res
      .status(statusCode.FORBIDDEN)
      .json({ success: false, message: '로그인 된 사용자' });
  }
  next();
};
