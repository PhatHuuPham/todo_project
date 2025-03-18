const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Task = require('./taskModel');

const TaskSharing = sequelize.define('Task_sharing', {
    id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
    task_id: { type: DataTypes.INTEGER, allowNull: false },
    shared_with_user_id: { type: DataTypes.INTEGER, allowNull: false },
    permission: { type: DataTypes.ENUM('read', 'edit', 'owner'), defaultValue: 'read' },
    shared_at: { type: DataTypes.DATE, defaultValue: DataTypes.NOW }
}, { timestamps: false });

Task.hasMany(TaskSharing, { foreignKey: 'task_id', onDelete: 'CASCADE' });
TaskSharing.belongsTo(Task, { foreignKey: 'task_id' });

module.exports = TaskSharing;