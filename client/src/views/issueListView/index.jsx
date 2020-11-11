/* eslint-disable camelcase */
/* eslint-disable no-plusplus */
/* eslint-disable no-unused-expressions */
import React, { useState, useRef, useEffect } from 'react';
import './style.scss';
import axios from 'axios';
import {BrowserRouter as Router, Route, Link } from 'react-router-dom';

import Header from '../../components/Header';
import FilterButton from '../../components/issueListView/FilterButton'
import SearchBar from '../../components/issueListView/SearchBar'
import LabelButton from '../../components/issueListView/LabelButton'
import MilestoneButton from '../../components/issueListView/MilestoneButton'
import MakeIssueButton from '../../components/issueListView/MakeIssueButton'
import Issue from '../../components/issueListView/Issue'
import ContentsFilterNav from '../../components/issueListView/Contents-FilterNav'

let sampleIssues = [];

const issueListView = () => {
  const [issueList, setIssueList] = useState([]);

  useEffect(() => {
    (async function () {
      try {
         sampleIssues = [];

         const jwt = await localStorage.getItem('jwt');


         const result = await axios.get('http://101.101.217.9:5000/api/issue/list', {
           headers: {Authorization: `Bearer ${jwt}`},
         });


        for (let i = 0; i < result.data.length; i++){
          const newIssue = {
            issue_no : result.data[i].issue.issue_no,
            issue_title : result.data[i].issue.issue_title,
            issue_content : result.data[i].issue.issue_content,
            issue_flag: result.data[i].issue.issue_flag,
            issue_date: result.data[i].issue.issue_date,
            issue_author_no : result.data[i].issue.issue_author_no,
            issue_author_name : result.data[i].issue.issue_author_name,
            milestone_no : result.data[i].milestone.milestone_no,
            milestone_title : result.data[i].milestone.milestone_title,
            assignees : result.data[i].assignees,
            labels : result.data[i].labels
          }
          sampleIssues.push(newIssue);  
        }
        setIssueList(sampleIssues);
        
      }catch (err) {
        console.log(err);
      }
    })()
  },[]);
  

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
              <Link id = 'labelLink' to = '/labels'>
                <LabelButton />
              </Link>
              <Link id = 'milestoneLink' to = '/milestones'>
                <MilestoneButton />
              </Link>
            </div>
            <Link to = '/issues-create'>
              <MakeIssueButton />
            </Link>
        </div>

        <div className = "issueListView-contents">
          <div className = 'issueListView-contents-filterNav'>
            <ContentsFilterNav />
          </div>
          <div className = "issueListView-contents-issueList">
            {
            issueList.map(({issue_flag, issue_title, milestone_title, labels, issue_no, issue_date, issue_author_name, assignees})=> (
              <Issue
              key = {issue_no}
              isOpened = {issue_flag}
              title = {issue_title}
              milestone = {milestone_title}
              labels = {labels}
              issueNum = {issue_no}
              time = {issue_date}
              author = {issue_author_name}
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
