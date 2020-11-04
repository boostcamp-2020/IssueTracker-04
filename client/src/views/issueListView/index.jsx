/* eslint-disable camelcase */
/* eslint-disable no-plusplus */
/* eslint-disable no-unused-expressions */
import React, { useState, useRef, useEffect } from 'react';
import './style.scss';
import axios from 'axios';

import Header from '../../components/Header';
import FilterButton from '../../components/issueListView/FilterButton'
import SearchBar from '../../components/issueListView/SearchBar'
import LabelButton from '../../components/issueListView/LabelButton'
import MilestoneButton from '../../components/issueListView/MilestoneButton'
import MakeIssueButton from '../../components/issueListView/MakeIssueButton'
import Issue from '../../components/issueListView/Issue'

let sampleIssues = [];

const issueListView = () => {
  const [issueList, setIssueList] = useState([]);

  useEffect(() => {
    console.log(2);
    (async function () {
      try {
         sampleIssues = [];
         const result = await axios.get('http://localhost:5000/api/issue/list');
        
        for (let i = 0; i < result.data.length; i++){
          const newIssue = {
            id : {i},
            issue_no : result.data[i].data[0].issue_no,
            issue_title : result.data[i].data[0].issue_title,
            issue_content : result.data[i].data[0].issue_content,
            issue_flag: result.data[i].data[0].issue_flag,
            issue_date: result.data[i].data[0].issue_date,
            issue_author_no : result.data[i].data[0].issue_author_no,
            issue_author_id : result.data[i].data[0].issue_author_id,
            milestone_no : result.data[i].data[0].milestone_no,
            milestone_title : result.data[i].data[0].milestone_title,
            assignees : result.data[i].data[0].assignees,
            labels : result.data[i].data[0].labels
          }
          sampleIssues.push(newIssue);
          
        }
        setIssueList(sampleIssues);
        
      }catch (err) {
        console.log(err);
      }
    })()
  },[]);
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
            {
            issueList.map(({issue_flag, issue_title, milestone_title, labels, issue_no, issue_date, issue_author_id, assignees})=> (
              <Issue
              isOpened = {issue_flag}
              title = {issue_title}
              milestone = {milestone_title}
              labels = {labels}
              issueNum = {issue_no}
              time = {issue_date}
              author = {issue_author_id}
              assignees = {assignees}
            />
            ))
            
          }
            
          </div>
        </div>

      </div>
    </div>
      

      
      
  );
};

export default issueListView;
