import React, { useState, useRef } from 'react';
import './style.scss';

const whiteBtn = ({ addClass, title }) => {
  const arr = addClass.map(el => el);
  const classes = 'white-btn ' + arr.join(' ');
  return <button className={classes}>{title}</button>;
};

export default whiteBtn;
