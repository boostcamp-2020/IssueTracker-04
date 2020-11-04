import React, { useState, useRef } from 'react';
import './style.scss';

const content = (props) => {
  const {placeholder, value, type, onChange, } = props;

  return (
    <div>
      <input className="create-content"
        placeholder={placeholder || ''}
        value={value}
        type={type}
        onChange={onChange}
      />
      <div className="create-image">
        <div>Attach files by selecting here</div>
      </div>
    </div>
  );
};

export default content;
