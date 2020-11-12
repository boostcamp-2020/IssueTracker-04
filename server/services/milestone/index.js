const { statusCode } = require('../../config/statusCode');
const issueModel = require('../../models').issue;
const milestoneModel = require('../../models').milestone;
const fn = require('../../models').Sequelize.fn;
/**
 * 
 {
  "success": true,
  "milestones": [
    {
      "milestone_no": 0,
      "milestone_title": "string",
      "milestone_description": "string",
      "percent": 0,
      "open_issue_count": 0,
      "closed_issue_count": 0
    }
  ]
}
 */

exports.getMilestoneList = async (req, res, next) => {
  try {
    const issuesGroup = await issueModel.findAll({
      attributes: ['milestone_no', 'issue_flag', [fn('count', '*'), 'count']],
      group: ['milestone_no', 'issue_flag'],
      raw: true,
    });
    const milestones = await milestoneModel.findAll({ raw: true });
    const formatted = formatting(issuesGroup, milestones);
    return res
      .status(200)
      .json({ success: true, milestones: Object.values(formatted) });
  } catch (error) {
    return res.status(400).json({ success: false, milestones: null });
  }
};

const formatting = (issuesGroup, milestones) => {
  const list = {};
  listInit(list, milestones);
  addOpenClosed(list, issuesGroup);
  addPercent(list);
  return list;
};

const listInit = (list, milestones) => {
  milestones.forEach((e) => {
    list[e.milestone_no] = { ...e, open_issue_count: 0, closed_issue_count: 0 };
  });
};

const addOpenClosed = (list, issuesGroup) => {
  issuesGroup.forEach((e) => {
    const cntObj = {};
    if (e.milestone_no) {
      if (e.issue_flag === 1) {
        cntObj.open_issue_count = e.count;
      } else {
        cntObj.closed_issue_count = e.count;
      }
      list[e.milestone_no] = { ...list[e.milestone_no], ...cntObj };
    }
  });
};

const addPercent = (list) => {
  Object.keys(list).forEach((key) => {
    const open = list[key].open_issue_count;
    const closed = list[key].closed_issue_count;
    let percent = 0;
    if (open + closed !== 0)
      percent = Math.round((closed / (open + closed)) * 100);
    list[key] = { ...list[key], percent: percent };
  });
};

exports.createMilestone = async (req, res, next) => {
  const { milestone_title, milestone_description, due_date } = req.body;
  try {
    const result = await milestoneModel.create({
      milestone_title: milestone_title,
      milestone_description: milestone_description,
      due_date: due_date,
    });
    res.status(statusCode.SUCCESS).json({
      success: true,
      message: 'milestone is inserted',
      milestone_no: result.get({ plain: true }).milestone_no,
    });
  } catch (error) {
    res.status(400).json({
      success: false,
      message: '마일스톤 생성 실패',
      milestone_no: null,
    });
  }
};

exports.updateMilestone = async (req, res, next) => {
  const { milestone_no } = req.params;
  const { milestone_title, milestone_description, due_date } = req.body;

  try {
    const milestone = await milestoneModel.update(
      {
        milestone_title: milestone_title,
        milestone_description: milestone_description,
        due_date: due_date,
      },
      { where: { milestone_no: milestone_no } }
    );

    res.status(200).json({ success: true, message: 'update succeed' });
  } catch (error) {
    res.status(400).json({ success: false, message: 'update fail' });
  }
};

exports.deleteMilestone = async (req, res, next) => {
  const { milestone_no } = req.params;
  try {
    const milestone = await milestoneModel.destroy({
      where: { milestone_no: milestone_no },
    });

    res.status(200).json({ success: true, message: 'delete succeed' });
  } catch (error) {
    res.status(400).json({ success: false, message: 'delete fail' });
  }
};
