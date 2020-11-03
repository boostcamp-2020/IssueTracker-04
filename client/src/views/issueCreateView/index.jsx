import React, { useState, useRef } from 'react';
import Axios from 'axios'
import './style.scss';
import Titles from '../../components/issueCreateView/title';
import Contents from '../../components/issueCreateView/content';
import Cancels from '../../components/issueCreateView/cancel';
import SubmitButton from '../../components/issueCreateView/submitButton';
import Assignees from '../../components/issueCreateView/assignees';
import Labels from '../../components/issueCreateView/labels';
import Milestones from '../../components/issueCreateView/milestone';

const issueCreateView = () => {
  const [Title, setTitle] = useState('');
  const [Content, setContent] = useState('');

  const onTitleHandler = (e) => {
    setTitle(e.currentTarget.value);
  };

  const onContentHandler = (e) => {
    setContent(e.currentTarget.value);
  };

  const onSubmitHandler = (e) => {
    e.preventDefault();

    let body={
      issue_title:Title,
      issue_content:Content,
      issue_date:Date.now()
    }
    Axios.post('http://localhost:5000/api/issue/create', body).then(response => {
      console.log(response);
    })

  };

  return (
    <div className="create-view">
      <div className="input-column">
        <form className="create-form" onSubmit={onSubmitHandler}>
          <Titles placeholder="Title" type="title" value={Title} onChange={onTitleHandler}/>
          <Contents placeholder="Leave a comment" type="content" value={Content} onChange={onContentHandler}/>
          <div className="create-form-submit">
            <Cancels></Cancels>
            <SubmitButton></SubmitButton>
          </div>
        </form>
      </div>
      <div className="register-column">
        <Assignees></Assignees>
        <hr className="thin-line"></hr>
        <Labels></Labels>
        <hr className="thin-line"></hr>
        <Milestones></Milestones>
        <hr className="thin-line"></hr>
      </div>
    </div>
  );
};

export default issueCreateView;

