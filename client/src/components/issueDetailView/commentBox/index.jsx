import React, { useState, useRef } from 'react';
import './style.scss';

const commentBox = (props) => {
  const {placeholder, value, type, onChange, } = props;

  return (
    <div className="comment-content-form">
      <textarea className="comment-create-content"
        placeholder={placeholder || ''}
        value={value}
        type={type}
        onChange={onChange}
      />
      <div className="comment-create-image">
        <div>Attach files by selecting here</div>
      </div>
    </div>
  );
};

export default commentBox;
