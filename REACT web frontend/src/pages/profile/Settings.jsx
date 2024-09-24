import React, { useEffect, useState } from 'react';
import { FaEnvelope, FaEye, FaEyeSlash, FaLock, FaPhone, } from 'react-icons/fa';
import { toast } from 'react-toastify';
import { deleteUserProfile, getUserProfile, updateUserSettings } from '../../apis/api';
import '../../styles/Auth.css';

const Settings = () => {
  // use state define
  const [phoneNumber, setPhoneNumber] = useState('');
  const [email, setEmail] = useState('');
  const [currentPassword, setCurrentPassword] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');

  // use state for error
  const [phoneNumberError, setPhoneNumberError] = useState('');
  const [emailError, setEmailError] = useState('');
  const [currentPasswordError, setCurrentPasswordError] = useState('');
  const [newPasswordError, setNewPasswordError] = useState('');
  const [confirmPasswordError, setConfirmPasswordError] = useState('');

  // Usestate for password visibility
  const [showCurrentPassword, setShowCurrentPassword] = useState(false);
  const [showNewPassword, setShowNewPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);

  // Call API initially (Page load)
  useEffect(() => {
    getUserProfile().then((res) => {
      const { phoneNumber, email } = res.data.user;
      setPhoneNumber(phoneNumber);
      setEmail(email);
    }).catch((error) => {
      console.log(error);
    });
  }, []);

  // Default Error when no error
  const setDefaultError = () => {
    setPhoneNumberError('');
    setEmailError('');
    setCurrentPasswordError('');
    setNewPasswordError('');
    setConfirmPasswordError('');
  };



  // Change the input box value, Write a function
  const handlePhoneNumber = (e) => {
    setPhoneNumber(e.target.value);
  };

  const handleEmail = (e) => {
    setEmail(e.target.value);
  };

  const handleCurrentPassword = (e) => {
    setCurrentPassword(e.target.value);
  };

  const handleNewPassword = (e) => {
    setNewPassword(e.target.value);
  };

  const handleConfirmPassword = (e) => {
    setConfirmPassword(e.target.value);
  };

  const toggleShowCurrentPassword = () => {
    setShowCurrentPassword(!showCurrentPassword);
  };

  const toggleShowNewPassword = () => {
    setShowNewPassword(!showNewPassword);
  };

  const toggleShowConfirmPassword = () => {
    setShowConfirmPassword(!showConfirmPassword);
  };


  // Validation
  const validate = () => {
    let isValid = true;

    // Reset all error messages to default
    setDefaultError();

    // Regex patterns
    const phoneNumberPattern = /^9\d{9}$/; // Starts with 9 and has 10 digits
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; //  email format


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
    if (currentPassword.trim() === '') {
      setCurrentPasswordError('Please enter your current password for verification!');
      isValid = false;
    } else if (currentPassword.trim().length < 8) {
      setCurrentPasswordError('Password must be at least 8 characters long!');
      isValid = false;
    }

    if (newPassword.trim() === '') {
      setNewPasswordError('Please enter your new password!');
      isValid = false;
    } else if (newPassword.trim().length < 8) {
      setNewPasswordError('Password must be at least 8 characters long!');
      isValid = false;
    }

    // Validate the confirm password
    if (confirmPassword.trim() === '') {
      setConfirmPasswordError('Please confirm your new password!');
      isValid = false;
    } else if (confirmPassword.trim() !== newPassword.trim()) {
      setConfirmPasswordError('Passwords do not match!');
      isValid = false;
    }
    return isValid; // isValid true/false is returned by this function
  };

  // handle update function
  const handleUpdate = (e) => {
    e.preventDefault();
    if (!validate()) return;

    const updateData = {
      email,
      phoneNumber,
      currentPassword,
    };
    if (newPassword.trim() !== '') {
      updateData.newPassword = newPassword;
    }

    updateUserSettings(updateData).then((res) => {
      if (res.status === 201) {
        toast.success(res.data.message);
        console.log("dddd");
      }
    }).catch((error) => {
      
      if (error.response.status === 400 || error.response.status === 500) {
        toast.error(error.response.data.message);
      }
    });
  };

  const handleDeleteAccount = () => {
    const confirmDelete = window.confirm('Are you sure you want to delete your account permanently?');
    if (confirmDelete) {
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
          <img src="assets/images/settings.png" alt="Centered Image" style={{ display: 'block', margin: '20px auto', maxWidth: '50%', height: 'auto' }} />
          <h2 style={{ color: 'black', fontWeight: 'bold', textAlign: 'center' }}>Hi!<br />Welcome.</h2>
          <h3 style={{ color: 'black', fontWeight: 'bold', textAlign: 'center', fontSize: 'smaller' }}>Please enter your new credentials to update!</h3>


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

          <label htmlFor="newPassword" className="login-label">New Password</label>
          <div className="input-container">
            <input
              type={showNewPassword ? "text" : "password"} // Toggle between text and password
              placeholder="Enter your new password"
              id="newPassword"
              value={newPassword}
              onChange={handleNewPassword}
              className="input-box"
            />
            <div className="input-icon">
              <FaLock />
            </div>
            <span className="eye-icon" onClick={toggleShowNewPassword}>
              {showNewPassword ? <FaEyeSlash /> : <FaEye />}
            </span>
          </div>
          {newPasswordError && <p className='text-danger'>{newPasswordError}</p>}

          <label htmlFor="confirmPassword" className="login-label">Confirm New Password</label>
          <div className="input-container">
            <input
              type={showConfirmPassword ? "text" : "password"} // Toggle between text and password
              placeholder="Confirm your New Password"
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

          <div className="divider"></div>

          {/* Account verification */}
          <label htmlFor="currentPassword" className="login-label">Current Password for Verification</label>
          <div className="input-container">
            <input
              type={showCurrentPassword ? "text" : "password"} // Toggle between text and password
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

          <button onClick={handleUpdate} className="login-button" style={{ backgroundColor: 'green' }}>Update Profile</button>



          <div className="divider"></div>



          <button type="button" className="login-button delete-button" style={{ backgroundColor: 'red' }} onClick={handleDeleteAccount}>Delete Account</button>


          <button type="button" className="login-button" style={{ backgroundColor: 'red' }} onClick={() => window.location.reload()}>CANCEL</button>
          <div className="divider"></div>

                    <div>
                        <h6 style={{ textAlign: 'center', fontWeight: 'bold' }}> <a href="/delete-account">Delete Account</a></h6>
                    </div>
        </form>
      </div>
    </div>
  );
};

export default Settings;
