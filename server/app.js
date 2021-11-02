const express = require('express');
const morgan = require('morgan');
const bodyParser = require('body-parser');

const stateRoutes = require('./api/routes/state');
const districtRoutes = require('./api/routes/district');
const centerRoutes = require('./api/routes/center');

const app = express();

// Log request data
app.use(morgan('dev'));

// Use body parser middleware to parse body of incoming requests
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

// Setup CORS
app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization');
    if (req.method === 'OPTIONS') {
        res.header('Access-Control-Allow-Methods', 'PUT, POST, PATCH, DELETE, GET');
        return res.status(200).json({});
    }
    next();
});

// Routes which should handle requests
app.use('/state', stateRoutes);
app.use('/district', districtRoutes);
app.use('/center', centerRoutes);

// Handle Error Requests
app.use((req, res, next) => {
    const error = new Error();
    error.message = 'Not Found';
    error.status = 404;
    next(error);
});

app.use((error, req, res, next) => {
    res.status(error.status || 500).json({
        error: error,
    });
});

module.exports = app;
