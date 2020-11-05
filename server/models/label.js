const Sequelize = require('sequelize');

module.exports = function (sequelize, DataTypes) {
  return sequelize.define(
    'label',
    {
      label_no: {
        autoIncrement: true,
        type: DataTypes.INTEGER(11),
        allowNull: false,
        primaryKey: true,
      },
      label_title: {
        type: DataTypes.STRING(45),
        allowNull: false,
      },
      label_color: {
        type: DataTypes.STRING(45),
        allowNull: false,
      },
      label_description: {
        type: DataTypes.STRING(45),
        allowNull: true,
      },
    },
    {
      sequelize,
      tableName: 'label',
      timestamps: false,
    }
  );
};
