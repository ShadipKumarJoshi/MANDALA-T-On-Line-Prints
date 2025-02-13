const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    fullName: {
        type: String,
        required: true
    },
    userName: {
        type: String,
        required: true,
    },
    phoneNumber: {
        type: String,
        required: true,
        unique: true
    },
    email: {
        type: String,
        required: true,
        unique: true
    },
    password: {
        type: String,
        required: true
    },

    resetPasswordOTP: {
        type: Number,
        default: null 
    },

    resetPasswordExpires: {
        type: Date,
        default: null 
    },

    // Admin fixation manually
    isAdmin: {
        type: Boolean,
        default: false
    },
    userImage: {
        type: String,
        default: 'defaultProfile.jpg'
        // default: 'https://cdn.britannica.com/22/187222-050-07B17FB6/apples-on-a-tree-branch.jpg'
    },
    userAddress: {
        type: String,
        default: null
    },
    userOptionalAddress: {
        type: String,
        default: null
    }
})

// },{ timestamps: true });

const User = mongoose.model('users', userSchema)
module.exports = User;
