import React, { useState, useRef } from 'react';
import './style.scss';

import Header from '../../components/Header';
import FilterButton from '../../components/issueListView/FilterButton'
import SearchBar from '../../components/issueListView/SearchBar'
import LabelButton from '../../components/issueListView/LabelButton'
import MilestoneButton from '../../components/issueListView/MilestoneButton'
import MakeIssueButton from '../../components/issueListView/MakeIssueButton'
import Issue from '../../components/issueListView/Issue'

const issueListView = () => {
  const [issueList, setIssueList] = useState([1,2,3]);

    /*
  const [Id, setId] = useState('');
  const [Password, setPassword] = useState('');

  const onIdHandler = (e) => {
    setId(e.currentTarget.value);
  };

  const onPasswordHandler = (e) => {
    setPassword(e.currentTarget.value);
  };

  console.log(Id);
  
  const onSubmitHandler = (e) => {
    e.preventDefault();

    console.log(Id);
    console.log(Password);
    const body = {};

    
      Axios.post('/api/users/login', body).then(response => {

      })
      */
  

  return (
    <div className = 'issueListView'>
      <Header />
      <div className = "issueListView-body">
        <div className = 'issueListView-body-topNav'>
            <div className = "issueListView-body-topNav-searchArea">
              <FilterButton />
              <SearchBar />
             </div>
            <div className = "issueListView-body-opNav-labelMilestones">
              <LabelButton />
              <MilestoneButton />
            </div>
            <MakeIssueButton />
        </div>

        <div className = "issueListView-contents">
          <div className = 'issueListView-contents-filterNav'>
            <h1>test</h1>
          </div>
          <div className = "issueListView-contents-issueList">
            <Issue
              isOpened = 'opened'
              title = 'test1'
              milestone = '스프린트1'
              labels = {[1,2,3]}
              issueNum = '1'
              time = '2 days ago'
              author = 'JunYoung7'
              assignees = {[1,2,3]}
            />
          </div>
        </div>

      </div>
    </div>
      

      
      
  );
};

export default issueListView;
