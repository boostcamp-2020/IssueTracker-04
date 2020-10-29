const Sequelize = require('sequelize');

module.exports = function (sequelize, DataTypes) {
  return sequelize.define(
    'milestone',
    {
      milestone_no: {
        autoIncrement: true,
        type: DataTypes.INTEGER(11),
        allowNull: false,
        primaryKey: true,
      },
      milestone_title: {
        type: DataTypes.STRING(45),
        allowNull: true,
      },
      milestone_description: {
        type: DataTypes.STRING(45),
        allowNull: true,
      },
      due_date: {
        type: DataTypes.DATE,
        allowNull: true,
      },
    },
    {
      sequelize,
      tableName: 'milestone',
      timestamps: false,
    }
  );
};
