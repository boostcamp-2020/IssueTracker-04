import React from 'react';
import './App.scss';
import LoginPage from './views/loginView';
import IssueListPage from './views/issueListView'

const App = () => (
  <div className="container">
    <IssueListPage />
  </div>
);

export default App;
