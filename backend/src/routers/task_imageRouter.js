const express = require('express');
const router = express.Router();
const taskImageController = require('../controllers/task_imageController');

router.post('/task_images', taskImageController.createTaskImage);
router.get('/task_images', taskImageController.getTaskImages);
router.get('/task_images/:id', taskImageController.getTaskImage);
router.put('/task_images/:id', taskImageController.updateTaskImage);
router.delete('/task_images/:id', taskImageController.deleteTaskImage);

module.exports = router;