const { statusCode } = require('../../config/statusCode');
const labelModel = require('../../models').label;

exports.getLabelList = async (req, res, next) => {
  try {
    const labels = await labelModel.findAll({ raw: true });
    return res
      .status(statusCode.SUCCESS)
      .json({ success: true, labels: labels });
  } catch (error) {
    return res.status(400).json({ success: false, labels: null });
  }
};

exports.createLabel = async (req, res, next) => {
  const { label_title, label_color, label_description } = req.body;
  try {
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
  } catch (error) {
    res.status(400).json({
      success: false,
      message: '레이블 생성 실패',
      label_no: null,
    });
  }
};
