// rafce shortcut key 
// import React from 'react'
// import react useState
import React, { useState } from 'react';
import { FaEnvelope, FaEye, FaEyeSlash, FaLock, FaPhone, FaUser } from 'react-icons/fa';
import { toast } from 'react-toastify';
import { registerUserApi } from '../../apis/api';
import '../../styles/Auth.css';
import UserAgreementModal from './UserAgreementModal';

const Register = () => {

    // STEPS FOR REGISTER
    // 1. Create a Frontend for the Register page and path in App.js
    // 2. Input(Type) - Make a useState. state is used for storing temporary data in input fields:
    // 3. Change the input box value, Write a function
    // 4. Assign it to input (onChange)
    // 5. onClick on the button (First Make a Function):
    // 6. Assign it in button:
    // 7. Same process for Validation: error useState > validation function >

    // 2. Input(Type) - Make a useState. state is used for storing temporary data in input fields:
    // Make a useState for 5 Fields
    const [fullName, setFullName] = useState('');
    const [userName, setUserName] = useState('');
    const [phoneNumber, setPhoneNumber] = useState('');
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [confirmPassword, setConfirmPassword] = useState('');

    // 7.1. UseState for Error Message
    const [fullNameError, setFullNameError] = useState('');
    const [userNameError, setUserNameError] = useState('');
    const [phoneNumberError, setPhoneNumberError] = useState('');
    const [emailError, setEmailError] = useState('');
    const [passwordError, setPasswordError] = useState('');
    const [confirmPasswordError, setConfirmPasswordError] = useState('');

    // 7.2. Usestate for password visibility and checkbox
    const [showPassword, setShowPassword] = useState(false);
    const [showConfirmPassword, setShowConfirmPassword] = useState(false);
    const [showAgreementModal, setShowAgreementModal] = useState(false);
    const [agreementChecked, setAgreementChecked] = useState(false);

    // 7.2. Default Error when no error
    const setDefaultError = () => {
        setFullNameError('');
        setUserNameError('');
        setPhoneNumberError('');
        setEmailError('');
        setPasswordError('');
        setConfirmPasswordError('');
    };

    // 3. Change the input box value, Write a function
    const handleFullName = (e) => {
        setFullName(e.target.value);
    };

    const handleUserName = (e) => {
        setUserName(e.target.value);
    };

    const handlePhoneNumber = (e) => {
        setPhoneNumber(e.target.value);
    };

    const handleEmail = (e) => {
        setEmail(e.target.value);
    };

    const handlePassword = (e) => {
        setPassword(e.target.value);
    };

    const handleConfirmPassword = (e) => {
        setConfirmPassword(e.target.value);
    };

    const toggleShowPassword = () => {
        setShowPassword(!showPassword);
    };

    const toggleShowConfirmPassword = () => {
        setShowConfirmPassword(!showConfirmPassword);
    };

    const openAgreementModal = () => {
        setShowAgreementModal(true);
    };

    const closeAgreementModal = () => {
        setShowAgreementModal(false);
    };

    const handleAgreementChecked = () => {
        setAgreementChecked(true);
        closeAgreementModal();
    };

    // 7.2. Validation
    // var is used as it returns value, const doesn't return
    var validate = () => {
        var isValid = true;

        // Reset all error messages to default
        setDefaultError();

        // Regex patterns
        const fullNamePattern = /^[A-Z][a-z]*([A-Z][a-z]*)*$/; // Capital letters followed by lowercase, allowing multiple words
        const userNamePattern = /^[A-Za-z0-9]+$/; // Only letters and numbers
        const phoneNumberPattern = /^9\d{9}$/; // Starts with 9 and has 10 digits
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; //  email format

        // Validate the fullname
        if (fullName.trim() === '') {
            setFullNameError('Please enter your full name!');
            isValid = false;
        } else if (!fullNamePattern.test(fullName.trim().replace(/\s+/g, ''))) {
            setFullNameError('Please enter a valid full name!\nEg: Alex Gott');
            isValid = false;
        }

        // Validate the username
        if (userName.trim() === '') {
            setUserNameError('Please enter your username!');
            isValid = false;
        } else if (!userNamePattern.test(userName.trim())) {
            setUserNameError('Username can only contain alphabets and numbers!');
            isValid = false;
        }

        // Validate the phone number
        if (phoneNumber.trim() === '') {
            setPhoneNumberError('Please enter your phone number!');
            isValid = false;
        } else if (!phoneNumberPattern.test(phoneNumber.trim())) {
            setPhoneNumberError('Please enter a valid phone number!\nEg: 9xxxxxxxxx');
            isValid = false;
        }

        // Validate the email
        if (email.trim() === '') {
            setEmailError('Please enter your email!');
            isValid = false;
        } else if (!emailPattern.test(email.trim())) {
            setEmailError('Please enter a valid email!');
            isValid = false;
        }

        // Validate the password
        if (password.trim() === '') {
            setPasswordError('Please enter your password!');
            isValid = false;
        } else if (password.trim().length < 8) {
            setPasswordError('Password must be at least 8 characters long!');
            isValid = false;
        }

        // Validate the confirm password
        if (confirmPassword.trim() === '') {
            setConfirmPasswordError('Please confirm your password!');
            isValid = false;
        } else if (confirmPassword.trim() !== password.trim()) {
            setConfirmPasswordError('Passwords do not match!');
            isValid = false;
        }
        return isValid; // isValid true/false is returned by this function
    };

    // Function for Empty form after successful registration
    const resetAfterSuccessfulRegisterForm = () => {
        setFullName('');
        setUserName('');
        setPhoneNumber('');
        setEmail('');
        setPassword('');
        setConfirmPassword('');
        setAgreementChecked(false);
    };

    // Submit button Function
    const handleRegister = (e) => {
        e.preventDefault(); // prevents from returning to blank 
        setDefaultError();  // default error is set to none if inputs are right
        // console.log(firstName, lastName, email, password, confirmPassword)

        // 7.3. Validate on click of button
        var isValidated = validate(); // received true or false from above func
        if (!isValidated) {
            return; // return to existing page
        }
        // console.log(firstName, lastName, email, password, confirmPassword)

        if (password !== confirmPassword) {
            toast.error('Password and Confirm Password doesn\'t match');
            return;
        }

        if (!agreementChecked) {
            toast.error('You must agree to the User Agreement');
            return;
        }

        // Sending request to the api

        // making json object for the data of name, email and other data
        const data = {
            'fullName': fullName,     // first firstName is destructured data in backend userController.js 
            'userName': userName,
            'phoneNumber': phoneNumber,
            'email': email,
            'password': password
        };

        // import register api        
        registerUserApi(data).then((res) => {
            // console.log(res.data) // data json made above

            //Received data: success, message 
            if (res.data.success === false) {
                toast.error(res.data.message);
            } else {
                toast.success(res.data.message);
                resetAfterSuccessfulRegisterForm();
            }
        });
    };


    return (
        <div className="background">
            <div className="container">
                <form className="auth-form">
                    <h1 style={{ color: 'white', textAlign: 'center', fontWeight: 'bold', WebkitTextStroke: '1px black', textShadow: '2px 2px 4px rgba(0, 0, 0, 1)' }}>REGISTER</h1>
                    <img src="assets/images/register.png" alt="Centered Image" style={{ display: 'block', margin: '20px auto', maxWidth: '50%', height: 'auto' }} />
                    <h2 style={{ color: 'black', fontWeight: 'bold', textAlign: 'center' }}>Hi!<br />Welcome.</h2>
                    <h3 style={{ color: 'black', fontWeight: 'bold', textAlign: 'center', fontSize: 'smaller' }}>Please enter your details to register!</h3>


                    <label htmlFor="fullName" className="login-label">Full Name</label>
                    <div className="input-container">
                        <input
                            type="text"
                            placeholder="Enter your Full name"
                            id="fullName"
                            value={fullName}
                            onChange={handleFullName}
                            className="input-box"
                        />
                        <div className="input-icon">
                            <FaUser />
                        </div>
                    </div>

                    {fullNameError && <p className="text-danger">{fullNameError}</p>}


                    <label htmlFor="userName" className="login-label">Username</label>
                    <div className="input-container">

                        <input
                            type="text"
                            placeholder="Enter your Username"
                            id="userName"
                            value={userName}
                            onChange={handleUserName}
                            className="input-box"
                        />
                        <div className="input-icon">
                            <FaUser />
                        </div>
                    </div>
                    {userNameError && <p className="text-danger">{userNameError}</p>}

                    <label htmlFor="phoneNumber" className="login-label">Phone Number</label>
                    <div className="input-container">
                        <input
                            type="tel"
                            placeholder="Enter your Phone Number"
                            id="phoneNumber"
                            value={phoneNumber}
                            onChange={handlePhoneNumber}
                            className="input-box"
                        />
                        <div className="input-icon">
                            <FaPhone />
                        </div>
                    </div>
                    {phoneNumberError && <p className="text-danger">{phoneNumberError}</p>}

                    <label htmlFor="email" className="login-label">E-mail</label>
                    <div className="input-container">
                        <input
                            type="text"
                            placeholder="Enter your Email"
                            id="email"
                            value={email}
                            onChange={handleEmail}
                            className="input-box"
                        />
                        <div className="input-icon">
                            <FaEnvelope />
                        </div>
                    </div>
                    {emailError && <p className="text-danger">{emailError}</p>}

                    <label htmlFor="password" className="login-label">Password</label>
                    <div className="input-container">
                        <input
                            type={showPassword ? "text" : "password"} // Toggle between text and password
                            placeholder="Enter your password"
                            id="password"
                            value={password}
                            onChange={handlePassword}
                            className="input-box"
                        />
                        <div className="input-icon">
                            <FaLock />
                        </div>
                        <span className="eye-icon" onClick={toggleShowPassword}>
                            {showPassword ? <FaEyeSlash /> : <FaEye />}
                        </span>
                    </div>
                    {passwordError && <p className='text-danger'>{passwordError}</p>}

                    <label htmlFor="confirmPassword" className="login-label">Confirm Password</label>
                    <div className="input-container">
                        <input
                            type={showConfirmPassword ? "text" : "password"} // Toggle between text and password
                            placeholder="Confirm your Password"
                            id="confirmPassword"
                            value={confirmPassword}
                            onChange={handleConfirmPassword}
                            className="input-box"
                        />
                        <div className="input-icon">
                            <FaLock />
                        </div>
                        <span className="eye-icon" onClick={toggleShowConfirmPassword}>
                            {showConfirmPassword ? <FaEyeSlash /> : <FaEye />}
                        </span>
                    </div>

                    {confirmPasswordError && <p className="text-danger">{confirmPasswordError}</p>}

                    <div className="form-check" style={{ marginTop: '1rem', color: 'black' }}>
                        <input
                            className="form-check-input"
                            type="checkbox"
                            value=""
                            id="agreementCheckbox"
                            checked={agreementChecked}
                            onChange={() => setAgreementChecked(!agreementChecked)}
                            style={{ width: '16px', height: '16px', appearance: 'none', borderRadius: '0' }} // Custom styles for size and shape
                        />
                        <label className="form-check-label" htmlFor="agreementCheckbox" style={{ color: 'black', fontSize: '14px' }}>
                            <a href="#!" onClick={openAgreementModal} style={{ color: 'blue' }}>I agree to the User Agreement</a>
                        </label>
                    </div>

                    {/* <button type="button" className="button" onClick={handleRegister} style={{ backgroundColor: 'green', color: 'white' }}>
                        Register
                    </button> */}
                    <button onClick={handleRegister} className="login-button" style={{ backgroundColor: 'green' }}>Register</button>
                    <div className="divider"></div>
                    <div >
                        <h6 style={{ textAlign: 'center', fontWeight: 'bold', }}>Already have an account? <a href="/login">Login here!</a></h6>
                    </div>
                </form>

                <UserAgreementModal show={showAgreementModal} handleClose={closeAgreementModal} handleAgree={handleAgreementChecked} />
            </div>
        </div>
    );
};

export default Register;
