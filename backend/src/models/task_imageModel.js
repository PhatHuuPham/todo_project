const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Task = require('./taskModel');

const TaskImage = sequelize.define('Task_image', {
    id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
    task_id: { type: DataTypes.INTEGER, allowNull: false },
    image_url: { type: DataTypes.TEXT, allowNull: false },
    uploaded_at: { type: DataTypes.DATE, defaultValue: DataTypes.NOW }
}, { timestamps: false });

Task.hasMany(TaskImage, { foreignKey: 'task_id', onDelete: 'CASCADE' });
TaskImage.belongsTo(Task, { foreignKey: 'task_id' });


module.exports = TaskImage;