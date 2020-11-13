const issueModel = require('../../models').issue;
const milestoneModel = require('../../models').milestone;
const issueUserModel = require('../../models').issue_user_relation;
const userModel = require('../../models').user;
const labelModel = require('../../models').label;
const issueLabelModel = require('../../models').issue_label_relation;
const issueCommentModel = require('../../models').issue_comment;
const url = require('url');

exports.issueCreate = async (req, res, next) => {
  const { issue_title, issue_content } = req.body;
  const userNo = res.locals.userNo;
  try {
    const result = await issueModel.create({
      issue_title: issue_title,
      issue_content: issue_content,
      issue_author_no: userNo,
      issue_date: new Date(),
      issue_flag: 1,
    });
    await issueCommentModel.create({
      issue_no: result.issue_no,
      comment: issue_content,
      author_no: userNo,
      comment_date: result.issue_date,
    });
    return res
      .status(200)
      .json({ success: true, new_issue_no: result.issue_no });
  } catch (error) {
    return res.status(400).json({ success: false });
  }
};

exports.issueCreateAll = async (req, res, next) => {
  const {
    assignees,
    issue_content,
    issue_title,
    label_list,
    milestone_no,
  } = req.body;

  const userNo = res.locals.userNo;
  try {
    const result = await issueModel.create({
      issue_title: issue_title,
      issue_content: issue_content,
      issue_author_no: userNo,
      issue_date: new Date(),
      issue_flag: 1,
      milestone_no: milestone_no,
    });
    await issueCommentModel.create({
      issue_no: result.issue_no,
      comment: issue_content,
      author_no: userNo,
      comment_date: result.issue_date,
    });
    for (let label of label_list) {
      await issueLabelModel.create({
        issue_no: result.issue_no,
        label_no: label,
      });
    }
    for (let assignee of assignees) {
      await issueUserModel.create({
        user_no: assignee,
        issue_no: result.issue_no,
      });
    }
    return res
      .status(200)
      .json({ success: true, new_issue_no: result.issue_no });
  } catch (error) {
    return res.status(400).json({ success: false });
  }
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
        // required: true,
        //attributes: ['milestone_title'],
      },
    ],
  });
  return issuesMilestonesData;
};

exports.issueGet = async (req, res, next) => {
  try {
    const issueNo = req.params.issue_no;
    const userNo = res.locals.userNo;
    const resData = {};
    const issueData = await issueModel.findOne({
      where: { issue_no: issueNo },
      raw: true,
    });
    const milestoneNo = issueData.milestone_no;
    delete issueData.milestone_no;
    resData.issue = issueData;
    const authName = await userModel.findOne({
      where: { user_no: issueData.issue_author_no },
      raw: true,
    });
    const { user_img, user_name } = authName;
    resData.issue.issue_author_name = user_name;
    resData.detailInfo = {};
    resData.detailInfo.authorImg = user_img;
    let mileStone = null;
    if (milestoneNo) {
      mileStone = await milestoneModel.findOne({
        where: { milestone_no: milestoneNo },
        raw: true,
      });
    }
    resData.milestone = {};
    resData.milestone.milestone_no = milestoneNo;
    resData.milestone.milestone_title = mileStone
      ? mileStone.milestone_title
      : null;
    console.log(issueNo);
    const labelList = await issueLabelModel.findAll({
      where: { issue_no: issueNo },
      raw: true,
    });
    const labelNumList = labelList.map((ele) => ele.label_no);
    resData.labels = [];
    for (let labelNum of labelNumList) {
      let labelData = await labelModel.findOne({
        where: { label_no: labelNum },
        raw: true,
      });
      resData.labels.push(labelData);
    }
    const userList = await issueUserModel.findAll({
      where: { issue_no: issueNo },
      raw: true,
    });
    const userNumList = userList.map((ele) => ele.user_no);
    resData.assignees = [];
    for (let userNum of userNumList) {
      let userData = await userModel.findOne({
        where: { user_no: userNum },
        raw: true,
      });
      delete userData.user_password;
      delete userData.oauth_site;
      delete userData.user_id;
      resData.assignees.push(userData);
    }
    const commentList = await issueCommentModel.findAll({
      where: { issue_no: issueNo },
      raw: true,
    });
    resData.comments = [];
    for (let commentInfo of commentList) {
      let userData = await userModel.findOne({
        where: { user_no: commentInfo.author_no },
        raw: true,
      });
      let { user_img, user_name } = userData;
      commentInfo.author_name = user_name;
      commentInfo.author_img = user_img;
      delete commentInfo.issue_no;
      delete commentInfo.author_no;
      resData.comments.push(commentInfo);
    }
    res.status(200).json({ success: true, ...resData });
  } catch (error) {
    res.status(400).json({ success: false });
  }
};

exports.issueListGet = async (req, res, next) => {
  try {
    const issuesMilestonesData = await getIssuesMilestones();

    let resDatas = [];
    let issue = {};
    let milestone = {};
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
      issue = {
        issue_no: issueMilestone.dataValues.issue_no,
        issue_title: issueMilestone.dataValues.issue_title,
        issue_content: issueMilestone.dataValues.issue_content,
        issue_flag: issueMilestone.dataValues.issue_flag,
        issue_date: issueMilestone.dataValues.issue_date,
        issue_author_no: issueMilestone.dataValues.issue_author_no,
        issue_author_name: issue_author_name.user_name,
      };
      if (issueMilestone.milestone == undefined) {
        milestone = {
          milestone_no: 0,
          milestone_title: '',
        };
      } else {
        milestone = {
          milestone_no: issueMilestone.milestone.dataValues.milestone_no,
          milestone_title: issueMilestone.milestone.dataValues.milestone_title,
        };
      }

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

exports.issueLabelRelation = async (req, res, next) => {
  const { issue_no, labels } = req.body;
  try {
    await issueLabelModel.destroy({
      where: { issue_no: issue_no },
    });
    for (let label of labels) {
      await issueLabelModel.create({
        issue_no: issue_no,
        label_no: label,
      });
    }
    return res.status(200).json({ success: true });
  } catch (error) {
    return res.status(400).json({ success: false });
  }
};
