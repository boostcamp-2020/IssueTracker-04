import React, { useState, useRef } from 'react';
import './style.scss';

import image from "../../asset/images/header-imgs.JPG"

const input = () => {
  return (
    <header>
        <img id = 'header-imgs' src = {image} alt="header-imgs" / >
    </header>
  );
};

export default input;
