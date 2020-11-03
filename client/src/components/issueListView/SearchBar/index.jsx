import React, { useState, useRef } from 'react';
import './style.scss';

const SearchBar = (props) => {
  const {
 placeholder, value, type, onChange, } = props;
  // const [value, setValue] = useState("");

  return (
    <input
      placeholder={placeholder || ''}
      value={value}
      type={type}
      onChange={onChange}
      id = "SearchBar"
    />
  );
};

export default SearchBar;
