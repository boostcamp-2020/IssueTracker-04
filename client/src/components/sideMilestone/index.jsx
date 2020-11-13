import React, { useState, useRef } from 'react';
import './style.scss';
import Dropdown from "../issueCreateView/dropDownMilestone"

const milestones = (props) => {
  const isEmpty = (arr) => {
    return arr.length!==0
  }

  return (
    <div className="create-register">
      <Dropdown title="Milestone" milestones={props.milestones}/>
      <div>
        {isEmpty(props.now)
          ?
          (
            <div>
            {props.now.map(milestone => (
              <div key={milestone.milestone_no}>
                <span>
                  {milestone.milestone_title}
                </span>  
              </div>
            ))}
            </div>
          )
          :
          (
            <div>
            <span>No Milestone</span>
            </div>
          )
        }
      </div>
    </div>
  );
};

export default milestones;
