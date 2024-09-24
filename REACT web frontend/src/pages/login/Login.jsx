// rafce shortcut key 
// import React from 'react'
// import react useState
import React, { useState } from 'react';
import { FaEye, FaEyeSlash, FaLock, FaUser } from 'react-icons/fa';
import { useNavigate } from 'react-router-dom';
import { toast } from 'react-toastify';
import { loginUserApi } from '../../apis/api';
import '../../styles/Auth.css';

const Login = () => {

    // STEPS FOR LOGIN
    // 1. Make a login page
    // 2. Make a path in App.js
    // 3. make a frontend with email & Password
    // 4. make use State
    // 5. validation 
    // 6. make an error state
    // 7. Make a function to handle the form submission

    // 4. make a useState for each input
    const [emailOrPhoneNumber, setEmailOrPhoneNumber] = useState('');
    const [password, setPassword] = useState('');

    // 6. make an error state
    const [emailOrPhoneNumberError, setEmailOrPhoneNumberError] = useState('');
    const [passwordError, setPasswordError] = useState('');

    //  Usestate for password visibility and checkbox
    const [showPassword, setShowPassword] = useState(false);
    const [rememberMe, setRememberMe] = useState(false);

    const navigate = useNavigate();

    // 6.1. Default Error when no error
    const setDefaultError = () => {
        setEmailOrPhoneNumberError('');
        setPasswordError('');
    };

    // 3. Change the input box value, Write a function
    const handleEmailOrPhoneNumber = (e) => {
        setEmailOrPhoneNumber(e.target.value);
    };

    const handlePassword = (e) => {
        setPassword(e.target.value);
    };
    // Function to handle password visibility change
    const toggleShowPassword = () => {
        setShowPassword(!showPassword);
    };

    // Function to handle checkbox change
    const handleRememberMeChange = (e) => {
        setRememberMe(e.target.checked);
    };

    const handleForgotPassword = () => {
        navigate('/forgot-password');
    };

    // 5. validation 
    // Email/password Validation
    const validation = () => {
        let isValid = true;
        // Reset all error messages to default
        setDefaultError();

        // // Regex patterns
        // const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; //  email format

        // Validate the email or phone number
        if (emailOrPhoneNumber.trim() === '') {
            setEmailOrPhoneNumberError('Please enter your valid e-mail or phone number!');
            isValid = false;
        } else {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            const phoneRegex = /^[9]\d{9}$/;

            if (!emailRegex.test(emailOrPhoneNumber) && !phoneRegex.test(emailOrPhoneNumber)) {
                setEmailOrPhoneNumberError('Please enter a valid e-mail or phone number!');
                isValid = false;
            }
        }


        // Validate the password
        if (password.trim() === '') {
            setPasswordError('Please enter your password!');
            isValid = false;
        }

        return isValid;
    };

    // 7. Make a function to handle the form submission
    const handleLogin = (e) => {
        e.preventDefault();
        // toast.success('Login button is clicked!')

        // Validation from email/password
        if (!validation()) {
            return;
        }

        // Login
        // make a  json object
        const data = {
            "emailOrPhoneNumber": emailOrPhoneNumber,
            "password": password
        };

        // make a api request
        loginUserApi(data).then((res) => {
            if (res.status === 201) {
                toast.success(res.data.message);
                //   success- bool, message- text, token- text, user data-json object format
                // Setting token and user data in local storage
                localStorage.setItem('token', res.data.token);

                // setting user data
                const convertedData = JSON.stringify(res.data.userData);

                // local storage set
                localStorage.setItem('user', convertedData);

                // Redirect to homepage
                window.location.href = '/';
            }
        }).catch((error) => {
            if (error.response) {
                if (error.response.status === 404) {
                    toast.error(error.response.data.message);
                } else if (error.response.status === 400) {
                    toast.error(error.response.data.message);
                } else if (error.response.status === 500) {
                    toast.error(error.response.data.message);
                } else {
                    toast.error("An error occurred. Please try again.");
                }
            } else {
                toast.error("Network error. Please try again.");
            }
        });
    };

    return (
        <div className="background">
            <div className="container">
                <form className="auth-form">
                    {/* <h1 className="login-title">LOGIN</h1> */}
                    <h1 style={{ color: 'white', textAlign: 'center', fontWeight: 'bold', WebkitTextStroke: '1px black', textShadow: '2px 2px 4px rgba(0, 0, 0, 1)' }}>LOGIN</h1>
                    {/* <img src="assets/images/login.png" alt="Centered Image" className="login-image" /> */}
                    <img src="assets/images/login.png" alt="Centered Image" style={{ display: 'block', margin: '20px auto', maxWidth: '50%', height: 'auto' }} />
                    <h2 className="welcome-text">Hi!<br />Welcome.</h2>
                    <h3 className="credentials-text">Please enter your credentials to login!</h3>

                    <label htmlFor="emailOrPhoneNumber" className="login-label">E-mail or Phone Number</label>
                    <div className="input-container">
                        <input
                            type="text"
                            placeholder="Enter your e-mail or phone number"
                            id="emailOrPhoneNumber"
                            value={emailOrPhoneNumber}
                            onChange={handleEmailOrPhoneNumber}
                            className="input-box"
                        />
                        <div className="input-icon">
                            <FaUser />
                        </div>
                    </div>
                    {emailOrPhoneNumberError && <p className='text-danger'>{emailOrPhoneNumberError}</p>}

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

                    <div className="remember-forgot-container">
                        <div className="remember-me">
                            <input
                                type="checkbox"
                                checked={rememberMe}
                                onChange={handleRememberMeChange}
                                className="remember-me-checkbox"
                            />
                            <span className="remember-me-text">Remember Me!</span>
                        </div>
                        <span className="forgot-password" onClick={handleForgotPassword}>Forgot Password?</span>
                    </div>

                    <button onClick={handleLogin} className="login-button">Log In</button>

                    <div className="divider"></div>
                    <h3 className="social-login-text">Or<br />Login with</h3>

                    <div className="social">
                        <div className="google">
                            {/* <i className="fab fa-google"></i> */}
                            <img src="assets/icons/iconFb.ico" alt="Facebook" className="social-icon" />
                        </div>
                        <div className="fb">
                            {/* <i className="fab fa-facebook"></i> */}
                            <img src="assets/icons/iconGoogle.ico" alt="Google" className="social-icon" />
                        </div>
                    </div>
                    <div className="divider"></div>
                    <div >
                        <h6 style={{ textAlign: 'center', fontWeight: 'bold', }}>Don't have an account? <a href="/register">Create an account!</a></h6>
                    </div>

                    {/* <h6 className="register">Don't have an account? <a href="/register">Create an account!</a></h6> */}
                </form>
            </div>
        </div>
    );
};

export default Login;
