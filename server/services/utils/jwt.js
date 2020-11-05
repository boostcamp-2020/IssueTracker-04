const jwt = require('jsonwebtoken');
require('dotenv').config('../../config/.env');

const { JWT_SECRET, JWT_EXPIRE } = process.env;

exports.createJWT = (data) => {
  // default : HMAC SHA256
  // 유효 시간은 JWT_EXPIRE 분
  const token = jwt.sign(data, JWT_SECRET, {
    expiresIn: JWT_EXPIRE * 60,
  });
  return token;
};

exports.verifyJWT = (token) => {
  try {
    return jwt.verify(token, JWT_SECRET);
  } catch (error) {
    return null;
  }
};
