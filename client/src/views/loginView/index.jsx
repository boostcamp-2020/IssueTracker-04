import React, { useState, useRef } from 'react';
import './style.scss';

import Input from '../../components/loginView/input';

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
            <span className="gitHubMark">
              <svg
                class="octicon octicon-mark-github v-align-middle"
                height="16"
                viewBox="0 0 16 16"
                version="1.1"
                width="16"
                aria-hidden="true"
              >
                <path
                  fill-rule="evenodd"
                  d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0016 8c0-4.42-3.58-8-8-8z"
                ></path>
              </svg>
            </span>
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
