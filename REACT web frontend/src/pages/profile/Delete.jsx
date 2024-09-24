import React, { useEffect, useState } from 'react';
import { FaEye, FaEyeSlash, FaLock } from 'react-icons/fa';
import { toast } from 'react-toastify';
import { deleteUserProfile, getUserProfile } from '../../apis/api';
import '../../styles/Auth.css';

const Delete = () => {
    const [currentPassword, setCurrentPassword] = useState('');
    const [storedPassword, setStoredPassword] = useState('');
    const [currentPasswordError, setCurrentPasswordError] = useState('');
    const [showCurrentPassword, setShowCurrentPassword] = useState(false);

    useEffect(() => {
        getUserProfile().then((res) => {
            const { password } = res.data.user;
            setStoredPassword(password);
        }).catch((error) => {
            console.log(error);
        });
    }, []);

    const setDefaultError = () => {
        setCurrentPasswordError('');
    };

    const handleCurrentPassword = (e) => {
        setCurrentPassword(e.target.value);
    };

    const toggleShowCurrentPassword = () => {
        setShowCurrentPassword(!showCurrentPassword);
    };

    const validate = () => {
        let isValid = true;
        setDefaultError();

        if (currentPassword.trim() === '') {
            setCurrentPasswordError('Please enter your current password for verification!');
            isValid = false;
        } else if (currentPassword.trim().length < 8) {
            setCurrentPasswordError('Password must be at least 8 characters long!');
            isValid = false;
        }

        else if (currentPassword !== storedPassword) {
            setCurrentPasswordError('Incorrect password. Please try again.');
            isValid = false;
        }

        return isValid;
    };

    const handleDeleteAccount = () => {
        if (!validate()) {
            // console.log('sgdjscjks');
            return;
        }
        console.log('sgdjscjks');

        // const confirmDelete = window.confirm('Are you sure you want to delete your account permanently?');
        if (validate) {
            deleteUserProfile().then((res) => {
                if (res.status === 201) {
                    toast.success(res.data.message);
                    window.location.href = '/login';
                }
            }).catch((error) => {
                if (error.response.status === 500) {
                    toast.error(error.response.data.message);
                }
            });
        }
    };

    return (
        <div className="background">
            <div className="container">
                <form className="auth-form">
                    <h1 style={{ color: 'white', textAlign: 'center', fontWeight: 'bold', WebkitTextStroke: '1px black', textShadow: '2px 2px 4px rgba(0, 0, 0, 1)' }}>SETTINGS</h1>
                    <img src="assets/images/deleteUser.png" alt="Centered Image" style={{ display: 'block', margin: '20px auto', maxWidth: '50%', height: 'auto' }} />
                    <h2 style={{ color: 'black', fontWeight: 'bold', textAlign: 'center' }}>Delete Account</h2>
                    <h3 style={{ color: 'black', fontWeight: 'bold', textAlign: 'center', fontSize: 'smaller' }}>Please enter your current password to delete account!</h3>

                    <label htmlFor="currentPassword" className="login-label">Current Password for Verification</label>
                    <div className="input-container">
                        <input
                            type={showCurrentPassword ? "text" : "password"}
                            placeholder="Enter your current password"
                            id="currentPassword"
                            value={currentPassword}
                            onChange={handleCurrentPassword}
                            className="input-box"
                        />
                        <div className="input-icon">
                            <FaLock />
                        </div>
                        <span className="eye-icon" onClick={toggleShowCurrentPassword}>
                            {showCurrentPassword ? <FaEyeSlash /> : <FaEye />}
                        </span>
                    </div>
                    {currentPasswordError && <p className='text-danger'>{currentPasswordError}</p>}

                    <button type="button" className="login-button delete-button" style={{ backgroundColor: 'red' }} onClick={handleDeleteAccount}>Delete Account</button>
                </form>
            </div>
        </div>
    );
};

export default Delete;
