import React, { useState, useEffect, useRef } from 'react';
import axios from 'axios'
import './style.scss';
import qs from 'qs';
import Assignees from '../../components/sideAssignee';
import Labels from '../../components/sideLabel';
import Milestones from '../../components/sideMilestone';
import CommentBox from '../../components/issueDetailView/commentBox';
import CommentSubmit from '../../components/issueDetailView/submitComment';
import IssueControl from '../../components/issueDetailView/issueControl';

const issueDetailView = () => {
  const [Content, setContent] = useState('');
  const [CommentList, setCommentList] = useState([]);
  const onDetailContentHandler = (e) => {
    setContent(e.currentTarget.value);
  };
  useEffect(() => {
    const { issue_no } = qs.parse(location.search, {
      ignoreQueryPrefix: true,
    });
    console.log(issue_no)
    const JWT = localStorage.getItem('jwt')
    // 111axios 로 이슈 넘버 정보 받아와서 detail-header 컴포넌트 만들어서 넣기
    // const commentList = await axios.get('http://101.101.217.9:5000/api/comment',{
    //   headers: {
    //     Authorization: `Bearer ${JWT}`
    //   }
    // })
    // 2222 comment, date, author_no -> name 필요(한번더 요청?)
    // props 로 comment-container 에 추가 , 컴포넌트 만들기

    // 333 comment 버튼에 이벤트걸고 코멘트 추가 axios 

    // 444 close, reopen 컴포넌트..
  }, [])

  return (
    <div className="detail-view">
      <div className="detail-header">
        <div>title</div>
        <div>number</div>
        <div>open</div>
        <div>info</div>
        <div>editbutton</div>
      </div>
      <div className="detail-body">
        <div className="comment-container">
          <div className="comment-list">comment-container</div>
          <div className="comment-form">
            <CommentBox placeholder="Leave a comment" type="content" value={Content} onChange={onDetailContentHandler}/>
            <div className="comment-form-submit">
              <IssueControl />
              <CommentSubmit />
            </div>
          </div>
        </div>
        <div className="side-container">
          {/* <Assignees /> */}
          <hr className="thin-line" />
          {/* <Labels /> */}
          <hr className="thin-line" />
          {/* <Milestones /> */}
          <hr className="thin-line" />
        </div>
      </div>
    </div>
  );
};

export default issueDetailView;

