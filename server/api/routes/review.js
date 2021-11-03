const express = require('express');
const router = express.Router();
//const checkAuth = require('../middleware/check-auth');

const ReviewController = require('../controllers/review');

router.get('/', ReviewController.getAllReviews);

router.get('/:centerId', ReviewController.getReviewByCenter);

router.post('/', ReviewController.writeReview);

module.exports = router;
