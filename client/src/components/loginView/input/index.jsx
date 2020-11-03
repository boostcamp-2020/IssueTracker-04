import React, { useState, useRef } from 'react';
import './style.scss';

const input = props => {
  const { placeholder, value, type, onChange } = props;
  // const [value, setValue] = useState("");

  return <input className="loginInput" placeholder={placeholder || ''} value={value} type={type} onChange={onChange} />;
};

export default input;
