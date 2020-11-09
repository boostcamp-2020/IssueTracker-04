import React, { useState, useRef } from 'react';
import './style.scss';
import MilestoneRow from '@components/milestoneView/milestoneRow';

const milestoneList = ({ mOpenCnt, mClosedCnt, milestones }) => {
  const milestoneRows = milestones.map(({ title, date, description, percent, iOpenCnt, iClosedCnt }, index) => (
    <MilestoneRow
      key={index}
      title={title}
      description={description}
      date={date}
      percent={percent}
      iOpenCnt={iOpenCnt}
      iClosedCnt={iClosedCnt}
    />
  ));
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
