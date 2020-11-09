import React, { useState, useRef } from 'react';
import './style.scss';
import Assignees from '../../components/sideAssignee';
import Labels from '../../components/sideLabel';
import Milestones from '../../components/sideMilestone';
import CommentBox from '../../components/issueDetailView/commentBox';
import CommentSubmit from '../../components/issueDetailView/submitComment';
import IssueControl from '../../components/issueDetailView/issueControl';

const issueDetailView = () => {
  const [Content, setContent] = useState('');
  const onDetailContentHandler = (e) => {
    setContent(e.currentTarget.value);
  };

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
          <Assignees />
          <hr className="thin-line" />
          <Labels />
          <hr className="thin-line" />
          <Milestones />
          <hr className="thin-line" />
        </div>
      </div>
    </div>
  );
};

export default issueDetailView;

