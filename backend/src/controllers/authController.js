const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const User = require('../models/userModel');

const JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key';
const REFRESH_SECRET = process.env.REFRESH_SECRET || 'your-refresh-secret-key';
const accessTokenExpiry = '15m';
const refreshTokenExpiry = '7d';

// Store for refresh tokens (consider using Redis in production)
const refreshTokens = new Set();

const authController = {
    async login(req, res) {
        try {
            const { userInput, password } = req.body;

            if (!userInput || !password) {
                return res.status(400).json({ message: 'Email or username and password are required' });
            }

            const isEmail = userInput.includes('@');

                    // Tìm user theo email hoặc username
            const user = await User.findOne({
                where: isEmail ? { email: userInput } : { username: userInput }
            });

            // const user = await User.findOne({ where: { email } });

            if (!user) {
                return res.status(401).json({ message: 'Invalid credentials user' });
            }

            const isValidPassword = await bcrypt.compare(password, user.password);
            if (!isValidPassword) {
                return res.status(401).json({ message: 'Invalid credentials password' });
            }
            const accessToken = jwt.sign(
                { id: user.id, email: user.email },
                JWT_SECRET,
                { expiresIn: accessTokenExpiry }
            );

            const refreshToken = jwt.sign(
                { id: user.id },
                REFRESH_SECRET,
                { expiresIn: refreshTokenExpiry }
            );

            // Store refresh token
            refreshTokens.add(refreshToken);

            // Set refresh token in HTTP-only cookie
            res.cookie('refreshToken', refreshToken, {
                httpOnly: true,
                secure: process.env.NODE_ENV === 'production',
                sameSite: 'strict',
                maxAge: 7 * 24 * 60 * 60 * 1000 // 7 days
            });

            res.status(200).json({
                message: 'Login successful',
                accessToken,
                user: {
                    id: user.id,
                    username: user.username,
                    email: user.email
                }
            });
        } catch (error) {
            res.status(500).json({ message: 'Server error', error: error.message });
        }
    },

    async logout(req, res) {
        try {
            const refreshToken = req.cookies.refreshToken;
            
            if (refreshToken) {
                // Remove refresh token from storage
                refreshTokens.delete(refreshToken);
                
                // Clear the refresh token cookie
                res.clearCookie('refreshToken', {
                    httpOnly: true,
                    secure: process.env.NODE_ENV === 'production',
                    sameSite: 'strict'
                });
            }

            res.status(200).json({ message: 'Logged out successfully' });
        } catch (error) {
            res.status(500).json({ message: 'Server error', error: error.message });
        }
    },

    async refreshToken(req, res) {
        try {
            const refreshToken = req.cookies.refreshToken;

            if (!refreshToken) {
                return res.status(401).json({ message: 'No refresh token provided' });
            }

            if (!refreshTokens.has(refreshToken)) {
                return res.status(403).json({ message: 'Refresh token is invalid or expired' });
            }

            jwt.verify(refreshToken, REFRESH_SECRET, (err, decoded) => {
                if (err) {
                    refreshTokens.delete(refreshToken);
                    return res.status(403).json({ message: 'Invalid refresh token' });
                }

                const newAccessToken = jwt.sign(
                    { id: decoded.id },
                    JWT_SECRET,
                    { expiresIn: accessTokenExpiry }
                );

                res.status(200).json({ accessToken: newAccessToken });
            });
        } catch (error) {
            res.status(500).json({ message: 'Server error', error: error.message });
        }
    }
};

module.exports = authController;