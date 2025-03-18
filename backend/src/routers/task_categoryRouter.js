const express = require('express');
const router = express.Router();
const Task_categoryController = require('../controllers/task_categoryController');

router.post('/task_categories', Task_categoryController.createTask_category);
router.get('/task_categories', Task_categoryController.getTaskCategories);
router.get('/task_categories/:id', Task_categoryController.getTask_category);
router.get('/task_categories/user/:userId', Task_categoryController.getTaskCategoryByUserId);
router.put('/task_categories/:id', Task_categoryController.updateTask_category);
router.delete('/task_categories/:id', Task_categoryController.deleteTask_category);

module.exports = router;