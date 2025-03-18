const TaskImage = require('../models/task_imageModel');

const task_imageController = {
    async createTaskImage(req, res) {
        try {
            const task_image = await TaskImage.create(req.body);
            res.status(201).send(task_image);
        } catch (error) {
            res.status(400).send(error);
        }
    },
    async getTaskImages(req, res) {
        try {
            const task_images = await TaskImage.findAll();
            res.status(200).send(task_images);
        } catch (error) {
            res.status(400).send(error);
        }
    },
    async getTaskImage(req, res) {
        try {
            const task_image = await TaskImage.findByPk(req.params.id);
            if (!task_image) {
                return res.status(404).send({ message: 'Task Image not found' });
            }
            res.status(200).send(task_image);
        } catch (error) {
            res.status(400).send(error);
        }
    },
    async updateTaskImage(req, res) {
        try {
            const task_image = await TaskImage.findByPk(req.params.id);
            if (!task_image) {
                return res.status(404).send({ message: 'Task Image not found' });
            }
            await task_image.update(req.body);
            res.status(200).send(task_image);
        } catch (error) {
            res.status(400).send(error);
        }
    },
    async deleteTaskImage(req, res) {
        try {
            const task_image = await TaskImage.findByPk(req.params.id);
            if (!task_image) {
                return res.status(404).send({ message: 'Task Image not found' });
            }
            await task_image.destroy();
            res.status(204).send();
        } catch (error) {
            res.status(400).send(error);
        }
    }
};

module.exports = task_imageController;