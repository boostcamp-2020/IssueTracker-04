import React, { useState, useEffect } from 'react';
import './style.scss';
import Dropdown from '../dropDown'

const assignees = (props) => {
  const [Member, setMember] = useState([]);
  useEffect(() => {
    console.log(Member)
    return () => {
      console.log("???");
    };
  }, [Member]);

  return (
    <div className="create-register">
      <Dropdown title="Assignees" items={props.items} member={Member} setmember={setMember}/>
      <div>
        <span>{Member}No one—</span>
        <button className="assign-button">assign yourself</button>
      </div>
    </div>
  );
};

export default assignees;
