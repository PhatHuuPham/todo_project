const express = require('express');
const router = express.Router();
const taskShareController = require('../controllers/task_shareController');

router.post('/task_shares', taskShareController.createTaskShare);
router.get('/task_shares', taskShareController.getTaskShares);
router.get('/task_shares/:id', taskShareController.getTaskShare);
router.put('/task_shares/:id', taskShareController.updateTaskShare);
router.delete('/task_shares/:id', taskShareController.deleteTaskShare);

module.exports = router;