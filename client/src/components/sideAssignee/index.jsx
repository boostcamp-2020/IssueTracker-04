import React, { useState, useRef } from 'react';
import './style.scss';
import Dropdown from '../dropDown'

const assignees = (props) => {

  return (
    <div className="create-register">
      <Dropdown title="Assignees" items={props.items} />
      <div>
        <span>No one—</span>
        <button className="assign-button">assign yourself</button>
      </div>
    </div>
  );
};

export default assignees;
