

const mongoose = require("mongoose");

const cartSchema = new mongoose.Schema({
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'users',
        required: true
    },
    productId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "products"
    },
    designId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "designs"
    },
    quantity: {
        type: Number,
        default: 1
    },
    productSize: {
        type: String,
        required: true
    },
    productColor: {
        type: String,
        required: true
    },
    customizePrice: {
        type: Number
    },
    total: {
        type: Number
    },
    status: { type: String, 
        default: "active" },

    createdAt: {
        type: Date,
        default: Date.now
    },
});

const Cart = mongoose.model("Cart", cartSchema);

module.exports = Cart;
