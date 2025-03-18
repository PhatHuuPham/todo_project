const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Task = require('./taskModel');
const User = require('./userModel');


const Task_category = sequelize.define('Task_category', {
    id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
    name: { type: DataTypes.STRING(100), unique: true, allowNull: false },
    user_id: { type: DataTypes.INTEGER, allowNull: true },
    description: { type: DataTypes.TEXT, defaultValue: null },
    created_at: { type: DataTypes.DATE, defaultValue: DataTypes.NOW }
}, { timestamps: false });

Task.belongsTo(Task_category, { foreignKey: 'category_id', onDelete: 'SET NULL' });
Task_category.hasMany(Task, { foreignKey: 'category_id' });
User.hasMany(Task_category, { foreignKey: 'user_id', onDelete: 'CASCADE' });
Task_category.belongsTo(User, { foreignKey: 'user_id' });

module.exports = Task_category;