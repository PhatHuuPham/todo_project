const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Task = require('./taskModel');

const TaskLocation = sequelize.define('Task_location', {
    id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
    task_id: { type: DataTypes.INTEGER, allowNull: false },
    latitude: { type: DataTypes.DECIMAL(10,8), allowNull: false },
    longitude: { type: DataTypes.DECIMAL(11,8), allowNull: false },
    address: { type: DataTypes.STRING(255), defaultValue: null }
}, { timestamps: false });

Task.hasOne(TaskLocation, { foreignKey: 'task_id', onDelete: 'CASCADE' });
TaskLocation.belongsTo(Task, { foreignKey: 'task_id' });

module.exports = TaskLocation;