import React, { useState, useEffect, useRef } from 'react';
import './style.scss';
import imgSrc from '@assets/svg/github-icon.svg';
import Input from '@components/loginView/input';
import axios from 'axios';
import qs from 'qs';

const clientId = 'f9cee2fa1bd2cbe70a42';
const redirectUrl = 'http://www.doldolma.kro.kr';
const urlForCode = `https://github.com/login/oauth/authorize?client_id=${clientId}&redirect_uri=${redirectUrl}`;
const urlForJwt = 'http://101.101.217.9:5000/api/auth/github/code';

const loginView = () => {
  const [id, setId] = useState('');
  const [password, setPassword] = useState('');

  const onIdHandler = e => {
    setId(e.currentTarget.value);
  };

  const onPasswordHandler = e => {
    setPassword(e.currentTarget.value);
  };

  const onSubmitHandler = e => {
    e.preventDefault();
  };

  useEffect(async () => {
    const { code } = qs.parse(location.search, {
      ignoreQueryPrefix: true,
    });

    if (code) {
      const json = await axios.post(urlForJwt, { code });
      localStorage.setItem('jwt', json.data.jwt);
    }
    if (localStorage.getItem('jwt')) {
      location.href = '/issues-list';
    }
  }, []);

  return (
    <div className="loginLayout">
      <div className="loginContainer">
        <h1>이슈 트래커</h1>
        <div className="loginBox">
          <form onSubmit={onSubmitHandler}>
            <div className="loginLabel">아이디</div>
            <Input placeholder="id" type="id" value={id} onChange={onIdHandler} />
            <div className="loginLabel">패스워드</div>
            <Input placeholder="password" type="password" value={password} onChange={onPasswordHandler} />
            <div className="localLogin">
              <button className="localLoginBtn" type="submit">
                로그인
              </button>
              <button className="localLoginBtn" type="submit">
                회원가입
              </button>
            </div>
          </form>
          <a className="gitHubLogin" href={urlForCode}>
            Sign with GitHub
            <img className="gitHubMark" src={imgSrc} />
          </a>
        </div>
      </div>
    </div>
  );
};

export default loginView;
