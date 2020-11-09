import React from 'react';
import './App.scss';
import { BrowserRouter, Route, Switch, Redirect } from 'react-router-dom';
import LoginPage from './views/loginView';
import IssueListPage from './views/issueListView';
import IssueCreatePage from './views/issueCreateView';
import IssueDetailPage from './views/issueDetailView';

const App = () => {
  return(
    <BrowserRouter>
        <Switch>
          <Route exact path="/" component = {LoginPage} />
          <Route path="/issues-list" component = {IssueListPage} />
          <Route path="/issues-create" component = {IssueCreatePage} />
          <Route path="/issues-detail" component = {IssueDetailPage} />
          <Redirect path="*" to="/" />
        </Switch>
    </BrowserRouter>
  )};

export default App;
