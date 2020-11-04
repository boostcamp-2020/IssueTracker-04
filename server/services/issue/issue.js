const issueModel = require('../../models').issue;

exports.issueCreate = async (req, res, next) => {
  const { issue_title, issue_content } = req.body;
  if (issue_title && issue_content) {
    const issueData = {
      issue_title: issue_title,
      issue_content: issue_content,
      issue_flag: 1,
      issue_date: new Date(),
    };
    const result = await issueModel.create(issueData);
    res.json({ success: 'True', result: result });
  } else {
    res.json({ success: 'Fail' });
  }
};
