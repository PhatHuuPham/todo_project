const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const User = require('./userModel');

const Task = sequelize.define('Task', {
    id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
    user_id: { type: DataTypes.INTEGER, allowNull: true },
    title: { type: DataTypes.STRING(255), allowNull: false },
    description: { type: DataTypes.TEXT, defaultValue: null },
    category_id: { type: DataTypes.INTEGER, defaultValue: null },
    due_date: { type: DataTypes.DATE, defaultValue: null },
    status: { type: DataTypes.ENUM('pending', 'in_progress', 'completed'), defaultValue: 'pending' },
    priority: { type: DataTypes.ENUM('low', 'medium', 'high'), defaultValue: 'medium' },
    isSynced: {type: DataTypes.BOOLEAN},
    created_at: { type: DataTypes.DATE, defaultValue: DataTypes.NOW },
    updated_at: { type: DataTypes.DATE, defaultValue: DataTypes.NOW }
}, { timestamps: false });

User.hasMany(Task, { foreignKey: 'user_id', onDelete: 'CASCADE' });
Task.belongsTo(User, { foreignKey: 'user_id' });

module.exports = Task;