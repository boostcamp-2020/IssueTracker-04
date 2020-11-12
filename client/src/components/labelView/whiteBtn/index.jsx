import React from 'react';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import './style.scss';

const whiteBtn = ({ addClass, title, link }) => {
  const arr = addClass.map(el => el);
  const classes = `white-btn ${arr.join(' ')}`;
  return (
    <Link className={classes} to={link}>
      {title}
    </Link>
  );
};

export default whiteBtn;
