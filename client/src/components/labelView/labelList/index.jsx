import React, { useState, useRef } from 'react';
import './style.scss';
import LabelRow from '@components/labelView/labelRow';

const labelList = ({ labelCnt, labels }) => {
  const labelRows = labels.map((label, index) => (
    <LabelRow key={index} title={label.title} description={label.description} color={label.color} />
  ));
  return (
    <div className="label-list">
      <div className="label-list-head">{labelCnt} Labels</div>
      <div className="label-list-content">{labelRows}</div>
    </div>
  );
};

export default labelList;
