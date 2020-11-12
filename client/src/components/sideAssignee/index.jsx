import React, { useState, useEffect } from 'react';
import './style.scss';
import Dropdown from '../issueCreateView/dropDownAssignee'

const assignees = (props) => {
  const isEmpty = (arr) => {
    return arr.length!==0
  }

  return (
    <div className="create-register">
      <Dropdown title="Assignees" users={props.users}/>
      <div>
        {isEmpty(props.now)
          ?
          (
            <div>
            {props.now.map(user => (
              <div key={user.user_no}>
                <span>
                  {user.user_name}
                </span>  
              </div>
            ))}
            </div>
          )
          :
          (
            <div>
            <span>No one-</span>
            <button className="assign-button">assign yourself</button>
            </div>
          )
        }
      </div>
    </div>
  );
};

export default assignees;
