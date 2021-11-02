const express = require('express');
const router = express.Router();
//const checkAuth = require('../middleware/check-auth');

const CenterController = require('../controllers/center');

router.get('/', CenterController.getAllCenters);

router.get('/:centerId', CenterController.getCenterByID);

router.get('/district/:districtName', CenterController.centersInDistrict);

router.get('/state/:stateName', CenterController.centersInState);

router.get('/pincode/:pincode', CenterController.centersByPincode);

router.get('/lat-long/:lat/:long', CenterController.centerByLatLong);

router.get('/nearMe/:lat/:long', CenterController.centerNearMe);

module.exports = router;
