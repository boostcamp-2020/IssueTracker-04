import React, { useState, useRef } from 'react';
import './style.scss';

const submitButton = ({onClick}) => {
  return (
    <button className="submit-button" onClick={onClick}>
        Submit new issue
    </button>
  );
};

export default submitButton;
