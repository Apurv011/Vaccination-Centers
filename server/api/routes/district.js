const express = require('express');
const router = express.Router();
//const checkAuth = require('../middleware/check-auth');

const DistrictController = require('../controllers/district');

router.get('/', DistrictController.getAllDistricts);

router.get('/:dName', DistrictController.getOneDistrict);

router.get('/state/:stateName', DistrictController.getDistrictsInState);

module.exports = router;
