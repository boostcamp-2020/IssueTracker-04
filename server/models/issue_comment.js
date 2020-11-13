const Sequelize = require('sequelize');

module.exports = function (sequelize, DataTypes) {
  return sequelize.define(
    'issue_comment',
    {
      comment_no: {
        autoIncrement: true,
        type: DataTypes.INTEGER(11),
        allowNull: false,
        primaryKey: true,
      },
      issue_no: {
        type: DataTypes.INTEGER(11),
        allowNull: false,
        references: {
          model: 'issue',
          key: 'issue_no',
        },
        unique: 'FK_issue_comment_issue',
      },
      comment: {
        type: DataTypes.STRING(45),
        allowNull: false,
      },
      author_no: {
        type: DataTypes.INTEGER(11),
        allowNull: true,
        references: {
          model: 'user',
          key: 'user_no',
        },
        unique: 'FK_issue_comment_user',
      },
      comment_date: {
        type: DataTypes.DATE,
        allowNull: false,
      },
    },
    {
      sequelize,
      tableName: 'issue_comment',
      timestamps: false,
    }
  );
};
