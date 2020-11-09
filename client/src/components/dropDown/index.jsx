import React, { useState } from 'react';
import onClickOutside from 'react-onclickoutside';

function Dropdown({ title, items = false }) {
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
  }
  console.log(selection)
  const itemCheck = (item) => {
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
          <span>{itemCheck(item) && ' ✅ '}</span>
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