const { statusCode } = require('../../config/statusCode');
const milestoneModel = require('../../models').milestone;

exports.getMilestoneList = async (req, res, next) => {
  const milestones = await milestoneModel.findAll({ raw: true });
  return res.status(200).json({ success: true, milestones: milestones });
};

exports.createMilestone = async (req, res, next) => {
  const { milestone_title, milestone_description, due_date } = req.body;
  const result = await milestoneModel.create({
    milestone_title: milestone_title,
    milestone_description: milestone_description,
    due_date: due_date,
  });
  res.status(statusCode.SUCCESS).json({
    success: true,
    message: 'milestone is inserted',
    label_no: result.get({ plain: true }).milestone_no,
  });
};
