const express = require('express');
require('dotenv').config();
const cors = require('cors');
// const http = require('http');
// const socketIo = require('socket.io');

const userRouter = require('./routers/userRouter');
const taskRouter = require('./routers/taskRouter');
const Task_categoryRouter = require('./routers/task_categoryRouter');
const taskImageRouter = require('./routers/task_imageRouter');
const taskLocationRouter = require('./routers/task_locationRouter');
const taskShareRouter = require('./routers/task_shareRouter');
const authRouter = require('./routers/authRouter');
const sequelize = require('./config/database');

const app = express();
const port = process.env.PORT || 8000;

// Middleware to parse JSON bodies
app.use(express.json());

// Middleware to enable CORS
app.use(cors());

// const server = http.createServer(app);
// const io = socketIo(server, {
//     cors: {
//         origin: '*',
//     }
// });

// io.on('connection', (socket) => {
//     console.log('User connected');

//     socket.on('client', (data) => {
//         socket.join(room);
//     });

//     socket.on('disconnect', () => {
//         console.log('User disconnected');
//     });
// });



app.use(userRouter);
app.use(taskRouter);
app.use(Task_categoryRouter);
app.use(taskImageRouter);
app.use(taskLocationRouter);
app.use(taskShareRouter);
app.use(authRouter);

// Middleware to handle errors
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Something broke!');
});

// Check database connection and start server
sequelize.authenticate()
    .then(() => {
        console.log('Connected to database');
        app.listen(port,() => {
            console.log(`Server running at http://localhost:${port}`);
        });
    })
    .catch((error) => {
        console.error('Error connecting to database: ' + error);
    });