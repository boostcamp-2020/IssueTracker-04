const passport = require('passport');
const userModel = require('../../models').user;
const axios = require('axios');
const { createJWT } = require('../utils/jwt');
require('dotenv').config('../../config/.env');

const findUserOne = async (userGitHub) => {
  //console.log(userGitHub);
  try {
    const userDB = await userModel.findOne({
      where: { user_id: userGitHub.login, oauth_site: 'GITHUB' },
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
    user_id: user.login,
    user_name: user.login,
    user_img: user.avatar_url,
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

exports.gitCode = async (req, res, next) => {
  let clientID = process.env.GITHUB_CLIENT_ID;
  let clientSecret = process.env.GITHUB_CLIENT_SECRET;
  if (req.body.client === 'ios') {
    clientID = process.env.IOS_GITHUB_CLIENT_ID;
    clientSecret = process.env.IOS_GITHUB_CLIENT_SECRET;
  }
  const json = await axios({
    method: 'post',
    url: `https://github.com/login/oauth/access_token?client_id=${clientID}&client_secret=${clientSecret}&code=${req.body.code}`,
    headers: {
      accept: 'application/json',
    },
  });
  res.locals.accessToken = json.data.access_token;
  next();
};

exports.gitIosLogin = async (req, res, next) => {
  const accessToken = res.locals.accessToken;

  const { data } = await axios.get('https://api.github.com/user', {
    headers: {
      Authorization: `token ${accessToken}`,
    },
  });
  let userNo = await findUserOne(data);
  if (!userNo) {
    userNo = await gitSignup(data);
  }
  const jwt = createJWT({ userNo: userNo });
  return res.status(200).json({ jwt: jwt });
};
