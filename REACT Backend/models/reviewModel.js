const mongoose = require('mongoose');

const reviewSchema = new mongoose.Schema({
    reviewName: {
        type: String,
        required: true
    },
      
    reviewDescription: {
        type: String,
        required: true,
        maxLength: 500
    },
    reviewImage: {
        type: String,
        required: true
    },
    reviewRating: {
        type: String,
        required: true
    },
    // austomatic date of creation of review
    createAt: {
        type: Date,
        default: Date.now()
    },

    
})

const Review = mongoose.model('reviews', reviewSchema)
module.exports = Review;
