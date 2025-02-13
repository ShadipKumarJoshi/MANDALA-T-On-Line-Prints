const userModel = require('../models/userModel')
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')
const path = require('path')
const fs = require('fs') // fs= filesystem
const sendOtp = require('../service/sendOtp');
const nodemailer = require('nodemailer');
// const router = require('express').Router();


// const path = require('path')
// const fs = require('fs') // fs= filesystem

// This defines the createUser function, which is an asynchronous function 
// that takes req (request) and res (response) as parameters. 
// This function handles the logic for creating a new user.
const createUser = async (req, res) => {



    // res.send("Create user API is Working!")

    // -------------FLOW CHART of REGISTER algorithm--------------

    //1. Check incoming data
    //2. Destructure  the incoming data
    //3. Validate the data (check email and password is received/)
    //4. ERROR Handling ( TRY,CATCH)
    //5. Check if the user is already registered
    //---//5.1. if user found:Send response
    //---//---//5.1.1. Stop the process
    //--- //5.2. if user is new:
    //---//---//5.2.1. Hash the password
    //---//---//5.2.2. Save to the database
    //---//---//5.2.3. Swnd successful response
    //-------------------------------------------------------------

    // 1. and 2.  extract the relevant data (first name, last name, email, password) from the request body. 
    // It assumes that the request body contains JSON data with these fields.

    //1. Check incoming data
    console.log(req.body); // json is wrriten in raw of body of postman 

    //2. Destructure  the incoming data
    const { fullName, userName, phoneNumber, email, password } = req.body; // data is requested from body

    //3. Validate the data (check email and password is received/)
    // if empty, stop the process and send res(response)
    // This checks if any of the required fields (first name, last name, email, password) are missing from the request body. 
    // If any field is missing, it sends a JSON response indicating failure and a corresponding error message.
    if (!fullName || !userName || !phoneNumber || !email || !password) {
        // res.send("Please enter all fields!")
        // res.status(400).json() //dont use it as it is for proffesional use and can cause lots of errors
        res.status(400).json({
            "success": false,
            "message": "Please enter all fields!" // custom error handling
        })

    }

    //4. ERROR Handling ( TRY,CATCH)n
    try {
        //5. Check if the user is already registered. This structure is a try-catch block. 
        // The code inside the try block is the code that may throw an error. 
        // If an error occurs, it is caught by the catch block, where you can handle the error. 
        // In this case, if an error occurs during user creation, it sends a JSON response indicating an internal server error.
        // const existingUser = await userModel.findOne({ email: email })

        const existingUser = await userModel.findOne({
            $or: [
                { email: email },
                { phoneNumber: phoneNumber }
            ]
        })
        // first email is from database and second email is from destructuring

        //---//5.1. if user found:Send response
        if (existingUser) {
            return res.status(400).json({
                "success": false,
                "message": "User Already Exists!"
            })
        };

        // Default Profile  upload logic
        // if (!req.files || !req.files.userImage) {
        //     return res.status(400).json({
        //         success: false,
        //         message: 'Profile image not found!'
        //     });
        // }

        // const userImage = '../models/defaultProfile.jpg'; // Default image path
        // const imageName = `${Date.now()}-${userImage.name}`;
        // const imageUploadPath = path.join(__dirname, `../public/profile/${imageName}`);

        // Move the uploaded file to the specified path
        // await userImage.mv(imageUploadPath);

        //---//---//5.1.1. Stop the process

        // Hashing/Encryption of the password
        const randomSalt = await bcrypt.genSalt(10)
        const hashedPassword = await bcrypt.hash(password, randomSalt)

        //--- //5.2. if user is new:
        const newUser = new userModel({
            // Database Fields : Client's value
            fullName: fullName, // first from database, second is from destructuring from user input
            userName: userName,
            phoneNumber: phoneNumber,
            email: email,
            // password: password
            password: hashedPassword,
            // npm install bcrypt for installing package for password hashing
            // userImage: imageName // Save the image filename to the database
        })

        // save to the database
        await newUser.save()
        // send the response
        res.status(201).json({
            "success": true,
            "message": "User created Successfully!"
        })




        //---//---//5.2.1. Hash the password
        //---//---//5.2.2. Save to the database
        //---//---//5.2.3. Swnd successful response


    } catch (error) {
        console.log(error)
        res.status(500).json({
            "success": false,
            "message": "Internal Server Error!"
        })

    }




}


//  LOGIN Function
const loginUser = async (req, res) => {
    // res.send("Login API is working!")

    // -------------FLOW CHART of LOGIN Algorithm--------------

    //1. Check incoming data -email , password
    //2. Destructure  the incoming data
    //3. Validate the data (check email and password is received/)
    //4. ERROR Handling ( TRY,CATCH)
    //---//4.1. Find user (email)
    //---//4.2. not found (error message)
    //---//4.3. user found - compare password (bcrypt)
    //---//4.4. password not valid (error)
    //---//4.5. token (Generate - with user Data + KEY)
    //---//4.6. response (token, user data)

    //-------------------------------------------------------------

    // 1. Check incoming data - emailOrPhoneNumber, password
    console.log(req.body)


    // 2. Destructure  the incoming data
    const { emailOrPhoneNumber, password } = req.body;
    // 3. Validate the data (check emailOrPhoneNumber and password are received)
    if (!emailOrPhoneNumber || !password) {
        return res.status(400).json({
            "success": false,
            "message": "Please enter all fields!"
        })
    }
    // parsing emailOrPhoneNumber to tel from
    // const intEmailOrPhoneNumber =parseInt(emailOrPhoneNumber)

    // 4. ERROR Handling (TRY, CATCH)
    try {
        //---//4.1. Find user (email or phone number)
        const user = await userModel.findOne({
            $or: [
                { email: emailOrPhoneNumber },
                { phoneNumber: emailOrPhoneNumber }
                // { phoneNumber: intEmailOrPhoneNumber}
            ]
        });

        //---//4.2 If user not found, send error message
        if (!user) {
            return res.status(404).json({
                "success": false,
                "message": "User doesn't exist!"
            })
        }

        //---// 4.3. If user found, compare password (bcrypt)
        const isValidPassword = await bcrypt.compare(password, user.password);

        //---// 4.4. If password is not valid, send error
        if (!isValidPassword) {
            return res.status(400).json({
                "success": false,
                "message": "Password is wrong!"
            })
        }

        //---// 4.5. Generate token (with user Data + KEY)
        const token = await jwt.sign(
            { id: user._id, isAdmin: user.isAdmin }, // token id, mongo db id
            process.env.JWT_SECRET
        );

        //---// 4.6. Send response (token, user data)
        res.status(201).json({
            "success": true,
            "message": "User Login Successful",
            "token": token,
            "userData": user
        });

    } catch (error) {
        console.log(error);
        return res.status(500).json({
            "success": false,
            "message": "Internal Server Error!"
        });
    }
}

// get profile
// frontend : token
// token : authGuard : req.user
// userModel.findOne({_id : req.user.id})


const getUserProfile = async (req, res) => {
    try {
        const user = await userModel.findById(req.user.id)

        if (!user) {
            return res.status(400).json({
                success: false,
                message: "User not found"
            });
        }

        res.status(201).json({
            user: {
                fullName: user.fullName,
                userName: user.userName,
                phoneNumber: user.phoneNumber,
                email: user.email,
                userAddress: user.userAddress,
                userOptionalAddress: user.userOptionalAddress,
                userImage: user.userImage
                // userImage: user.userImage ? user.userImage : path.join(__dirname, 'defaultImage.jpg') // Path to default image
            }
        });

    } catch (error) {
        console.log(error);
        res.status(500).json({
            success: false,
            message: "Internal Server Error"
        });
    }
};

// Update User Profile function

const updateUserProfile = async (req, res) => {
    try {
        const { fullName, userName, userAddress, userOptionalAddress } = req.body;
        const user = await userModel.findById(req.user.id);

        if (!user) {
            return res.status(400).json({
                success: false,
                message: "User not found"
            });
        }

        // Update user fields
        user.fullName = fullName || user.fullName;
        user.userName = userName || user.userName;
        user.userAddress = userAddress || user.userAddress;
        user.userOptionalAddress = userOptionalAddress || user.userOptionalAddress;

        // Handle profile image

        // if there is image
        if (req.files && req.files.userImage) {

            // destructuring
            const { userImage } = req.files;

            // upload image to /public/products folder
            // 1. Generate new image name (abc.png) -> (213456-abc.png)
            const imageName = `${Date.now()}-${userImage.name}`

            // 2. Make a upload path (/path/uplad - directory)
            const imageUploadPath = path.join(__dirname, `../public/profile/${imageName}`)

            // Move to folder
            await userImage.mv(imageUploadPath)

            // req.params (id), req.body(updated data - pn,pp,pc,pd), req.files (image)
            // add new field to req.body (productImage -> name)
            req.body.userImage = imageName; // image uploaded (generated name)


            // If the current user image is not the default image, delete the old image
            if (req.body.userImage && req.body.userImage !== 'defaultProfile.jpg') {

                // Finding existing user
                const existingUser = await userModel.findById(req.user.id)


                // Searching in the directory/folder
                const oldImagePath = path.join(__dirname, `../public/profile/${user.userImage}`);

                // Delete old image from filesystem
                fs.unlinkSync(oldImagePath);
            }

        }

        // await user.save();

        // Update the data
        const updatedUser = await userModel.findByIdAndUpdate(req.user.id, req.body)
        res.status(201).json({
            success: true,
            message: "User updated!",
            user: updatedUser
        })

    } catch (error) {
        console.log(error)
        res.status(500).json({
            success: false,
            message: "Internal Server Error!",
            error: error
        })
    }

}

// Update User Settings function

const updateUserSettings = async (req, res) => {
    try {
        const { email, phoneNumber, currentPassword, newPassword } = req.body;
        const user = await userModel.findById(req.user.id);

        if (!user) {
            return res.status(400).json({
                success: false,
                message: "User not found"
            });
        }

        // Verify current password before making changes
        if (!currentPassword || !(await bcrypt.compare(currentPassword, user.password))) {
            return res.status(400).json({
                success: false,
                message: "Current password is incorrect"
            });
        }

        // Update email if provided and not in use by another user
        if (email && email !== user.email) {
            const existingEmailUser = await userModel.findOne({ email: email });
            if (existingEmailUser && existingEmailUser._id.toString() !== user._id.toString()) {
                return res.status(400).json({
                    success: false,
                    message: "Email already in use"
                });
            }
            user.email = email;
        }

        // Update phone number if provided and not in use by another user
        if (phoneNumber && phoneNumber !== user.phoneNumber) {
            const existingPhoneUser = await userModel.findOne({ phoneNumber: phoneNumber });
            if (existingPhoneUser && existingPhoneUser._id.toString() !== user._id.toString()) {
                return res.status(400).json({
                    success: false,
                    message: "Phone number already in use"
                });
            }
            user.phoneNumber = phoneNumber;
        }


        // Update password if newPassword is provided
        if (newPassword) {
            const randomSalt = await bcrypt.genSalt(10);
            user.password = await bcrypt.hash(newPassword, randomSalt);
        }




        // Update the data
        const updatedUser = await userModel.findByIdAndUpdate(req.user.id, req.body)
        res.status(201).json({
            success: true,
            message: "User updated!",
            user: updatedUser
        })




    } catch (error) {
        console.log(error)
        res.status(500).json({
            success: false,
            message: "Internal Server Error!",
            error: error
        })
    }

}


// Delete User Profile function
const deleteUser = async (req, res) => {
    try {
        const user = await userModel.findById(req.user.id);

        if (!user) {
            return res.status(400).json({
                success: false,
                message: "User not found"
            });
        }

        await userModel.findByIdAndDelete(req.user.id);

        res.status(201).json({
            success: true,
            message: "User deleted successfully"
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            success: false,
            message: "Internal Server Error"
        });
    }
};





// const deleteUser = async (req, res) => {
//     const { currentPassword } = req.body;

//     try {
//         const user = await userModel.findById(req.user.id);

//         if (!user) {
//             return res.status(400).json({
//                 success: false,
//                 message: "User not found"
//             });
//         }

//         const isMatch = await bcrypt.compare(currentPassword, user.password);

//         if (!isMatch) {
//             return res.status(400).json({
//                 success: false,
//                 message: "Incorrect password"
//             });
//         }

//         await userModel.findByIdAndDelete(req.user.id);

//         res.status(201).json({
//             success: true,
//             message: "User deleted successfully"
//         });
//     } catch (error) {
//         console.log(error);
//         res.status(500).json({
//             success: false,
//             message: "Internal Server Error"
//         });
//     }
// };


// Forgot password by using phone number
const forgotPassword = async (req, res) => {

    // destructuring
    const { phoneNumber } = req.body;

    // validation
    if (!phoneNumber) {
        return res.status(400).json({
            success: false,
            message: "Please provide your Phone Number!"
        })
    }
    try {

        //finding user (existing user)
        const user = await userModel.findOne({ phoneNumber: phoneNumber })

        if (!user) {
            return res.status(400).json({
                success: false,
                message: "User Not Found!"
            })
        }

        //generating random 6 digit otp
        const otp = Math.floor(100000 + Math.random() * 900000);

        //generating expiry time for otp
        const expiryDate = Date.now() + 360000;

        //save to database for verification
        user.resetPasswordOTP = otp;
        user.resetPasswordExpires = expiryDate;
        await user.save();


        //send to registered phone number // comment to not send otp to phone for real  while changing ui
        const isSent = await sendOtp(phoneNumber, otp);
        console.log(isSent)
        if (!isSent) {
            return res.status(400).json({
                'success': false,
                'message': "Error sending OTP code!"
            })
        }

        //if success
        res.status(200).json({
            'success': true,
            'message': "OTP sent successfully!"
        })



    } catch (error) {
        console.log(error)
        res.status(500).json({
            'success': false,
            'message': "Server Error!"
        })

    }
}

//Verify Otp and set new Password
const verifyOtpAndSetPassword = async (req, res) => {
    // phone number, otp, new password = get data
    // find user by phone number
    // check otp and expiry time
    // update password
    // save to database
    // send success response

    // get data
    const { phoneNumber, otp, newPassword } = req.body;
    if (!phoneNumber || !otp || !newPassword) {
        return res.status(400).json({
            success: false,
            message: "Please provide all fields!"
        })
    }
    try {
        const user = await userModel.findOne({ phoneNumber: phoneNumber })

        // Verify otp
        if (user.resetPasswordOTP != otp) {
            return res.status(400).json({
                success: false,
                message: "Invalid OTP!"
            })
        }
        if (user.resetPasswordExpires < Date.now()) {
            return res.status(400).json({
                success: false,
                message: "OTP Expired!"
            })
        }

        // Update password // hash the new password
        const randomSalt = await bcrypt.genSalt(10)
        const hashedPassword = await bcrypt.hash(newPassword, randomSalt)

        // save to database
        user.password = hashedPassword;
        await user.save();

        // send success response
        res.status(200).json({
            success: true,
            message: "OTP Verified and Password updated successfully!"
        })

    } catch (error) {
        console.log(error)
        return res.status(500).json({
            success: false,
            message: "Server Error!"
        })
    }

}

// Forgot password by email
const forgotPasswordByEmail = async (req, res) => {

    //destructuring
    const { email } = req.body;

    //validation
    if (!email) {
        return res.status(400).json({
            success: false,
            message: "Please provide your E-mail!"
        })
    }
    try {

        //finding user 
        const user = await userModel.findOne({ email: email })

        if (!user) {
            return res.status(400).json({
                success: false,
                message: "User Not Found!"
            })
        }
        // Create a token for password reset
        const secret = process.env.JWT_SECRET + user.password;
        const token = jwt.sign({ email: user.email, id: user._id }, secret, { expiresIn: '15m' });

        // Create a link
        const link = `http://localhost:8000/api/user/reset-password-email/${user._id}/${token}`;
        console.log(link);


        //  Set up nodemailer >> send email through nodemailer
        var transporter = nodemailer.createTransport({
            service: 'gmail',
            auth: {
                user: process.env.EMAIL,
                pass: process.env.EMAIL_PASSWORD
            }
        });



        var mailOptions = {
            from: process.env.EMAIL,
            to: email,
            subject: 'Password Reset Link',
            text: `Click on the link to reset your password: ${link}`
        };


        // Send the email
        transporter.sendMail(mailOptions, function (error, info) {
            if (error) {
                return res.status(400).json({
                    success: false,
                    message: "Error sending email"
                });
            } else {
                return res.status(200).json({
                    success: true,
                    message: "Password reset link sent to your email account"
                });
            }
        });


    } catch (error) {
        console.log(error)
        res.status(500).json({
            'success': false,
            'message': "Server Error!"
        })

    }
}

// update password
const getResetPasswordByEmail = async (req, res) => {
    
// router.get("/reset-password-email/:id/:token", async (req, res) => {

    // get id and token from params
    const { id, token } = req.params;

    // if id or token is not provided
    const oldUser = await User.findOne({ _id: id });
    if (!oldUser) {
        return res.status(400).json({
            'success': false,
            'message': "User does not exists"
        });
    }

    // verify token
    const secret = process.env.JWT_SECRET + oldUser.password;
    try {
        // verify token
        const verify = jwt.verify(token, secret);
        // if token is verified
        if (verify) {
            res.render('index', { email: verify.email });
        }
    } catch (error) {
        res.status(500).json({
            'success': false,
            'message': "Password reset link not verified"
        });
    }
}
    // ,

    // update password by email
    const postResetPasswordByEmail = async (req, res) => {

    // router.post("/reset-password-email/:id/:token", async (req, res) => {

        // get id and token from params
        const { id, token } = req.params;

        // get password from body
        const { password } = req.body;

        // find user
        const oldUser = await User.findOne({ _id: id });
        // if user does not exists
        if (!oldUser) {
            return res.status(400).json({
                'success': false,
                'message': "User does not exists"
            });
        }

        // create a secret
        const secret = process.env.JWT_SECRET + oldUser.password;
        try {
            jwt.verify(token, secret);
            const encryptedPassword = await bcrypt.hash(password, 10);
            await User.updateOne({ _id: id }, { $set: { password: encryptedPassword } });
            return res.status(201).json({
                'success': true,
                'message': "Password updated successfully"
            });
        } catch (error) {
            res.status(500).json({
                'success': false,
                'message': "Password reset failed"
            });
        }
    }

    const getToken = async (req, res) => {
        const id = req.body.id;
        try {
          const user = await userModel.findById(id);
          if (!user) {
            return res.status(400).json({
              success: false,
              message: "User not found",
            });
          }
          const token = await jwt.sign(
            { id: user._id, isAdmin: 'true' },
            process.env.JWT_SECRET  
          );
          res.status(201).json({
            success: true,
            message: "Token generated",
            token: token,
          });
        } catch (error) {
          console.log(error);
          return res.status(500).json({
            success: false,
            message: "Internal server error",
          });
        }
      };
      

        // ,


        // Exporting the function to another file. This exports the createUser function so that it can be imported and used in other files.
        module.exports = {
            createUser,
            loginUser,
            getUserProfile,
            updateUserProfile,
            updateUserSettings,
            deleteUser,
            forgotPassword,
            verifyOtpAndSetPassword,
            forgotPasswordByEmail
            , getResetPasswordByEmail,
            postResetPasswordByEmail,
            getToken


        }