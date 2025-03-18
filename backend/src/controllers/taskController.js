const Task = require('../models/taskModel');

const taskController = {
    async createTask(req, res) {
        try {
            const task = await Task.create(req.body);
            res.status(201).send(task);
        } catch (error) {
            res.status(400).send(error);
        }
    },
    async getTasks(req, res) {
        try {
            const tasks = await Task.findAll();
            res.status(200).send(tasks);
        } catch (error) {
            res.status(400).send(error);
        }
    },
    async getTask(req, res) {
        try {
            const task = await Task.findByPk(req.params.id);
            if (!task) {
                return res.status(404).send({ message: 'Task not found' });
            }
            res.status(200).send(task);
        } catch (error) {
            res.status(400).send(error);
        }
    },
    async getTaskByUserId(req, res) {
        try {
            const tasks = await Task.findAll({
                where: {
                    user_id: req.params.userId
                }
            });
            if (!tasks.length) {
                return res.status(404).send({ message: 'No tasks found for this user' });
            }
            res.status(200).send(tasks);
        } catch (error) {
            res.status(400).send(error);
        }
    },
    async updateTask(req, res) {
        try {
            const task = await Task.findByPk(req.params.id);
            if (!task) {
                return res.status(404).send({ message: 'Task not found' });
            }
            await task.update(req.body);
            res.status(200).send(task);
        } catch (error) {
            res.status(400).send(error);
        }
    },
    async deleteTask(req, res) {
        try {
            const task = await Task.findByPk(req.params.id);
            if (!task) {
                return res.status(404).send({ message: 'Task not found' });
            }
            await task.destroy();
            res.status(204).send();
        } catch (error) {
            res.status(400).send(error);
        }
    }
};

module.exports = taskController;