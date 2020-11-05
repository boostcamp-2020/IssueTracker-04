const passport = require('passport');
const userModel = require('../../models').user;
const axios = require('axios');

const findUserOne = async (userGitHub) => {
  console.log(userGitHub);
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

exports.gitIosLogin = async (req, res, next) => {
  const accessToken = req.body.accessToken;

  const { data } = await axios.get('https://api.github.com/user', {
    headers: {
      Authorization: `token ${accessToken}`,
    },
  });
  let userNo = await findUserOne(data);
  if (!userNo) {
    userNo = await gitSignup(data);
  }
  //jwt 생성
  return res.status(200).json({ jwt: 'asdasd', userNo: userNo });
};
