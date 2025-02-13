const mongoose = require('mongoose');

const designSchema = new mongoose.Schema({
    designName: {
        type: String,
        required: true
    },
    designPrice: {
        type: Number,
        required: true
    },
    designCategory: {
        type: String,
        required: true
    },
    designDescription: {
        type: String,
        required: true,
        maxLength: 500
    },
    designImage: {
        type: String,
        required: true
    },
    // austomatic date of creation of design
    createAt: {
        type: Date,
        default: Date.now()
    },

    // ID of the user who created the design
    createdBy: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'users', // Referencing the users model
        required: true
    }
})

const Design = mongoose.model('designs', designSchema)
module.exports = Design;
