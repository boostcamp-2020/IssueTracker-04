import React, { useState, useRef } from 'react';
import './style.scss';

const labelRow = ({ labelNo, title, description, color }) => {
  const style = { backgroundColor: color };
  return (
    <div className="label-row" data-labelno={labelNo}>
      <div className="col-3">
        <a href="#" style={style} className="labelTitle">
          {title}
        </a>
      </div>
      <div className="col-7">{description}</div>
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
