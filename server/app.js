const createError = require('http-errors');
const express = require('express');
const path = require('path');
const cookieParser = require('cookie-parser');
const logger = require('morgan');
const cors = require('cors');
const hpp = require('hpp');
const helmet = require('helmet');

const session = require('express-session');
const passport = require('passport');
const passportConfig = require('./config/passport');
const models = require('./models');

const indexRouter = require('./routes/index');
const usersRouter = require('./routes/users/users');
const authRouter = require('./routes/auth/github');
const issueRouter = require('./routes/issue/issue');
const labelRouter = require('./routes/label/label');
const milestoneRouter = require('./routes/milestone/milestone');
const commentRouter = require('./routes/comment/comment');

const app = express();

app.use(cors({ origin: true, credentials: true }));
app.use(hpp());
app.use(helmet());
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

// 세션 저장 불러오기
passport.serializeUser(function (user, done) {
  done(null, user);
});
passport.deserializeUser(function (user, done) {
  done(null, user);
});

app.use(
  session({
    resave: false, // 매번 세션 강제 저장
    saveUninitialized: false, // 빈 값도 저장
    secret: process.env.SESSION_SECRET, // cookie 암호화 키. dotenv 라이브러리로 감춤
    cookie: {
      httpOnly: true, // javascript로 cookie에 접근하지 못하게 하는 옵션
      secure: false, // https 프로토콜만 허락하는 지 여부
    },
  })
);

// 세션 초기화
app.use(passport.initialize());
app.use(passport.session());
passportConfig();

models.sequelize
  .sync({ logging: false })
  .then(() => {
    console.log('DB 연결 성공');
  })
  .catch((err) => {
    console.log(err);
    console.log('DB연결 실패');
    process.exit();
  });

app.use(indexRouter);
app.use(authRouter);
app.use(usersRouter);
app.use(issueRouter);
app.use(labelRouter);
app.use(milestoneRouter);
app.use(commentRouter);

app.use(function (req, res, next) {
  next(createError(404));
});

app.use(function (err, req, res, next) {
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'developent' ? err : {};

  res.status(err.status || 500);
  return;
});

module.exports = app;
