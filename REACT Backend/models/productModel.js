const mongoose = require('mongoose');

const productSchema = new mongoose.Schema({
    productCategory: {
        type: String,
        required: true
    },
    productPrice: {
        type: Number,
        required: true
    },
    productSize: {
        type: [String],
        required: true
    },
    productColor: {
        type: [String],
        required: true
    },
    productDescription: {
        type: String,
        required: true,
        maxLength: 500
    },
    productImage: {
        type: String,
        required: true
    },
    // austomatic date of creation of product
    createAt: {
        type: Date,
        default: Date.now()
    }
})

const Product = mongoose.model('products', productSchema)
module.exports = Product;
