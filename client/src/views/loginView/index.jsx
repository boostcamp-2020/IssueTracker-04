import React, { useState, useRef } from 'react';
import './style.scss';
import imgSrc from '@assets/svg/github-icon.svg';
import Input from '@components/loginView/input';
import axios from 'axios';

const urlForGitHubOAuth = '/api/auth/github/';
const clientUrl = 'http://localhost:3000/issues-list';

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
          <a className="gitHubLogin" href={urlForGitHubOAuth + '?redirect=' + clientUrl}>
            Sign with GitHub
            <img className="gitHubMark" src={imgSrc} />
          </a>
        </div>
      </div>
    </div>
  );
};

export default loginView;
