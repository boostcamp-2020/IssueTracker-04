import React, { useState, useEffect } from 'react';
import './style.scss';
import axios from 'axios';
import LabelList from '../../components/labelView/labelList';
import Header from '../../components/labelView/header';
import GreenBtn from '../../components/labelView/greenBtn';
import WhiteBtn from '../../components/labelView/whiteBtn';

const loginView = () => {
  const [labels, setLabels] = useState([]);
  const [labelCnt, setLabelCnt] = useState(0);

  const callLabels = async () => {
    const urlForLabels = 'http://101.101.217.9:5000/api/labelList';
    const jwt = localStorage.getItem('jwt');
    const option = {
      headers: { Authorization: `Bearer ${jwt}` },
    };
    const result = await axios.get(urlForLabels, option);
    const labels = result.data.labels;
    setLabels(labels);
    setLabelCnt(labels.length);
  };

  useEffect(callLabels, []);


  return (
    <div className="label-layout">
      <Header />
      <div className="label-container">
        <div className="label-milestone-btns">
          <WhiteBtn addClass={['checked', 'label-list-btn']} title="Labels" link="/labels" />
          <WhiteBtn addClass={['milestone-list-btn']} title="Milestones" link="/milestones" />
        </div>
        <div className="absolute-right">
          <GreenBtn addClass={['new-label']} title="New Label" />
        </div>
        <LabelList labelCnt={labelCnt} labels={labels} />
      </div>
    </div>
  );
};

export default loginView;
