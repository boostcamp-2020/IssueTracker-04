const issueModel = require('../../models').issue;
const milestoneModel = require('../../models').milestone;
const issueUserModel = require('../../models').issue_user_relation;
const userModel = require('../../models').user;
const labelModel = require('../../models').label;
const issueLabelModel = require('../../models').issue_label_relation;

exports.issueCreate = (req, res, next) => {
  console.log(req.body);
  res.json({ hi: 'hello' });
};

const getIssueAssignees = async (issueNo) => {
  issueUserModel.belongsTo(userModel, { foreignKey: 'user_no' });
  const assigneesData = await issueUserModel.findAll({
    include: [
      {
        model: userModel,
        //required: true,
      },
    ],
    where: { issue_no: issueNo },
  });

  return assigneesData;
};

const getIssueLabels = async (issueNo) => {
  issueLabelModel.belongsTo(labelModel, { foreignKey: 'label_no' });
  const labelsData = await issueLabelModel.findAll({
    include: [
      {
        model: labelModel,
        //required: true,
      },
    ],
    where: { issue_no: issueNo },
  });

  return labelsData;
};

const getAuthorName = async (authorNo) => {
  const authorNameData = await userModel.findOne({
    attributes: ['user_name'],
    where: { user_no: authorNo },
  });
  return authorNameData;
};

const getIssuesMilestones = async () => {
  issueModel.belongsTo(milestoneModel, { foreignKey: 'milestone_no' });
  const issuesMilestonesData = await issueModel.findAll({
    include: [
      {
        model: milestoneModel,
        required: true,
        //attributes: ['milestone_title'],
      },
    ],
  });
  return issuesMilestonesData;
};

exports.issueListGet = async (req, res, next) => {
  try {
    const issuesMilestonesData = await getIssuesMilestones();

    let resDatas = [];
    let issue = [];
    let milestone = [];
    let assignees = [];
    let labels = [];

    for (const issueMilestone of issuesMilestonesData) {
      let issue_author_name = await getAuthorName(
        issueMilestone.dataValues.issue_author_no
      );

      let issueAssigneesData = await getIssueAssignees(
        issueMilestone.dataValues.issue_no
      );
      let issuelabelsData = await getIssueLabels(
        issueMilestone.dataValues.issue_no
      );

      console.log(issuelabelsData);
      issue.push({
        issue_no: issueMilestone.dataValues.issue_no,
        issue_title: issueMilestone.dataValues.issue_title,
        issue_content: issueMilestone.dataValues.issue_content,
        issue_flag: issueMilestone.dataValues.issue_flag,
        issue_date: issueMilestone.dataValues.issue_date,
        issue_author_no: issueMilestone.dataValues.issue_author_no,
        issue_author_name: issue_author_name.user_name,
      });
      milestone.push({
        milestone_no: issueMilestone.milestone.dataValues.milestone_no,
        milestone_title: issueMilestone.milestone.dataValues.milestone_title,
      });

      if (issueAssigneesData.length != 0) {
        for (const issueAssignee of issueAssigneesData) {
          assignees.push({
            iu_relation_no: issueAssignee.dataValues.iu_relation_no,
            user_no: issueAssignee.dataValues.user_no,
            user_name: issueAssignee.user.dataValues.user_name,
            user_img: issueAssignee.user.dataValues.user_img,
          });
        }
      }

      if (issuelabelsData.length != 0) {
        for (const issuelabel of issuelabelsData) {
          labels.push({
            il_relation_no: issuelabel.dataValues.il_relation_no,
            label_no: issuelabel.dataValues.label_no,
            label_title: issuelabel.label.dataValues.label_title,
            label_color: issuelabel.label.dataValues.label_color,
          });
        }
      }

      let resData = {
        issue: issue,
        milestone: milestone,
        assignees: assignees,
        labels: labels,
      };

      resDatas.push(resData);

      issue = [];
      milestone = [];
      assignees = [];
      labels = [];
      resData = {};
    }

    res.status(200).json(resDatas);
  } catch (err) {
    res.status(400).json({ message: 'get issue error' });
  }
};
