import React, { useState, useRef } from 'react';
import './style.scss';

const title = (props) => {
  const {placeholder, value, type, onChange, } = props;

  return (
    <input className="create-title" 
      placeholder={placeholder || ''}
      value={value}
      type={type}
      onChange={onChange}
    />
  );
};

export default title;
