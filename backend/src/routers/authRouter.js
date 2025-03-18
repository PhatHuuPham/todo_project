const express = require('express');
const authController = require('../controllers/authController');

// filepath: d:\project\todo_app\backend\src\routers\authRouter.js
const router = express.Router();

// Login route
router.post('/auth/login', authController.login);

// Logout route
router.post('/auth/logout', authController.logout);

// Refresh token route
router.post('/auth/refresh-token', authController.refreshToken);

module.exports = router;