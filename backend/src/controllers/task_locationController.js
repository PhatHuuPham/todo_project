const TaskLocation = require('../models/task_locationModel');

const task_locationController = {
    async createTaskLocation(req, res) {
        try {
            const task_location = await TaskLocation.create(req.body);
            res.status(201).send(task_location);
        } catch (error) {
            res.status(400).send(error);
        }
    },
    async getTaskLocations(req, res) {
        try {
            const task_locations = await TaskLocation.findAll();
            res.status(200).send(task_locations);
        } catch (error) {
            res.status(400).send(error);
        }
    },
    async getTaskLocation(req, res) {
        try {
            const task_location = await TaskLocation.findByPk(req.params.id);
            if (!task_location) {
                return res.status(404).send({ message: 'Task Location not found' });
            }
            res.status(200).send(task_location);
        } catch (error) {
            res.status(400).send(error);
        }
    },
    async updateTaskLocation(req, res) {
        try {
            const task_location = await TaskLocation.findByPk(req.params.id);
            if (!task_location) {
                return res.status(404).send({ message: 'Task Location not found' });
            }
            await task_location.update(req.body);
            res.status(200).send(task_location);
        } catch (error) {
            res.status(400).send(error);
        }
    },
    async deleteTaskLocation(req, res) {
        try {
            const task_location = await TaskLocation.findByPk(req.params.id);
            if (!task_location) {
                return res.status(404).send({ message: 'Task Location not found' });
            }
            await task_location.destroy();
            res.status(204).send();
        } catch (error) {
            res.status(400).send(error);
        }
    }
};

module.exports = task_locationController;