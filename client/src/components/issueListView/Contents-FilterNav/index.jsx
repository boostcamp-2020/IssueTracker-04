import React, { useState, useRef } from 'react';
import './style.scss';

const input = (props) => {
    const {openIssueCnt, closedIssueCnt } = props;

  return (
    <div className = "contents-filterNav">
        <div className = "contents-filterNav-checkBoxArea">
            <input type = 'checkBox' />
        </div>
        <div className = "contents-filterNav-middleArea">
            <div className = "contents-filterNav-middleArea-OpenClosedArea">
                <svg className="issue-icon" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true">
                    <path fillRule="evenodd" d= 'M8 1.5a6.5 6.5 0 100 13 6.5 6.5 0 000-13zM0 8a8 8 0 1116 0A8 8 0 010 8zm9 3a1 1 0 11-2 0 1 1 0 012 0zm-.25-6.25a.75.75 0 00-1.5 0v3.5a.75.75 0 001.5 0v-3.5z' />
                </svg>
                {openIssueCnt} Open
                <svg className="issue-icon" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true">
                    <path fillRule="evenodd" d="M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z" />
                </svg>
                {closedIssueCnt} Closed
            </div>
        </div>
        <div className = "contents-filterNav-buttonsArea" >
            <button className = 'filter-button' id = "author-filter-button" type = "button">Author ∨</button>
            <button className = 'filter-button' id = "Label-filter-button" type = "button">Label ∨</button>
            <button className = 'filter-button' id = "Projects-filter-button" type = "button">Projects ∨</button>
            <button className = 'filter-button' id = "MileStones-filter-button" type = "button">MileStones ∨</button>
            <button className = 'filter-button' id = "Assignee-filter-button" type = "button">Assignee ∨</button>
            <button className = 'filter-button' id = "Sort-filter-button" type = "button">Sort ∨</button>    
        </div>
    </div>
  );
};

export default input;
