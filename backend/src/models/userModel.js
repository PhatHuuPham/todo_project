const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const User = sequelize.define('User', {
    id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
    username: { type: DataTypes.STRING(50), unique: true, allowNull: false },
    email: { type: DataTypes.STRING(100), unique: true, allowNull: false },
    password: { type: DataTypes.STRING(255), allowNull: false },
    avatar_url: { type: DataTypes.TEXT, defaultValue: null },
    created_at: { type: DataTypes.DATE, defaultValue: DataTypes.NOW }
}, { timestamps: false });

module.exports = User;