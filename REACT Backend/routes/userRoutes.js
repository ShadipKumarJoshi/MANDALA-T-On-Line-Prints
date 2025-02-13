// Imports
const router = require('express').Router();
const userController = require('../controllers/userControllers')
const { authGuard } = require('../middleware/authGuard');

// Creating user registration route.
// make all required route:  4 method; POST, GET, PUT, DELETE

//  controller(export)-> Routes (import)-> use ->index.js 
// register routes
router.post('/createUser', userController.createUser)

// login routes
router.post('/loginUser', userController.loginUser)

// forgot Password by phone number
router.post('/forgotPassword', userController.forgotPassword)

// verify OTP and reset password
router.post('/verifyOtpAndSetPassword', userController.verifyOtpAndSetPassword)

// forgot Password by email
router.post('/forgotPasswordByEmail', userController.forgotPasswordByEmail)

router.get("/reset-password-email/:id/:token", userController.getResetPasswordByEmail)

router.post("/reset-password-email/:id/:token", userController.postResetPasswordByEmail)



// User profile route (GET)
router.get('/getUser', authGuard, userController.getUserProfile);

// User update route (PUT)
router.put('/updateUserProfile', authGuard, userController.updateUserProfile);

// User update settings route (PUT)
router.put('/updateUserSettings', authGuard, userController.updateUserSettings);

// User delete route (DELETE)
router.delete('/deleteUser', authGuard, userController.deleteUser);

router.post("/getToken", userController.getToken);

// Exporting the routes
module.exports = router

