import React, { useState, useRef } from 'react';
import './style.scss';

import Input from '../../components/loginView/input'

const loginView = () => {
  const [Id, setId] = useState("")
  const [Password, setPassword] = useState("");

  const onIdHandler = (e) => {
      setId(e.currentTarget.value)
  }

  const onPasswordHandler = (e) => {
      setPassword(e.currentTarget.value)
  }

  const onSubmitHandler = (e) => {
      e.preventDefault();

      console.log(Id)
      console.log(Password)
      let body = {

      }

      /*
      Axios.post('/api/users/login', body).then(response => {

      })
      */
  }

  return (
    <div style={{display: 'flex', justifyContent: 'center', alignItems: 'center', widyh: '100%', height: '100vh'}}>
      <form style={{display:'flex', flexDirection: 'cloumn'}} onSubmit={onSubmitHandler}>
        <label>Id</label>
        <Input placeholder = "id" type="id" value={Id} onChange={onIdHandler}/>
        <label>Password</label>
        <Input placeholder = "password" type="password" value={Password} onChange={onPasswordHandler}/>
        <button type="submit">Login</button>
      </form>
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