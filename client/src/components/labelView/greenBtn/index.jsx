import React, { useState, useRef } from 'react';
import './style.scss';

const greenBtn = ({ addClass, title }) => {
  const arr = addClass.map(el => el);
  const classes = `green-btn ${  arr.join(' ')}`;
  return <button className={classes}>{title}</button>;
};

export default greenBtn;
