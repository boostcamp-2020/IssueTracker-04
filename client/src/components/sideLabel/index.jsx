import React, { useState, useRef } from 'react';
import './style.scss';
import Dropdown from "../issueCreateView/dropDownLabel"

const labels = (props) => {
  const isEmpty = (arr) => {
    return arr.length!==0
  }

  return (
    <div className="create-register">
      <Dropdown title="Labels" labels={props.labels}/>
      <div>
        {isEmpty(props.now)
          ?
          (
            <div>
            {props.now.map(label => (
              <div key={label.label_no}>
                <span>
                  {label.label_title}
                </span>  
              </div>
            ))}
            </div>
          )
          :
          (
            <div>
            <span>None yet</span>
            </div>
          )
        }
      </div>
    </div>
  );
};
export default labels;
