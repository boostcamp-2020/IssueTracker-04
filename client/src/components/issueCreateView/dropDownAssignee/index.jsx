import React, { useState, useContext } from 'react';
import onClickOutside from 'react-onclickoutside';
import './style.scss';
import { MemberContext } from '../../../views/issueCreateView';


function Dropdown(props) {
  const {memberState, memberDispatch} = useContext(MemberContext)
  const {users, title} = props
  const [open, setOpen] = useState(false);
  const toggle = () => setOpen(!open);
  Dropdown.handleClickOutside = () => setOpen(false);

  const selectItem = (user) => {
    if (memberState.some(ele => ele.user_no === user.user_no)){
      const payload = memberState.filter(ele => ele.user_no !== user.user_no);
      memberDispatch({type: "UPDATE", payload})
    } else {
      memberDispatch({type: "UPDATE", payload:[...memberState,user]})
    }
  }
  
  const checkItem = (user) => {
    return memberState.some(ele => ele.user_no === user.user_no)
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
        {users.map(user => (
          <div className="dropdown-item" key={user.user_no}>
          <button className="dropdown-button" type="button" onClick={() => selectItem(user)}>
          <span>{checkItem(user)&&"✔️"}</span>
          <span>{user.user_name}</span>
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