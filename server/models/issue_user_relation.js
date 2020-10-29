const Sequelize = require('sequelize');

module.exports = function (sequelize, DataTypes) {
  return sequelize.define(
    'issue_user_relation',
    {
      iu_relation_no: {
        autoIncrement: true,
        type: DataTypes.INTEGER(11),
        allowNull: false,
        primaryKey: true,
      },
      user_no: {
        type: DataTypes.INTEGER(11),
        allowNull: false,
        references: {
          model: 'user',
          key: 'user_no',
        },
        unique: 'FK_issue_user_relation_user',
      },
      issue_no: {
        type: DataTypes.INTEGER(11),
        allowNull: false,
        references: {
          model: 'issue',
          key: 'issue_no',
        },
        unique: 'FK_issue_user_relation_issue',
      },
    },
    {
      sequelize,
      tableName: 'issue_user_relation',
      timestamps: false,
    }
  );
};
