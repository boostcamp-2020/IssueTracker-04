const { statusCode } = require('../../config/statusCode');
const { verifyJWT } = require('../utils/jwt');

exports.isAuth = (req, res, next) => {
  try {
    const jwt = /Bearer (.*)/.exec(req.headers.authorization)[1];
    const decoded = verifyJWT(jwt);
    res.locals.userNo = decoded.userNo;
    next();
  } catch (error) {
    return res
      .status(statusCode.FORBIDDEN)
      .json({ success: false, message: '로그인 하지 않은 사용자' });
  }
};
