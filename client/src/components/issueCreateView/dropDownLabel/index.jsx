import React, { useState, useContext } from 'react';
import onClickOutside from 'react-onclickoutside';
import './style.scss';
import { LabelContext } from '../../../views/issueCreateView';


function Dropdown(props) {
  const {labelState, labelDispatch} = useContext(LabelContext)
  const {labels, title} = props
  const [open, setOpen] = useState(false);
  const toggle = () => setOpen(!open);
  Dropdown.handleClickOutside = () => setOpen(false);

  const selectItem = (label) => {
    if (labelState.some(ele => ele.label_no === label.label_no)){
      const payload = labelState.filter(ele => ele.label_no !== label.label_no);
      labelDispatch({type: "UPDATE", payload})
    } else {
      labelDispatch({type: "UPDATE", payload:[...labelState,label]})
    }
  }
  
  const checkItem = (label) => {
    return labelState.some(ele => ele.label_no === label.label_no)
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
        {labels.map(label => (
          <div className="dropdown-item" key={label.label_no}>
          <button className="dropdown-button" type="button" onClick={() => selectItem(label)}>
          <span>{checkItem(label)&&"✔️"}</span>
          <span>{label.label_title}</span>
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