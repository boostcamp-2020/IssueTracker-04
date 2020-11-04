import React from 'react';
import './App.scss';
import LoginPage from './views/loginView';

import IssueCreatePage from './views/issueCreateView';

const App = () => (
  <div className="container">
    <IssueCreatePage />
  </div>
);

export default App;
