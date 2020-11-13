import React, { useState, useEffect, useRef } from 'react';
import axios from 'axios';
import './style.scss';
import qs from 'qs';
// import Assignees from '../../components/sideAssignee';
// import Labels from '../../components/sideLabel';
// import Milestones from '../../components/sideMilestone';
import CommentBox from '../../components/issueDetailView/commentBox';
import CommentSubmit from '../../components/issueDetailView/submitComment';
import IssueControl from '../../components/issueDetailView/issueControl';
// import issueControl from '../../components/issueDetailView/issueControl';
import Header from '../../components/labelView/header';
import { Redirect } from 'react-router';

const issueDetailView = () => {
  const [issue, setIssue] = useState({});
  // const [title, setTitle] = useState('');
  // const [issueContent, setIssueContent] = useState('');
  const [Content, setContent] = useState('');
  const [CommentList, setCommentList] = useState([]);
  const onDetailContentHandler = e => {
    setContent(e.currentTarget.value);
  };
  useEffect(async () => {
    const { issue_no } = qs.parse(location.search, {
      ignoreQueryPrefix: true,
    });
    const JWT = localStorage.getItem('jwt');
    const result = await axios.get(`http://101.101.217.9:5000/api/issue/${issue_no}`, {
      headers: {
        Authorization: `Bearer ${JWT}`,
      },
    });
    const detail = result.data;
    console.log(detail);

    setIssue(detail.issue);
    setCommentList(detail.comments);
  }, []);

  const commentListTag = CommentList.map((comm, index) => {
    return (
      <div key={index} className="commentRow">
        <div className="comment-left">
          <div>{comm.author_name}</div>
          <div>
            <img className="thumbnail" src={comm.author_img} alt="" />
          </div>
        </div>
        <div className="comment-right">
          <div># {comm.comment_no}</div>
          <div>{comm.comment}</div>
          <div>{comm.comment_date}</div>
        </div>
      </div>
    );
  });

  const commentHandler = async e => {
    const JWT = localStorage.getItem('jwt');
    const body = {
      issue_no: issue.issue_no,
      comment: Content,
    };
    const result = await axios.post(`http://101.101.217.9:5000/api/comment`, body, {
      headers: {
        Authorization: `Bearer ${JWT}`,
      },
    });

    if (result.data.success) {
      location.reload();
    }
  };

  return (
    <div>
      <Header />

      <div className="detail-view">
        <div className="detail-header">
          <div>
            <h2>{issue.issue_title}</h2>
          </div>
          <div>#{issue.issue_no}</div>
          <div>{issue.issue_flag ? 'open' : 'closed'}</div>
          <div>due to {issue.issue_date}</div>
        </div>
        <div className="detail-body">
          <div className="comment-container">
            <div className="comment-list">{commentListTag}</div>
            <div className="comment-form">
              <CommentBox
                placeholder="Leave a comment"
                type="content"
                value={Content}
                onChange={onDetailContentHandler}
              />
              <div className="comment-form-submit">
                <IssueControl />
                <CommentSubmit onClick={commentHandler} />
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
    </div>
  );
};

export default issueDetailView;
