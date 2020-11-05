const { statusCode } = require('../../config/statusCode');
const { verifyJWT } = require('../utils/jwt');

exports.isAuth = (req, res, next) => {
  const jwt = /Bearer (.*)/.exec(req.headers.authorization)[1];
  const decoded = verifyJWT(jwt);
  if (!decoded) {
    return res
      .status(statusCode.FORBIDDEN)
      .json({ success: false, message: '로그인 하지 않은 사용자' });
  }
  res.locals.userNo = decoded.userNo;
  next();
};
