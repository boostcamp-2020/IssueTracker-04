import React from 'react';
import './style.scss';

const milestoneRow = ({ milestoneNo, title, description, date, percent, iOpenCnt, iClosedCnt }) => {
  return (
    <div className="milestone-row" data-milestoneno={milestoneNo}>
      <div className="milestone-left">
        <div>
          <a href="#" className="milestone-title">
            {title}
          </a>
        </div>
        <div>due to {date}</div>
        <div>{description}</div>
      </div>
      <div className="milestone-right">
        <div>
          <svg className="barChart">
            <rect x="0" y="0" width={`${percent}%`} height="100%" fill="#1ee280" />
          </svg>
        </div>
        <div>
          <span className="margin-right">{percent}%</span>
          <span className="margin-right">{iOpenCnt} open</span>
          <span className="margin-right">{iClosedCnt} closed</span>
        </div>
        <div>
          <a href="#" className="edit-delete-close-btn color-blue">
            Edit
          </a>
          <a href="#" className="edit-delete-close-btn color-blue">
            Close
          </a>
          <a href="#" className="edit-delete-close-btn color-red">
            Delete
          </a>
        </div>
      </div>
    </div>
  );
};

export default milestoneRow;
