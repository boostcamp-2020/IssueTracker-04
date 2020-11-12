import React, { useState, useRef } from 'react';
import './style.scss';
import MilestoneList from '../../components/milestoneView/milestoneList';
import Header from '../../components/labelView/header';
import GreenBtn from '../../components/labelView/greenBtn';
import WhiteBtn from '../../components/labelView/whiteBtn';

const milestoneView = () => {
  const mOpenCnt = 2;
  const mClosedCnt = 0;
  const milestones = [
    {
      title: '스프린트2',
      date: '2020-11-5',
      description: '저번 배포를 위한 스프린트',
      percent: 60,
      iOpenCnt: 4,
      iClosedCnt: 6,
    },
    {
      title: '스프린트3',
      date: '2020-11-12',
      description: '이번 배포를 위한 스프린트',
      percent: 10,
      iOpenCnt: 9,
      iClosedCnt: 1,
    },
  ];

  return (
    <div className="milestone-layout">
      <Header />
      <div className="milestone-container">
        <div className="label-milestone-btns">
          <WhiteBtn addClass={['checked', 'label-list-btn']} title="Labels" />
          <WhiteBtn addClass={['milestone-list-btn']} title="Milestones" />
        </div>
        <div className="absolute-right">
          <GreenBtn addClass={['new-label']} title="New Label" />
        </div>
        <MilestoneList mOpenCnt={mOpenCnt} mClosedCnt={mClosedCnt} milestones={milestones} />
      </div>
    </div>
  );
};

export default milestoneView;
