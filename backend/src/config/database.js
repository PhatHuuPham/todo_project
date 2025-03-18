require ('dotenv').config();
const { Sequelize } = require('sequelize');

const mysql = require('mysql2');

// const connection = mysql.createConnection({
//     host: process.env.DB_HOST,
//     user: process.env.DB_USER,
//     password: process.env.DB_PASSWORD,
//     database: process.env.DB_NAME
// });

const sequelize = new Sequelize(process.env.DB_NAME, process.env.DB_USER, process.env.DB_PASSWORD, {
    host: process.env.DB_HOST,
    dialect: 'mysql'
});

sequelize.authenticate()
    .then(() => {
        console.log('Connected to database');
    })
    .catch((error) => {
        console.error('Error connecting to database: ' + error);
    });

// connection.connect((err) => {
//     if (err) {
//         console.error('Error connecting to database: ' + err.stack);
//         return;
//     }
//     console.log('Connected to database with threadId: ' + connection.threadId);
// });

module.exports = sequelize;