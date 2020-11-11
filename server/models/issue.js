const Sequelize = require('sequelize');

module.exports = function (sequelize, DataTypes) {
  const issue = sequelize.define(
    'issue',
    {
      issue_no: {
        autoIncrement: true,
        type: DataTypes.INTEGER(11),
        allowNull: false,
        primaryKey: true,
      },
      issue_title: {
        type: DataTypes.STRING(45),
        allowNull: false,
      },
      issue_author_no: {
        type: DataTypes.INTEGER(11),
        allowNull: true,
        references: {
          model: 'user',
          key: 'user_no',
        },
        unique: 'FK_issue_user',
      },
      issue_date: {
        type: DataTypes.DATE,
        allowNull: false,
      },
      issue_flag: {
        type: DataTypes.INTEGER(1),
        allowNull: false,
      },
      issue_content: {
        type: DataTypes.STRING(45),
        allowNull: false,
      },
      milestone_no: {
        type: DataTypes.INTEGER(11),
        allowNull: true,
        references: {
          model: 'milestone',
          key: 'milestone_no',
        },
        unique: 'FK_issue_milestone',
      },
    },
    {
      sequelize,
      tableName: 'issue',
      timestamps: false,
    }
  );

  issue.associate = function (models) {
    issue.belongsTo(models.milestone, {
      foreignKey: 'milestone_no',
    });
  };

  return issue;
};
