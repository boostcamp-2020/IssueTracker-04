import React, { useState, useRef } from 'react';
import './style.scss';

const labelRow = ({ title, description, color }) => {
  const style = { backgroundColor: color };
  return (
    <div className="label-row">
      <div className="col-3">
        <a href="#" style={style} className="labelTitle">
          {title}
        </a>
      </div>
      <div className="">{description}</div>
      <div className="col-2">
        <a href="#" className="edit-delete-btn">
          Edit
        </a>
        <a href="#" className="edit-delete-btn">
          Delete
        </a>
      </div>
    </div>
  );
};

export default labelRow;
