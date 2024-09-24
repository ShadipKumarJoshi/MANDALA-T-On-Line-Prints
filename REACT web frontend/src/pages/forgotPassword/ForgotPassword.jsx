import React, { useState } from 'react';
import { FaCertificate, FaEnvelope, FaEye, FaEyeSlash, FaLock, FaPhone } from 'react-icons/fa';
import { toast } from 'react-toastify';
import { forgotPassword, forgotPasswordByEmail, verifyOtpAndSetPassword } from '../../apis/api';
import '../../styles/Auth.css';

const ForgotPassword = () => {

    // State variables
    const [phoneNumber, setPhoneNumber] = useState('');
    const [email, setEmail] = useState('');
    const [isSent, setIsSent] = useState(false);
    const [otp, setOtp] = useState('');
    const [newPassword, setNewPassword] = useState('');
    const [confirmPassword, setConfirmPassword] = useState(''); // Added state for confirm password
    const [phoneNumberError, setPhoneNumberError] = useState('');
    const [emailError, setEmailError] = useState('');
    const [otpError, setOtpError] = useState(''); // Added state for OTP error
    const [passwordError, setPasswordError] = useState(''); // Added state for password error

    // Password visibility state
    const [showPassword, setShowPassword] = useState(false);
    const [showConfirmPassword, setShowConfirmPassword] = useState(false);

    // Default error reset function
    const setDefaultError = () => {
        setPhoneNumberError('');
        setOtpError(''); // Reset OTP error
        setPasswordError(''); // Reset password error
    };

    // Validation function
    const validate = () => {
        let isValid = true;
        setDefaultError();

        if (phoneNumber.trim() === '') {
            setPhoneNumberError('Please enter your valid phone number! \n eg. 9XXXXXXXXX');
            isValid = false;
        } else {
            const phoneRegex = /^[9]\d{9}$/;
            if (!phoneRegex.test(phoneNumber)) {
                setPhoneNumberError('Please enter a valid phone number! \n eg. 9XXXXXXXXX');
                isValid = false;
            }
        }

        if (isSent) {
            if (otp.trim() === '') {
                setOtpError('Please enter the OTP sent to your phone.');
                isValid = false;
            }
            if (newPassword.trim() === '' || confirmPassword.trim() === '') {
                setPasswordError('Please enter and confirm your new password.');
                isValid = false;
            } else if (newPassword !== confirmPassword) {
                setPasswordError('Passwords do not match.');
                isValid = false;
            }
        }

        return isValid; // Added return statement for validation result
    };

    // Password visibility state
    const toggleShowPassword = () => {
        setShowPassword(!showPassword);
    };

    // Confirm password visibility state
    const toggleShowConfirmPassword = () => {
        setShowConfirmPassword(!showConfirmPassword);
    };

    // Send OTP function for phone number
    const handleSendOtp = (e) => {
        e.preventDefault();
        if (!validate()) { // Use validation function
            return;
        }

        forgotPassword({ phoneNumber }).then((res) => {
            if (res.status === 200) {
                toast.success(res.data.message);
                setIsSent(true);
            }
        }).catch((error) => {
            if (error.response.status === 400 || error.response.status === 500) {
                toast.error(error.response.data.message);
            }
        });
    };

    // Verify OTP and set password
    const handleVerifyOtpAndSetPassword = (e) => {
        e.preventDefault();
        if (!validate()) { // Use validation function
            return;
        }

        const data = {
            phoneNumber,
            otp,
            newPassword
        };

        verifyOtpAndSetPassword(data).then((res) => {
            if (res.status === 200) {
                toast.success(res.data.message);
                // Clear form fields and reset state
                setPhoneNumber('');
                setOtp('');
                setNewPassword('');
                setConfirmPassword('');
                setIsSent(false);
            }
        }).catch((error) => {
            if (error.response.status === 400 || error.response.status === 500) {
                toast.error(error.response.data.message);
            }
        });
    };

    // Send reset link for forgot by email
    const handlePasswordResetLink = (e) => {
        e.preventDefault();
        if (!validate()) { // Use validation function
            return;
        }

        forgotPasswordByEmail({ email }).then((res) => {
            if (res.status === 200) {
                toast.success(res.data.message);
                setIsSent(true);
            }
        }).catch((error) => {
            if (error.response.status === 400 || error.response.status === 500) {
                toast.error(error.response.data.message);
            }
        });
    };

    return (
        <div className="background">
            <div className="container">
                <form className="auth-form">
                    <h1 style={{ color: 'white', textAlign: 'center', fontWeight: 'bold', WebkitTextStroke: '1px black', textShadow: '2px 2px 4px rgba(0, 0, 0, 1)' }}>RESET PASSWORD</h1>
                    <img src="assets/images/reset_password.png" alt="Centered Image" style={{ display: 'block', margin: '20px auto', maxWidth: '50%', height: 'auto' }} />
                    <h2 style={{ color: 'black', fontWeight: 'bold', textAlign: 'center' }}>Oh, NO!<br />I forgot!</h2>
                    <h3 style={{ color: 'black', fontWeight: 'bold', textAlign: 'center', fontSize: 'smaller' }}>Please enter your phone number to reset your password!</h3>

                    <label htmlFor="phoneNumber" className="login-label" style={{ fontWeight: 'bold' }}>Phone Number</label>
                    <div className="input-container">
                        <input
                            disabled={isSent}
                            onChange={(e) => setPhoneNumber(e.target.value)}
                            type="number"
                            placeholder="Enter your phone number"
                            id="phoneNumber" // Fixed 'htmlFor' label association
                            value={phoneNumber}
                            className="input-box"
                        />
                        <div className="input-icon">
                            <FaPhone />
                        </div>
                    </div>
                    {phoneNumberError && <p className='text-danger'>{phoneNumberError}</p>}

                    <button disabled={isSent} onClick={handleSendOtp} className='btn btn-dark mt-2 w-100'>Send OTP</button>
                    {
                        isSent && <>
                            <hr />
                            <p style={{ fontWeight: 'bold' }}> OTP has been sent to <span style={{ color: 'blue' }}>{phoneNumber}</span>✅</p>

                            <label htmlFor="otp" className="login-label" style={{ fontWeight: 'bold' }}>OTP</label>
                            <div className="input-container">
                                <input
                                    type="number"
                                    placeholder="Enter your OTP"
                                    id="otp"
                                    value={otp}
                                    onChange={(e) => setOtp(e.target.value)}
                                    className="input-box"
                                />
                                <div className="input-icon">
                                    <FaCertificate />
                                </div>
                            </div>

                            {/* <input
                                onChange={(e) => setOtp(e.target.value)}
                                type='number'
                                className='form-control'
                                placeholder='Enter your OTP' */}
                            {/* /> */}
                            {otpError && <p className='text-danger'>{otpError}</p>} {/* Display OTP error */}

                            <label htmlFor="password" className="login-label" style={{ fontWeight: 'bold' }}>Password</label>
                            <div className="input-container">
                                <input
                                    type={showPassword ? "text" : "password"} // Toggle between text and password
                                    placeholder="Enter your password"
                                    id="password"
                                    value={newPassword}
                                    onChange={(e) => setNewPassword(e.target.value)}
                                    className="input-box"
                                />
                                <div className="input-icon">
                                    <FaLock />
                                </div>
                                <span className="eye-icon" onClick={toggleShowPassword}>
                                    {showPassword ? <FaEyeSlash /> : <FaEye />}
                                </span>
                            </div>


                            {/* <input
                                onChange={(e) => setNewPassword(e.target.value)}
                                type='password' // Changed type to 'password'
                                className='form-control mt-2'
                                placeholder='Enter your new password'
                            /> */}


                            <label htmlFor="confirmPassword" className="login-label" style={{ fontWeight: 'bold' }}>Confirm Password</label>
                            <div className="input-container">
                                <input
                                    type={showConfirmPassword ? "text" : "password"} // Toggle between text and password
                                    placeholder="Confirm your Password"
                                    id="confirmPassword"
                                    value={confirmPassword}
                                    onChange={(e) => setConfirmPassword(e.target.value)}
                                    className="input-box"
                                />
                                <div className="input-icon">
                                    <FaLock />
                                </div>
                                <span className="eye-icon" onClick={toggleShowConfirmPassword}>
                                    {showConfirmPassword ? <FaEyeSlash /> : <FaEye />}
                                </span>
                            </div>




                            {/* <input
                                onChange={(e) => setConfirmPassword(e.target.value)}
                                type='password' // Added confirm password input
                                className='form-control mt-2'
                                placeholder='Confirm your new password'
                            /> */}
                            {passwordError && <p className='text-danger'>{passwordError}</p>} {/* Display password error */}
                            <button onClick={handleVerifyOtpAndSetPassword} className='btn btn-primary mt-2 w-100'>Verify OTP & Set Password</button>


                        </>

                    }
                    <div className="divider"></div>

                    <div>
                        <h6 style={{ textAlign: 'center', fontWeight: 'bold' }}> <a href="/forgot-password-email">Reset Password by E-mail!</a></h6>
                    </div>
                    {/* <div className="divider"></div>
                    <label htmlFor="email" className="login-label">E-mail</label>
                    <div className="input-container">
                        <input
                            type="text"
                            placeholder="Enter your Email"
                            id="email"
                            value={email}
                            onChange={(e) => setEmail(e.target.value)}
                            className="input-box"
                        />
                        <div className="input-icon">
                            <FaEnvelope />
                        </div>
                    </div>
                    {emailError && <p className="text-danger">{emailError}</p>}

                    <button className='btn btn-dark mt-2 w-100' onClick={handlePasswordResetLink}>Send Password Reset Link</button> */}


                    <div className="divider"></div>
                    <div>
                        <h6 style={{ textAlign: 'center', fontWeight: 'bold' }}> <a href="/login">Return to login page!</a></h6>
                    </div>
                </form>
            </div>
        </div>
    );
};

export default ForgotPassword;
