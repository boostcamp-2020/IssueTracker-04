import React, { useState, useEffect, useRef, useReducer } from 'react';
import axios from 'axios';
import './style.scss';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import Titles from '../../components/issueCreateView/title';
import Contents from '../../components/content';
import Cancels from '../../components/issueCreateView/cancel';
import SubmitButton from '../../components/issueCreateView/submitButton';
import Assignees from '../../components/sideAssignee';
import Labels from '../../components/sideLabel';
import Milestones from '../../components/sideMilestone';
import Header from '../../components/labelView/header';

export const MemberContext = React.createContext();
export const LabelContext = React.createContext();
export const MilestoneContext = React.createContext();

const memberReducer = (state, action) => {
  switch (action.type) {
    case 'INIT':
      return [];
    case 'UPDATE':
      return [...action.payload];
    default:
      throw new Error();
  }
};

const labelReducer = (state, action) => {
  switch (action.type) {
    case 'INIT':
      return [];
    case 'UPDATE':
      return [...action.payload];
    default:
      throw new Error();
  }
};

const milestoneReducer = (state, action) => {
  switch (action.type) {
    case 'INIT':
      return [];
    case 'UPDATE':
      return [...action.payload];
    default:
      throw new Error();
  }
};

const issueCreateView = () => {
  const [memberState, memberDispatch] = useReducer(memberReducer, []);
  const [labelState, labelDispatch] = useReducer(labelReducer, []);
  const [milestoneState, milestoneDispatch] = useReducer(milestoneReducer, []);
  const [Title, setTitle] = useState('');
  const [Content, setContent] = useState('');
  const [User, setUser] = useState([]);
  const [Label, setLabel] = useState([]);
  const [Milestone, setMilestone] = useState([]);
  const [Count, setCount] = useState(0);

  const onTitleHandler = e => {
    setTitle(e.currentTarget.value);
  };

  const onContentHandler = e => {
    setCount(e.currentTarget.value.length);
    setContent(e.currentTarget.value);
  };

  const onClickHandler = async e => {
    e.preventDefault();
    const JWT = localStorage.getItem('jwt');
    const labelList = labelState.map(ele => ele.label_no);
    const assigneesList = memberState.map(ele => ele.user_no);
    const body = {
      issue_title: Title,
      issue_content: Content,
      milestone_no: milestoneState[0].milestone_no,
      label_list: labelList,
      assignees: assigneesList,
    };
    const result = await axios.post('http://101.101.217.9:5000/api/issue/create', body, {
      headers: {
        Authorization: `Bearer ${JWT}`,
      },
    });
    if (result.data.success) {
      location.href = `/issues-detail?issue_no=${result.data.new_issue_no}`;
    } else {
      location.reload();
    }
  };
  useEffect(async () => {
    console.log(window.location.href);
    const tt = window.location.href;
    const JWT = localStorage.getItem('jwt');
    const userData = await axios.get('http://101.101.217.9:5000/api/userList', {
      headers: {
        Authorization: `Bearer ${JWT}`,
      },
    });
    setUser(userData.data.userList);
    const milestoneData = await axios.get('http://101.101.217.9:5000/api/milestoneList', {
      headers: {
        Authorization: `Bearer ${JWT}`,
      },
    });
    setMilestone(milestoneData.data.milestones);
    const labelData = await axios.get('http://101.101.217.9:5000/api/labelList', {
      headers: {
        Authorization: `Bearer ${JWT}`,
      },
    });
    setLabel(labelData.data.labels);
  }, []);

  return (
    <MemberContext.Provider value={{ memberState, memberDispatch }}>
      <LabelContext.Provider value={{ labelState, labelDispatch }}>
        <MilestoneContext.Provider value={{ milestoneState, milestoneDispatch }}>
          <div className="create-view">
            <div className="input-column">
              <div className="create-form">
                <Titles placeholder="Title" type="title" value={Title} onChange={onTitleHandler} />
                <Contents placeholder="Leave a comment" type="content" value={Content} onChange={onContentHandler} />
                <div>{Count}chracters</div>
                <div className="create-form-submit">
                  <Link to="issues-list">
                    <Cancels />
                  </Link>
                  <SubmitButton onClick={onClickHandler} />
                </div>
              </div>
            </div>
            <div className="register-column">
              <Assignees users={User} now={memberState} />
              <hr className="thin-line" />
              <Labels labels={Label} now={labelState} />
              <hr className="thin-line" />
              <Milestones milestones={Milestone} now={milestoneState} />
              <hr className="thin-line" />
            </div>
          </div>
        </MilestoneContext.Provider>
      </LabelContext.Provider>
    </MemberContext.Provider>
  );
};

export default issueCreateView;
