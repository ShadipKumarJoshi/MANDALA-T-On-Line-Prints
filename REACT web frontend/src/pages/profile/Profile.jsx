import React, { useEffect, useState } from 'react';
import { FaMapMarkerAlt, FaUser } from 'react-icons/fa';
import { toast } from 'react-toastify';
import { getUserProfile, updateUserProfile } from '../../apis/api';
import '../../styles/Auth.css';

const Profile = () => {
  // use state define
  const [fullName, setFullName] = useState('');
  const [userName, setUserName] = useState('');
  const [userAddress, setUserAddress] = useState('');
  const [userOptionalAddress, setUserOptionalAddress] = useState('');

  // useState for image
  const [oldImage, setOldImage] = useState('');


  // useState for new image
  const [newImage, setNewImage] = useState(null);
  const [previewNewImage, setPreviewNewImage] = useState(null);

  // use state for error
  const [fullNameError, setFullNameError] = useState('');
  const [userNameError, setUserNameError] = useState('');
  const [userAddressError, setUserAddressError] = useState('');
  const [userOptionalAddressError, setUserOptionalAddressError] = useState('');

  // Path to the default image


  // Call API initially (Page load)
  useEffect(() => {
    getUserProfile().then((res) => {
      const { fullName, userName, userAddress, userOptionalAddress, userImage } = res.data.user;
      setFullName(fullName);
      setUserName(userName);
      setUserAddress(userAddress);
      setUserOptionalAddress(userOptionalAddress);
      setOldImage(userImage);
    }).catch((error) => {
      console.log(error);
    });
  }, []);

  // Default Error when no error
  const setDefaultError = () => {
    setFullNameError('');
    setUserNameError('');
    setUserAddressError('');
    setUserOptionalAddressError('');
  };

  // Image upload handler
  const handleImage = (event) => {
    const file = event.target.files[0];
    setNewImage(file); // for backend
    setPreviewNewImage(URL.createObjectURL(file)); // for temporary preview
  };

  // Change the input box value, Write a function
  const handleFullName = (e) => {
    setFullName(e.target.value);
  };

  const handleUserName = (e) => {
    setUserName(e.target.value);
  };

  const handleUserAddress = (e) => {
    setUserAddress(e.target.value);
  };

  const handleUserOptionalAddress = (e) => {
    setUserOptionalAddress(e.target.value);
  };

  // Validation
  const validate = () => {
    let isValid = true;

    // Reset all error messages to default
    setDefaultError();

    // Regex patterns
    const fullNamePattern = /^[A-Z][a-z]*([A-Z][a-z]*)*$/; // Capital letters followed by lowercase, allowing multiple words
    const userNamePattern = /^[A-Za-z0-9]+$/; // Only letters and numbers 
    const userAddressPattern = /^(?:[A-Za-z0-9]+(?:[.'",\-&])?\s?)+$/;


    // Validate the full name
    if (fullName.trim() === '') {
      setFullNameError('Please enter your full name!');
      isValid = false;
    } else if (!fullNamePattern.test(fullName.trim().replace(/\s+/g, ''))) {
      setFullNameError('Please enter a valid full name! E.g., Alex Gott');
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

    // Validate the address
    if (userAddress.trim() === '') {
      setUserAddressError('Please enter your address!');
      isValid = false;
    } else if (!userAddressPattern.test(userAddress.trim())) {
      setUserAddressError('Address must start with a capital letter and can contain numbers and special characters after the first word!');
      isValid = false;
    }

    return isValid;
  };

  const handleUpdate = (e) => {
    e.preventDefault();
    if (!validate()) return;

    const formData = new FormData();
    formData.append('fullName', fullName);
    formData.append('userName', userName);
    formData.append('userAddress', userAddress);
    formData.append('userOptionalAddress', userOptionalAddress);
    if (newImage) {
      formData.append('userImage', newImage);
    }

    updateUserProfile(formData).then((res) => {
      if (res.status === 201) {
        toast.success(res.data.message);
        setTimeout(() => {
          window.location.reload();
        }, 500); // Adjust the timeout as needed
      }
      // updateUserProfile(formData).then((res) => {
      //   if (res.status === 200) {
      //     toast.success(res.data.message);
      //     // Optionally update the old image preview
      //     if (newImage) {
      //       setOldImage(URL.createObjectURL(newImage));
      //     }
      //   }
    }).catch((error) => {
      console.log(error);
      toast.error("Something went wrong!");
    });
  };

  return (
    <div className="background">
      <div className="container">
        <form className="auth-form" onSubmit={handleUpdate}>
          <h1 style={{ color: 'white', textAlign: 'center', fontWeight: 'bold', WebkitTextStroke: '1px black', textShadow: '2px 2px 4px rgba(0, 0, 0, 1)' }}>PROFILE</h1>

          <div className='image section' style={{ display: 'flex', justifyContent: 'space-around' }}>
            <div>
              <h6 style={{ fontWeight: 'bold', textAlign: 'center' }}>Profile Preview</h6>
              <img
                height={'200px'}
                width={'200px'}
                className='image-fluid rounded-circle object-fit-cover'
                style={{ objectFit: 'cover' }}
                // src="assets/images/defaultProfile.jpg"
                src={`http://localhost:8000/profile/${oldImage}`}
                alt="Old Profile"
              />

            </div>

            {previewNewImage && (
              <div>
                <h6 style={{ fontWeight: 'bold', textAlign: 'center' }}>New Profile Preview</h6>
                <img
                  height={'200px'}
                  width={'200px'}
                  className='image-fluid'
                  style={{
                    borderRadius: '50%', // Sets the border radius to make the image circular
                    objectFit: 'cover', // Ensures the image covers the container
                    width: '200px', // Ensure width is maintained
                    height: '200px', // Ensure height is maintained
                  }}
                  src={previewNewImage}
                  alt="New Profile"
                />

              </div>
            )}
          </div>

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
            {fullNameError && <div className="error">{fullNameError}</div>}
          </div>

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
            {userNameError && <div className="error">{userNameError}</div>}
          </div>

          <label htmlFor="userAddress" className="login-label">Address</label>
          <div className="input-container">
            <input
              type="text"
              placeholder="Enter your Address"
              id="userAddress"
              value={userAddress}
              onChange={handleUserAddress}
              className="input-box"
            />
            <div className="input-icon">
              <FaMapMarkerAlt />
            </div>
            {userAddressError && <div className="error">{userAddressError}</div>}
          </div>

          <label htmlFor="userOptionalAddress" className="login-label">Optional Address</label>
          <div className="input-container">
            <input
              type="text"
              placeholder="Enter your Optional Address"
              id="userOptionalAddress"
              value={userOptionalAddress}
              onChange={handleUserOptionalAddress}
              className="input-box"
            />
            <div className="input-icon">
              <FaMapMarkerAlt />
            </div>
            {userOptionalAddressError && <div className="error">{userOptionalAddressError}</div>}
          </div>

          <label className='mt-2' style={{ fontWeight: 'bold' }}>Choose Profile Image</label>
          <input onChange={handleImage} type="file" className='form-control' />

          <button className="login-button" style={{ backgroundColor: 'green' }}>UPDATE</button>
          <button type="button" className="login-button" style={{ backgroundColor: 'red' }} onClick={() => window.location.reload()}>CANCEL</button>
        </form>
      </div>
    </div>
  );
};

export default Profile;
