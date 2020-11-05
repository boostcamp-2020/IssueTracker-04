const Sequelize = require('sequelize');

module.exports = function (sequelize, DataTypes) {
  return sequelize.define(
    'issue_label_relation',
    {
      il_relation_no: {
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
        unique: 'FK_issue_label_relation_issue',
      },
      label_no: {
        type: DataTypes.INTEGER(11),
        allowNull: false,
        references: {
          model: 'label',
          key: 'label_no',
        },
        unique: 'FK_issue_label_relation_label',
      },
    },
    {
      sequelize,
      tableName: 'issue_label_relation',
      timestamps: false,
    }
  );
};
