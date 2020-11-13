import React, { useState, useRef, useEffect } from 'react';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import './style.scss';

const Issue = props => {
  const { isOpened, title, milestone, labels, issueNum, time, author, assignees } = props;
  // const [value, setValue] = useState("");

  const [openCheckIconPath, setOpenCheckIconPath] = useState('');
  const [openedString, setOpenedString] = useState('');

  useEffect(() => {
    if (isOpened === 1) {
      setOpenCheckIconPath(
        'M8 1.5a6.5 6.5 0 100 13 6.5 6.5 0 000-13zM0 8a8 8 0 1116 0A8 8 0 010 8zm9 3a1 1 0 11-2 0 1 1 0 012 0zm-.25-6.25a.75.75 0 00-1.5 0v3.5a.75.75 0 001.5 0v-3.5z',
      );
      setOpenedString(' opened');
    } else {
      setOpenCheckIconPath(
        'M1.5 8a6.5 6.5 0 0110.65-5.003.75.75 0 00.959-1.153 8 8 0 102.592 8.33.75.75 0 10-1.444-.407A6.5 6.5 0 011.5 8zM8 12a1 1 0 100-2 1 1 0 000 2zm0-8a.75.75 0 01.75.75v3.5a.75.75 0 11-1.5 0v-3.5A.75.75 0 018 4zm4.78 4.28l3-3a.75.75 0 00-1.06-1.06l-2.47 2.47-.97-.97a.749.749 0 10-1.06 1.06l1.5 1.5a.75.75 0 001.06 0z',
      );
      setOpenedString(' closed');
    }
  }, [isOpened]);

  const issueDetailLink = `issues-detail?issue_no=${issueNum}`;

  return (
    <div className="issue">
      <div className="issue-checkBoxArea">
        <input className="issue-checkBoxArea-checkBox" type="checkBox" />
      </div>
      <div className="issue-openCheckArea">
        <svg
          id="issue-openCheckArea-icon"
          viewBox="0 0 16 16"
          version="1.1"
          width="16"
          height="16"
          display=""
          aria-hidden="true"
        >
          <path fillRule="evenodd" d={openCheckIconPath} />
        </svg>
      </div>
      <div className="issue-contentsArea">
        <div className="issue-contentsArea-top">
          <Link to={issueDetailLink}>{title}</Link>
          {
            // label 받은 만큼 label 보여주기
          }
        </div>
        <div className="issue-contentsArea-bottom">
          #{issueNum}
          {openedString} {time} by {author}
          {
            // 스프린트 표시할 이미지
          }
          {` ${milestone}`}
        </div>
      </div>
      <div className="issue-assigneesArea">
        {
          // assignee 개수 만큼 assignee 보여주기
        }
      </div>
    </div>
  );
};

export default Issue;
