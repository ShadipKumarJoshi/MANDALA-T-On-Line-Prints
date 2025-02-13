const router = require('express').Router();
const reviewController = require('../controllers/reviewControllers')

router.post('/createReview',  reviewController.createReview)

// fetch all  reviews by logged-in user
router.get('/getAllReviews', reviewController.getAllReviews)


module.exports = router