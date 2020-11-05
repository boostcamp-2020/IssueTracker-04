const DataTypes = require('sequelize').DataTypes;
const _issue = require('./issue');
const _issue_comment = require('./issue_comment');
const _issue_label_relation = require('./issue_label_relation');
const _issue_user_relation = require('./issue_user_relation');
const _label = require('./label');
const _milestone = require('./milestone');
const _user = require('./user');

function initModels(sequelize) {
  const issue = _issue(sequelize, DataTypes);
  const issue_comment = _issue_comment(sequelize, DataTypes);
  const issue_label_relation = _issue_label_relation(sequelize, DataTypes);
  const issue_user_relation = _issue_user_relation(sequelize, DataTypes);
  const label = _label(sequelize, DataTypes);
  const milestone = _milestone(sequelize, DataTypes);
  const user = _user(sequelize, DataTypes);

  return {
    issue,
    issue_comment,
    issue_label_relation,
    issue_user_relation,
    label,
    milestone,
    user,
  };
}
module.exports = { initModels };
