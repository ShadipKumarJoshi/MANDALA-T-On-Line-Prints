import React, { useEffect, useState } from 'react';
import { Link, useNavigate  } from 'react-router-dom';
import { toast } from 'react-toastify';
import './Navbar.css';
import Sidebar from './Sidebar';

const Navbar = () => {
    const [menuOpen, setMenuOpen] = useState(false);

    // change Profile navbar for logged in user
    // get user from local storage as JSON
    const user = JSON.parse(localStorage.getItem('user'));
    const firstName = user ? user.fullName.split(' ')[0] : '';

    const navigate = useNavigate();

    const handleFavoriteClick = () => {
      navigate('/favourites');}

      const handleCartClick = () => {
        navigate('/cart');}

    // Logout function
    const handleLogout = (e) => {
        // localStorage.removeItem('user'); // Clear user data from localStorage
        // history.push('/login'); // Redirect to login page

        // localStorage.clear()
        // window.location.href = '/login';


        e.preventDefault()
        const confirm = window.confirm('Are you sure you want to logout?')

        if (confirm) {
            localStorage.clear()
            window.location.href = '/login';
            toast.success('You are logged out.');
        }

        else if (!confirm) {
            return
        }

    };

    const handleSettings = () => { 
        window.location.href = '/settings';
    }

    const handleDashboard = () => {

        window.location.href = '/admin/dashboard';
    };

    const handleProfile = () => {

        window.location.href = '/profile';
    };


    useEffect(() => {
        const handleBodyClick = () => {
            if (menuOpen) {
                setMenuOpen(false);
            }
        };

        if (menuOpen) {
            document.body.addEventListener('click', handleBodyClick);
        }

        return () => {
            document.body.removeEventListener('click', handleBodyClick);
        };
    }, [menuOpen]);

    const handleMenuClick = (e) => {
        e.stopPropagation();
        setMenuOpen(!menuOpen);
    };

    return (
        <>
            {user && <Sidebar />}
            <div className='container'>
                <nav className="navbar navbar-expand-lg navbar-light bg-white">
                    <div className="container-fluid">
                        <button className="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                            <span className="navbar-toggler-icon"></span>
                        </button>
                        <div className="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul className="navbar-nav me-auto mb-2 mb-lg-0" style={{ display: 'flex', alignItems: 'center' }}>
                                <li className="nav-item d-flex align-items-center">
                                    <a className="nav-link active" aria-current="page" href="/home">
                                        <img src="/assets/images/logo.png" alt="Logo" className="navbar-logo" />
                                    </a>
                                </li>
                                <li className="nav-item">
                                    <a className="nav-link active" aria-current="page" href="/home">HOME</a>
                                </li>
                                {/* <li className="nav-item">
                                    <a className="nav-link" href="/home-design-customise">SELL DESIGN</a>
                                </li> */}

                                {/* Conditional rendering for SELL DESIGN */}
                                {user ? (
                                    <li className="nav-item">
                                        <Link className="nav-link" to="/sell-design">SELL DESIGN</Link>
                                    </li>
                                ) : (
                                    <li className="nav-item">
                                        <Link className="nav-link" to="/home-design-customise">SELL DESIGN</Link>
                                    </li>
                                )}

                                <li className="nav-item">
                                    <a className="nav-link" href="/explore-designs">EXPLORE DESIGNS</a>
                                </li>

                                {/* Conditional rendering for Customise designs */}
                                {user ? (
                                    <li className="nav-item">
                                        <Link className="nav-link" to="/customise-designs">CUSTOMISE DESIGNS</Link>
                                    </li>
                                ) : (
                                    <li className="nav-item">
                                        <Link className="nav-link" to="/home-design-customise">CUSTOMISE DESIGNS</Link>
                                    </li>
                                )}
                                {/* <li className="nav-item">
                                    <a className="nav-link" href="/home-design-customise">CUSTOMISE DESIGNS</a>
                                </li> */}

                                <li className="nav-item">
                                    <a className="nav-link" href="/about">ABOUT</a>
                                </li>

                                <li className="nav-item">
                                    <a className="nav-link" href="/review">REVIEWS AND RATINGS</a>
                                </li>
                            </ul>
                            <form className="d-flex ms-auto" role="search">
                                {
                                    user ? (
                                        <>
                                            <button className="btn notification-btn ms-2 position-relative" type="button">
                                                <i className="bi bi-bell-fill text-dark"></i> {/* Notification bell icon */}
                                                <span className="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                                    3 {/* Number of notifications */}
                                                    <span className="visually-hidden">unread notifications</span>
                                                </span>
                                            </button>
                                            <button className="btn favorite-btn ms-2" type="button" onClick={handleFavoriteClick}>
                                                <i className="bi bi-heart-fill text-danger"></i> {/* Filled favorite icon */}
                                                {/* <Link className="nav-link" to="/home-design-customise">SELL DESIGN</Link> */}
                                            </button>
                                            <button className="btn cart-btn ms-2" type="button" onClick={handleCartClick}>
                                                <i className="bi bi-cart-fill text-dark"></i> {/* Filled cart icon */}
                                            </button>

                                            <div className="dropdown" onClick={handleMenuClick}>
                                                <button className="btn btn-gold dropdown-toggle" type="button">
                                                    Welcome, {firstName}!
                                                </button>
                                                <div className={`open ${menuOpen ? 'oppenned' : ''}`}>
                                                    <span className="cls"></span>
                                                    <span>
                                                        <ul className="sub-menu">
                                                            <li><a href="#" onClick={handleProfile}>Profile</a></li>
                                                            <li><a href="#" onClick={handleDashboard}>Dashboard</a></li>

                                                            <li><a href="#" onClick={handleSettings}>Settings</a></li>
                                                            <li><a href="#" onClick={handleLogout}>Logout</a></li>
                                                            {/* <li><button onClick={handleLogout} class="dropdown-item" href='#'>Logout</button></li> */}
                                                        </ul>
                                                    </span>
                                                    <span className="cls"></span>
                                                </div>
                                            </div>
                                        </>
                                    ) : (
                                        <>
                                            <Link to={'/login'} className="btn btn-primary" type="submit">Login</Link>
                                            <Link to={'/register'} className="btn btn-success ms-2" type="submit">Register</Link>
                                        </>
                                    )
                                }

                            </form>
                        </div>
                    </div>
                </nav>
                <hr className="navbar-divider" />
            </div>
        </>
    );
}

export default Navbar;
