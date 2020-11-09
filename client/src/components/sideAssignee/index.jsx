import React, { useState, useRef } from 'react';
import './style.scss';

const assignees = () => {

  return (
    <div className="create-register">
      <summary>
        Assignees
      </summary>
      <div>
        <span>No one—</span>
        <button className="assign-button">assign yourself</button>
      </div>
    </div>
  );
};

export default assignees;
