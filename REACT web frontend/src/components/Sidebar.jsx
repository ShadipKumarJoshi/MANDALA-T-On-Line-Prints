import '@fortawesome/fontawesome-free/css/all.min.css';
import React from 'react';
import { Link } from 'react-router-dom';
import './Sidebar.css';
import { toast } from 'react-toastify'

function Sidebar() {

  // Logout Function
  const handleLogout = () => {
    // localStorage.removeItem('user');
    // // Redirect to login page
    // window.location.href = '/login';

    const confirm = window.confirm('Are you sure you want to logout?')

    if (confirm) {
      localStorage.clear()
      window.location.href = '/login';
      toast.success('You are logged out.');
    } 

    
  }

  return (
    <div id="side-bar">
      <input id="side-toggle" type="checkbox" />
      <div id="side-header">
        <a id="side-title"  >
          <img src="/assets/images/logo.png" alt="Centered Image" style={{ display: 'block', margin: '20px auto', maxWidth: '60%', height: 'auto' }} />
        </a>
        <label htmlFor="side-toggle">
          <span id="side-toggle-burger"></span>
        </label>
        <hr />
      </div>

      <div id="side-content">
        <Link className="side-button" to='admin/dashboard'><i className="fas fa-cube"></i><span>Dashboard</span></Link>
        <Link className="side-button" to='sell-design'><i className="fas fa-palette"></i><span>Designs</span></Link>
        <Link className="side-button" to='favourites'><i className="fas fa-heart"></i><span>Favorites</span></Link>
        <Link className="side-button" to='order'><i className="fas fa-cart-shopping"></i><span>Orders</span></Link>
        <Link className="side-button" to='settings'><i className="fas fa-gear"></i><span>Settings</span></Link>
        <div className="side-button" style={{ color: 'red', fontWeight: 'bold', cursor: 'pointer' }} onClick={handleLogout}><i className="fas fa-right-from-bracket"></i><span>Logout</span></div>


        <hr />
        <div id="side-content-highlight"></div>
      </div>


    </div>
  );
}

export default Sidebar;
