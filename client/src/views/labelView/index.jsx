import React, { useState, useRef } from 'react';
import './style.scss';
import LabelList from '../../components/labelView/labelList';
import Header from '../../components/labelView/header';
import GreenBtn from '../../components/labelView/greenBtn';
import WhiteBtn from '../../components/labelView/WhiteBtn';

const loginView = () => {
  const labels = [
    {
      title: 'bug',
      description: "Something isn't working",
      color: '#364268',
    },
    {
      title: 'fix',
      description: 'Something is working now now',
      color: '#746244',
    },
  ];

  return (
    <div className="label-layout">
      <Header />
      <div className="label-container">
        <div className="label-milestone-btns">
          <WhiteBtn addClass={['checked', 'label-list-btn']} title="Labels" />
          <WhiteBtn addClass={['milestone-list-btn']} title="Milestones" />
        </div>
        <div className="absolute-right">
          <GreenBtn addClass={['new-label']} title="New Label" />
        </div>
        <LabelList labelCnt={2} labels={labels} />
      </div>
    </div>
  );
};

export default loginView;
