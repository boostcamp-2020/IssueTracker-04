const issueCommentModel = require('../../models').issue_comment;

exports.getCommentList = async (req, res, next) => {
  try {
    const commentData = await issueCommentModel.findAll({
      attributes: [
        'comment_no',
        'issue_no',
        'comment',
        'author_no',
        'comment_date',
      ],
      where: { issue_no: req.params.issue_no },
    });

    let commentList = [];
    let commentJson = {};

    for (const comment of commentData) {
      commentJson = {
        comment_no: comment.dataValues.comment_no,
        issue_no: comment.dataValues.issue_no,
        comment: comment.dataValues.comment,
        author_no: comment.dataValues.author_no,
        comment_date: comment.dataValues.comment_date,
      };

      commentList.push(commentJson);
    }
    res.status(200).json(commentList);
  } catch (err) {
    res.status(400).json({ message: 'get comment list error' });
  }
};

exports.addComment = async (req, res, next) => {
  const { issue_no, comment } = req.body;
  const author_no = res.locals.userNo
  const comment_date= new Date();
  try {
    const newComment = await issueCommentModel.create({
      issue_no: issue_no,
      comment: comment,
      author_no: author_no,
      comment_date: comment_date,
    });

    res.status(200).json({
      success: true,
      message: 'update succeed',
      comment_no: newComment.get({ plain: true }).comment_no,
    });
  } catch (err) {
    console.log(err);
    res.status(400).json({ success: false, message: 'add comment error' });
  }
};

exports.updateComment = async (req, res, next) => {
  const { issue_no, comment, author_no, comment_date } = req.body;

  try {
    const updatedComment = await issueCommentModel.update(
      {
        issue_no: issue_no,
        comment: comment,
        author_no: author_no,
        comment_date: comment_date,
      },
      { where: { comment_no: req.params.comment_no } }
    );

    res.status(200).json({ success: true, message: 'update succeed' });
  } catch (err) {
    res.status(400).json({ success: false, message: 'update comment error' });
  }
};

exports.deleteComment = async (req, res, next) => {
  try {
    const deletedComment = await issueCommentModel.destroy({
      where: { comment_no: req.params.comment_no },
    });

    res.status(200).json({ success: true, message: 'delete succeed' });
  } catch (err) {
    res.status(400).json({ success: false, message: 'delete comment error' });
  }
};
