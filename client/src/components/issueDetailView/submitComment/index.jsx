import React, { useState, useRef } from 'react';
import './style.scss';

const submitComment = ({ onClick }) => {
  return (
    <button className="submit-comment" onClick={onClick}>
      Comment
    </button>
  );
};

export default submitComment;
