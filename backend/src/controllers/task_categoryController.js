const Task_category = require('../models/task_categoryModel');

const task_categoryController = {
    async createTask_category(req, res) {
        try {
            const task_category = await Task_category.create(req.body);
            res.status(201).send(task_category);
        } catch (error) {
            res.status(400).send(error);
        }
    },
    async getTaskCategories(req, res) {
        try {
            const task_categories = await Task_category.findAll();
            res.status(200).send(task_categories);
        } catch (error) {
            res.status(400).send(error);
        }
    },
    async getTask_category(req, res) {
        try {
            const task_category = await Task_category.findByPk(req.params.id);
            if (!task_category) {
                return res.status(404).send({ message: 'Task Category not found' });
            }
            res.status(200).send(task_category);
        } catch (error) {
            res.status(400).send(error);
        }
    },

    async getTaskCategoryByUserId(req, res) {
        try {
            const task_categories = await Task_category.findAll({
                where: {
                    user_id: req.params.userId
                }
            });
            if (!task_categories.length) {
                return res.status(404).send({ message: 'No task categories found for this user' });
            }
            res.status(200).send(task_categories);
        } catch (error) {
            res.status(400).send(error);
        }
    },

    async updateTask_category(req, res) {
        try {
            const task_category = await Task_category.findByPk(req.params.id);
            if (!task_category) {
                return res.status(404).send({ message: 'Task Category not found' });
            }
            await task_category.update(req.body);
            res.status(200).send(task_category);
        } catch (error) {
            res.status(400).send(error);
        }
    },
    async deleteTask_category(req, res) {
        try {
            const task_category = await Task_category.findByPk(req.params.id);
            if (!task_category) {
                return res.status(404).send({ message: 'Task Category not found' });
            }
            await task_category.destroy();
            res.status(204).send();
        } catch (error) {
            res.status(400).send(error);
        }
    }
};

module.exports = task_categoryController;