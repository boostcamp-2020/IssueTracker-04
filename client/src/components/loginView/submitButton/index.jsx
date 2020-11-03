import React, { useState, useRef } from 'react';
import './style.scss';

const submitButton = () => {
  const [Id, setId] = useState('');
  const [Password, setPassword] = useState('');

  const onIdHandler = (e) => {
    setId(e.currentTarget.value);
  };

  const onPasswordHandler = (e) => {
    setPassword(e.currentTarget.value);
  };

  const onSubmitHandler = (e) => {
    e.preventDefault();

    console.log(Id);
    console.log(Password);
    const body = {};

    /*
      Axios.post('/api/users/login', body).then(response => {

      })
      */
  };

  return <button type="submit">Login</button>;
};

export default submitButton;
