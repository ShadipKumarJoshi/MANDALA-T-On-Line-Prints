import React, { useState } from 'react';
import {  FaEnvelope} from 'react-icons/fa';
import { toast } from 'react-toastify';
import { forgotPasswordByEmail } from '../../apis/api';
import '../../styles/Auth.css';

const ForgotPasswordByEmail = () => {

    // State variables
        const [email, setEmail] = useState('');
        const [emailError, setEmailError] = useState('');
    
  
    // Default error reset function
    const setDefaultError = () => {
        setEmailError('');
       
    };

    // Validation function
    const validate = () => {
        let isValid = true;
        setDefaultError();

        if (email.trim() === '') {
            setEmailError('Please enter your valid email!');
            isValid = false;
        } else {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                setEmailError('Please enter a valid email!');
                isValid = false;
            }
        }

      

        return isValid; // Added return statement for validation result
    };

    // Send reset link for forgot by email
    const handlePasswordResetLink = (e) => {
        e.preventDefault();
        if (!validate()) { // Use validation function
            return;
        }

        forgotPasswordByEmail({ email }).then((res) => {
            if (res.status === 201) {
                toast.success(res.data.message);
                
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
                    <h3 style={{ color: 'black', fontWeight: 'bold', textAlign: 'center', fontSize: 'smaller' }}>Please enter your email to reset your password!</h3>

                    
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

                    <button className='btn btn-dark mt-2 w-100' onClick={handlePasswordResetLink}>Send Password Reset Link</button>


                    <div className="divider"></div>
                    <div>
                        <h6 style={{ textAlign: 'center', fontWeight: 'bold' }}> <a href="/forgot-password">Reset Password by Phone Number!</a></h6>
                    </div>
                    <div className="divider"></div>
                    <div>
                        <h6 style={{ textAlign: 'center', fontWeight: 'bold' }}> <a href="/login">Return to login page!</a></h6>
                    </div>
                </form>
            </div>
        </div>
    );
};

export default ForgotPasswordByEmail;
