import React, { useState, useContext } from 'react';
import onClickOutside from 'react-onclickoutside';
import './style.scss';
import { MemberContext } from '../../views/issueCreateView';


function Dropdown(props) {
  const {memberState, memberDispatch} = useContext(MemberContext)
  const {items, title} = props
  const [open, setOpen] = useState(false);
//   const [selection, setSelection] = useState([]);
  const toggle = () => setOpen(!open);
  Dropdown.handleClickOutside = () => setOpen(false);

  const selectItem = (item) => {
    if (memberState.some(ele => ele.id === item.id)){
      const payload = memberState.filter(ele => ele.id !== item.id);
      memberDispatch({type: "UPDATE", payload})
    } else {
      memberDispatch({type: "UPDATE", payload:[...memberState,item]})
    }
  }
  
  const checkItem = (item) => {
    return memberState.some(ele => ele.id === item.id)
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
        {items.map(item => (
          <div className="dropdown-item" key={item.id}>
          <button className="dropdown-button" type="button" onClick={() => selectItem(item)}>
          <span>{checkItem(item)&&"✔️"}</span>
          <span>{item.value}</span>
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