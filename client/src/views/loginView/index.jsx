import React, { useState, useRef } from 'react';
import './style.scss';
import imgSrc from '@assets/svg/github-icon.svg';
import Input from '@components/loginView/input';

const loginView = () => {
  const [Id, setId] = useState('');
  const [Password, setPassword] = useState('');

  const onIdHandler = e => {
    setId(e.currentTarget.value);
  };

  const onPasswordHandler = e => {
    setPassword(e.currentTarget.value);
  };

  console.log(Id);

  const onSubmitHandler = e => {
    e.preventDefault();

    console.log(Id);
    console.log(Password);
    const body = {};

    /*
      Axios.post('/api/users/login', body).then(response => {

      })
      */
  };

  return (
    <div className="loginLayout">
      <div className="loginContainer">
        <h1>이슈 트래커</h1>
        <div className="loginBox">
          <form onSubmit={onSubmitHandler}>
            <div className="loginLabel">아이디</div>
            <Input placeholder="id" type="id" value={Id} onChange={onIdHandler} />
            <div className="loginLabel">패스워드</div>
            <Input placeholder="password" type="password" value={Password} onChange={onPasswordHandler} />
            <div className="localLogin">
              <button className="localLoginBtn" type="submit">
                로그인
              </button>
              <button className="localLoginBtn" type="submit">
                회원가입
              </button>
            </div>
          </form>
          <a className="gitHubLogin" href="#">
            Sign with GitHub
            <img className="gitHubMark" src={imgSrc} />
          </a>
        </div>
      </div>
    </div>
  );
};

export default loginView;

/*
<div className="loginContainer">
      <h1>이슈 트래커</h1>
      <div className="loginBox">
        <div>
          아이디
          <input id="id" type="text" />
        </div>
        <div>
          비밀번호
          <input id="password" type="password" />
        </div>
        <div>
          <a href="#">로그인</a>
          <a href="#">회원가입</a>
        </div>
        <div>
          <a href="#">GitHub 회원가입</a>
        </div>
      </div>
    </div>
    */
