const User = require('../models/userModel');
const bcrypt = require("bcryptjs");


const userController = {
    async createUser(req, res) {
        try {
            const {password, ...other} = req.body;
            // Hash mật khẩu trước khi lưu vào database
        const saltRounds = 10; // Số vòng băm, 10 là đủ mạnh
        const hashedPassword = await bcrypt.hash(password, saltRounds);
        // tạo user với mật khẩu đã hash
        const user = await User.create({...other, password: hashedPassword});
            res.status(201).send(user);
        } catch (error) {
            res.status(400).send(error);
        }
    },
    async getUsers(req, res) {
        try {
            const users = await User.findAll();
            res.status(200).send(users);
        } catch (error) {
            res.status(400).send(error);
        }
    },
    async getUser(req, res) {
        try {
            const user = await User.findByPk(req.params.id);
            if (!user) {
                return res.status(404).send({ message: 'User not found' });
            }
            res.status(200).send(user);
        } catch (error) {
            res.status(400).send(error);
        }
    },
    async updateUser(req, res) {
        try {
            const user = await User.findByPk(req.params.id);
            if (!user) {
                return res.status(404).send({ message: 'User not found' });
            }
            await user.update(req.body);
            res.status(200).send(user);
        } catch (error) {
            res.status(400).send(error);
        }
    },
    async deleteUser(req, res) {
        try {
            const user = await User.findByPk(req.params.id);
            if (!user) {
                return res.status(404).send({ message: 'User not found' });
            }
            await user.destroy();
            res.status(204).send();
        } catch (error) {
            res.status(400).send(error);
        }
    }
}

module.exports = userController;