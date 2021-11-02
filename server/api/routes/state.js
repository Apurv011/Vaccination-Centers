const express = require('express');
const router = express.Router();
//const checkAuth = require('../middleware/check-auth');

const StateController = require('../controllers/state');

router.get('/', StateController.getAllStates);

router.get('/:stateName', StateController.getOneState);

module.exports = router;
