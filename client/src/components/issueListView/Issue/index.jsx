import React, { useState, useRef } from 'react';
import './style.scss';

const Issue = (props) => {
  const { isOpened, title, milestone, labels, issueNum, time, author, assignees} = props;
  // const [value, setValue] = useState("");

  return (
    <div className = 'issue'>
        <div className = 'issue-checkBoxArea'>
            <input type = 'checkBox' />
        </div>
        <div className = 'issue-openCheckArea'>
            {
                // isOpened여부에 따라 그림 넣기
            }
        </div>
        <div className = 'issue-contentsArea'>
            <div className = 'issue-contentsArea-top'>
                <h4>{title}</h4>
                {
                    // label 받은 만큼 label 보여주기
                }
            </div>
            <div className = 'issue-contentsArea-bottom'>
                <h4>#{issueNum}</h4>
                <h4>{isOpened} {time} by {author} </h4>
                {
                    // 스프린트 표시할 이미지
                }
                <h4>{milestone}</h4>
            </div>
        </div>
        <div className = 'issue-assigneesArea'>
            {
                // assignee 개수 만큼 assignee 보여주기
            }
        </div>
    </div>
  );
};

export default Issue;
