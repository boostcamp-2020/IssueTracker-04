import React, { useState, useContext } from 'react';
import onClickOutside from 'react-onclickoutside';
import './style.scss';
import { MilestoneContext } from '../../../views/issueCreateView';


function Dropdown(props) {
  const {milestoneState, milestoneDispatch} = useContext(MilestoneContext)
  const {milestones, title} = props
  const [open, setOpen] = useState(false);
  const toggle = () => setOpen(!open);
  Dropdown.handleClickOutside = () => setOpen(false);

  const selectItem = (milestone) => {
    if (milestoneState.some(ele => ele.milestone_no === milestone.milestone_no)){
      const payload = milestoneState.filter(ele => ele.milestone_no !== milestone.milestone_no);
      milestoneDispatch({type: "UPDATE", payload})
    } else {
      milestoneDispatch({type: "UPDATE", payload:[...milestoneState,milestone]})
    }
  }
  
  const checkItem = (milestone) => {
    return milestoneState.some(ele => ele.milestone_no === milestone.milestone_no)
  }

  return (
    <div>
      <div className="dropdown-toggle" 
      tabIndex={0}
      role="button"
      onKeyPress={() => toggle(!open)}
      onClick={() => toggle(!open)}>{title}
      </div>
      <div>
      {open && (
        <div className="dropdown-list">
        {milestones.map(milestone => (
          <div className="dropdown-item" key={milestone.milestone_no}>
          <button className="dropdown-button" type="button" onClick={() => selectItem(milestone)}>
          <span>{checkItem(milestone)&&"✔️"}</span>
          <span>{milestone.milestone_title}</span>
          </button>
          </div>
        ))}
        </div>
      )}
      </div>
    </div>
  );
}

const clickOutsideConfig = {
  handleClickOutside: () => Dropdown.handleClickOutside,
};

export default onClickOutside(Dropdown, clickOutsideConfig);