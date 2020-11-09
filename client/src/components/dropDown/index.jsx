import React, { useState } from 'react';
import onClickOutside from 'react-onclickoutside';
import './style.scss';

function Dropdown(props) {
  const {items, member, title, setmember} = props
  const [open, setOpen] = useState(false);
  const [selection, setSelection] = useState([]);
  const toggle = () => setOpen(!open);
  Dropdown.handleClickOutside = () => setOpen(false);

  const selectItem = (item) => {
    if (selection.some(ele => ele.id === item.id)){
      setSelection(selection.filter(ele => ele.id !== item.id))
    } else {
      setSelection([...selection, item])
    }
    setmember(["ab","123"])
    console.log("자식멤버", member);
  }
  
  const checkItem = (item) => {
    return selection.includes(item)
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
          <span>{item.value}</span>
          <span>{checkItem(item)&&'✔️'}</span>
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