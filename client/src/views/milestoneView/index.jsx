import React, { useState, useEffect } from 'react';
import './style.scss';
import axios from 'axios';
import MilestoneList from '../../components/milestoneView/milestoneList';
import Header from '../../components/labelView/header';
import GreenBtn from '../../components/labelView/greenBtn';
import WhiteBtn from '../../components/labelView/whiteBtn';

const milestoneView = () => {
  const mClosedCnt = 0;
  const [milestones, setMilestones] = useState([]);
  const [mOpenCnt, setMOpenCnt] = useState(0);

  const callMilestones = async () => {
    const urlForMilestones = 'http://101.101.217.9:5000/api/milestoneList';
    const jwt = localStorage.getItem('jwt');
    const option = {
      headers: { Authorization: `Bearer ${jwt}` },
    };
    const result = await axios.get(urlForMilestones, option);
    const milestones = result.data.milestones;
    setMilestones(milestones);
    setMOpenCnt(milestones.length);
  };

  useEffect(callMilestones, []);

  return (
    <div className="milestone-layout">
      <Header />
      <div className="milestone-container">
        <div className="label-milestone-btns">
          <WhiteBtn addClass={['label-list-btn']} title="Labels" link="/labels" />
          <WhiteBtn addClass={['checked', 'milestone-list-btn']} title="Milestones" link="/milestones" />
        </div>
        <div className="absolute-right">
          <GreenBtn addClass={['new-label']} title="New Milestone" />
        </div>
        <MilestoneList mOpenCnt={mOpenCnt} mClosedCnt={mClosedCnt} milestones={milestones} />
      </div>
    </div>
  );
};

export default milestoneView;
