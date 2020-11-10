import React, { useState, useEffect, useRef } from 'react';
import axios from 'axios'
import './style.scss';
import Titles from '../../components/issueCreateView/title';
import Contents from '../../components/content';
import Cancels from '../../components/issueCreateView/cancel';
import SubmitButton from '../../components/issueCreateView/submitButton';
import Assignees from '../../components/sideAssignee';
import Labels from '../../components/sideLabel';
import Milestones from '../../components/sideMilestone';

const issueCreateView = () => {
  const [Title, setTitle] = useState('');
  const [Content, setContent] = useState('');

  const onTitleHandler = (e) => {
    setTitle(e.currentTarget.value);
  };

  const onContentHandler = (e) => {
    setContent(e.currentTarget.value);
  };

  const onClickHandler = (e) => {
    e.preventDefault();

    const body={
      issue_title:Title,
      issue_content:Content,
      issue_authoer_no:0
    }

    axios.post('http://localhost:5000/api/issue/create', body).then(response => {
      console.log(response);
    })

  };

  const items = [
    {
      id: 1,
      value: 'Zigje9',
    },
    {
      id: 2,
      value: 'jk',
    },
    {
      id: 3,
      value: 'crong',
    },
  ];

  return (
    <div className="create-view">
      <div className="input-column">
        <div className="create-form" >
          <Titles placeholder="Title" type="title" value={Title} onChange={onTitleHandler}/>
          <Contents placeholder="Leave a comment" type="content" value={Content} onChange={onContentHandler}/>
          <div className="create-form-submit">
            <Cancels />
            <SubmitButton onClick={onClickHandler}/>
          </div>
        </div>
      </div>
      <div className="register-column">
        <Assignees items={items}/>
        <hr className="thin-line" />
        <Labels />
        <hr className="thin-line" />
        <Milestones />
        <hr className="thin-line" />
      </div>
    </div>
  );
};

export default issueCreateView;

