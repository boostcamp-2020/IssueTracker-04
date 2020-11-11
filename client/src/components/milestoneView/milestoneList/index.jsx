import React, { useState, useRef } from 'react';
import './style.scss';
import MilestoneRow from '@components/milestoneView/milestoneRow';

const milestoneList = ({ mOpenCnt, mClosedCnt, milestones }) => {
  const milestoneRows = milestones.map(
    (
      { milestone_no, milestone_title, milestone_description, due_date, percent, open_issue_count, closed_issue_count },
      index,
    ) => (
      <MilestoneRow
        key={index}
        milestoneNo={milestone_no}
        title={milestone_title}
        description={milestone_description}
        date={due_date}
        percent={percent}
        iOpenCnt={open_issue_count}
        iClosedCnt={closed_issue_count}
      />
    ),
  );
  return (
    <div className="milestone-list">
      <div className="milestone-list-head">
        <span className="margin-right">
          <a href="#" className="open-closed-btn">
            {mOpenCnt} open
          </a>
        </span>
        <span className="margin-right">
          <a href="#" className="open-closed-btn">
            {mClosedCnt} closed
          </a>
        </span>
      </div>
      <div className="milestone-list-content">{milestoneRows}</div>
    </div>
  );
};

export default milestoneList;
