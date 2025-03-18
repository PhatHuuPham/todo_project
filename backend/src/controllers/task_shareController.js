const TaskShare = require('../models/task_shareModel');

const task_shareController = {
    async createTaskShare(req, res) {
        try {
            const task_share = await TaskShare.create(req.body);
            res.status(201).send(task_share);
        } catch (error) {
            res.status(400).send(error);
        }
    },
    async getTaskShares(req, res) {
        try {
            const task_shares = await TaskShare.findAll();
            res.status(200).send(task_shares);
        } catch (error) {
            res.status(400).send(error);
        }
    },
    async getTaskShare(req, res) {
        try {
            const task_share = await TaskShare.findByPk(req.params.id);
            if (!task_share) {
                return res.status(404).send({ message: 'Task Share not found' });
            }
            res.status(200).send(task_share);
        } catch (error) {
            res.status(400).send(error);
        }
    },
    async updateTaskShare(req, res) {
        try {
            const task_share = await TaskShare.findByPk(req.params.id);
            if (!task_share) {
                return res.status(404).send({ message: 'Task Share not found' });
            }
            await task_share.update(req.body);
            res.status(200).send(task_share);
        } catch (error) {
            res.status(400).send(error);
        }
    },
    async deleteTaskShare(req, res) {
        try {
            const task_share = await TaskShare.findByPk(req.params.id);
            if (!task_share) {
                return res.status(404).send({ message: 'Task Share not found' });
            }
            await task_share.destroy();
            res.status(204).send();
        } catch (error) {
            res.status(400).send(error);
        }
    }
};

module.exports = task_shareController;