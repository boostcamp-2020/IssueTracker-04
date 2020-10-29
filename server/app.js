const createError = require('http-errors');
const express = require('express');
const path = require('path');
const cookieParser = require('cookie-parser');
const logger = require('morgan');

const session = require('express-session');
const passport = require('passport');
const GitHubStrategy = require('passport-github2').Strategy;

const indexRouter = require('./routes/index');
const usersRouter = require('./routes/users');

const app = express();

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

// 세션 관련
passport.serializeUser(function (user, done) {
  done(null, user);
});
passport.deserializeUser(function (obj, done) {
  done(null, obj);
});

// .env로 빼야할 부분
const GITHUB_CLIENT_ID = '';
const GITHUB_CLIENT_SECRET = '';

passport.use(
  new GitHubStrategy(
    {
      clientID: GITHUB_CLIENT_ID,
      clientSecret: GITHUB_CLIENT_SECRET,
      callbackURL: 'http://localhost:3000/auth/github/callback',
    },
    function (accessToken, refreshToken, profile, done) {
      console.log(accessToken);
      console.log(profile);
      // User.findOrCreate({ githubId: profile.username }, function (err, user) {
      //   return done(err, user);
      // });
      const err = null;
      const user = profile;
      const info = '인증 성공';
      done(err, user, info);
    }
  )
);

app.use('/', indexRouter);
app.use('/users', usersRouter);

//----------------------------------------------------------------------------------
// router로 빼야하는 부분
// secret을 dotenv로 빼기
app.use(
  session({ secret: 'keyboard cat', resave: false, saveUninitialized: false })
);

app.use(passport.initialize());
app.use(passport.session());

app.get(
  '/auth/github',
  passport.authenticate('github', { scope: ['user:email'] })
);

app.get(
  '/auth/github/callback',
  passport.authenticate('github', { failureRedirect: '/login' }),
  function (req, res) {
    res.redirect('/');
  }
);

app.get('/logout', function (req, res) {
  req.logout();
  res.redirect('/');
});

//----------------------------------------------------------------------------------

app.use(function (req, res, next) {
  next(createError(404));
});

app.use(function (err, req, res, next) {
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  res.status(err.status || 500);
  return;
});

module.exports = app;
