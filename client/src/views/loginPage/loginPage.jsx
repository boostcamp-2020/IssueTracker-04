import React, { useState, useRef } from 'react';
import './loginPage.scss';

const loginPage = () => {
  return (
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
  );
};

export default loginPage;
