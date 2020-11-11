import React, { useState, useEffect, useRef, useReducer } from 'react';
import axios from 'axios'
import './style.scss';
import Titles from '../../components/issueCreateView/title';
import Contents from '../../components/content';
import Cancels from '../../components/issueCreateView/cancel';
import SubmitButton from '../../components/issueCreateView/submitButton';
import Assignees from '../../components/sideAssignee';
import Labels from '../../components/sideLabel';
import Milestones from '../../components/sideMilestone';

export const MemberContext = React.createContext();

const memberReducer = (state, action) => {
  switch (action.type) {
    case "INIT": 
      return []
    case "UPDATE":
      return [...action.payload]
    default:
      throw new Error();
  }
}

const issueCreateView = () => {
  const [memberState, memberDispatch] = useReducer(memberReducer, []);
  const [Title, setTitle] = useState('');
  const [Content, setContent] = useState('');
  const [User, setUser] = useState([]);

  const onTitleHandler = (e) => {
    setTitle(e.currentTarget.value);
  };

  const onContentHandler = (e) => {
    setContent(e.currentTarget.value);
  };

  const onClickHandler = (e) => {
    e.preventDefault();
    console.log("answer",memberState, Title, Content);
    console.log("asdfasdf");
    const body={
      issue_title:Title,
      issue_content:Content,
      issue_authoer_no:0
    }
    // axios.post('http://localhost:5000/api/issue/create', body).then(response => {
    //   console.log(response);
    // })
  };
  useEffect(()=>{
    const users = [
      {
        user_no: 1,
        user_name: 'Zigje9',
      },
      {
        user_no: 2,
        user_name: 'jk',
      },
      {
        user_no: 3,
        user_name: 'crong',
      },
    ];
    setUser(users)
  }, []);

  

  return (
    <MemberContext.Provider value={{memberState, memberDispatch}}>
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
          <Assignees users={User} now={memberState}/>
          <hr className="thin-line" />
          <Labels />
          <hr className="thin-line" />
          <Milestones />
          <hr className="thin-line" />
        </div>
      </div>
    </MemberContext.Provider>
  );
};



export default issueCreateView;

