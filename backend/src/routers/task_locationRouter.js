const express = require('express');
const router = express.Router();
const taskLocationController = require('../controllers/task_locationController');

router.post('/task_locations', taskLocationController.createTaskLocation);
router.get('/task_locations', taskLocationController.getTaskLocations);
router.get('/task_locations/:id', taskLocationController.getTaskLocation);
router.put('/task_locations/:id', taskLocationController.updateTaskLocation);
router.delete('/task_locations/:id', taskLocationController.deleteTaskLocation);

module.exports = router;