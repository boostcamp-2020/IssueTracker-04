const { statusCode } = require('../../config/statusCode');
const labelModel = require('../../models').label;

exports.getLabelList = async (req, res, next) => {
  const labels = await labelModel.findAll({ raw: true });
  return res.status(statusCode.SUCCESS).json({ success: true, labels: labels });
};

exports.createLabel = async (req, res, next) => {
  const { label_title, label_color, label_description } = req.body;
  const result = await labelModel.create({
    label_title: label_title,
    label_color: label_color,
    label_description: label_description,
  });
  res.status(statusCode.SUCCESS).json({
    success: true,
    message: 'label is inserted',
    label_no: result.get({ plain: true }).label_no,
  });
};
