const Sequelize = require('sequelize');

module.exports = function (sequelize, DataTypes) {
  return sequelize.define(
    'user',
    {
      user_no: {
        autoIncrement: true,
        type: DataTypes.INTEGER(11),
        allowNull: false,
        primaryKey: true,
      },
      user_id: {
        type: DataTypes.STRING(45),
        allowNull: false,
      },
      user_password: {
        type: DataTypes.STRING(64),
        allowNull: true,
      },
      oauth_site: {
        type: DataTypes.STRING(45),
        allowNull: false,
      },
      user_img: {
        type: DataTypes.STRING(45),
        allowNull: false,
      },
      user_name: {
        type: DataTypes.STRING(45),
        allowNull: false,
      },
    },
    {
      sequelize,
      tableName: 'user',
      timestamps: false,
    }
  );
};
