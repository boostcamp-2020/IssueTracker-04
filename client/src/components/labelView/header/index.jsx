import React from 'react';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import './style.scss';

const loginView = () => {
  return (
    <div className="header">
      <Link className="home-link" to="/">
        ISSUES
      </Link>
    </div>
  );
};

export default loginView;
