import React from 'react';
import './Footer.css';

const Footer = () => {
    return (
        <div className="container">
        <footer className="footer-distributed">
            <div className="footer-left">
                <ul className="nav">
                    <li className="nav-item d-flex align-items-center">
                        <a className="nav-link active" aria-current="page" href="#">
                            <img src="/assets/images/logo.png" alt="Logo" className="navbar-logo" style={{ width: '20%', height: 'auto' }} />
                        </a>
                    </li>
                </ul>
                <h3>MANDALA T-On-Line Prints </h3>
                <p className="footer-links">
                    <a href="#" className="link-1">HOME</a>
                    <a href="#">SELL ART</a>
                    <a href="#">EXPLORE DESIGNS</a>
                    <a href="#">CUSTOMIZE DESIGNS</a>
                </p>
                <p className="footer-links">
                    <a href="#" className="link-1">Blog</a>
                    <a href="#">About Us</a>
                    <a href="#">Faq</a>
                    <a href="#">Contact</a>
                </p>
            </div>

            <div className="footer-center">
                <div>
                <h6 style={{ color: 'white', fontWeight: 'bold' }}>Address:</h6>


                    <p>
                        11/11 Swet Binayak Marg,<br />
                        Buddhanagar, New Baneshwor,<br />
                        Kathmandu, Nepal
                    </p>
                </div>
                <div style={{ marginBottom: '20px' }}></div>
                <div>
                <h6 style={{ color: 'white', fontWeight: 'bold' }}>Contact :</h6>
                    <p>+01-4797596, 9866543456</p>
                </div>
                <div>
                                                       <p><a href="mailto:support@company.com">support@mandala.prints.com</a></p>
                </div>
                <div style={{ marginBottom: '20px' }}></div>
                <div>             
            <p className="footer-company-name">Mandala T-On-Line prints © 2015</p>
                </div>
            </div>

            <div className="footer-right">
                <p className="footer-company-about">
                    <span>About the company</span>
                    Mandala T-On-Line Prints is the right platform to design your ideas, print it and wear it to make a statement. Submit your art to earn passively through royalty for each of its print.
                </p>
                <div style={{ marginBottom: '20px' }}></div>
                
                <div className="footer-icons">
                <h6 style={{ color: 'white', fontWeight: 'bold' }}>Social Media Handles:</h6>
                    <a href="#"><img src="/assets/images/fb.png" alt="Facebook" style={{ width: '30px', height: '30px' }} /></a>
                    <a href="#"><img src="/assets/images/google.png"alt="Google" style={{ width: '30px', height: '30px' }} /></a>
                    <a href="#"><img src="/assets/images/instagram.png" alt="Instagram" style={{ width: '30px', height: '30px' }} /></a>
                    <a href="#"><img src="/assets/images/pinterest.png" alt="Pinterest" style={{ width: '30px', height: '30px' }} /></a>
                    <a href="#"><img src="/assets/images/threads.png" alt="Thread" style={{ width: '30px', height: '30px' }} /></a>
                    <a href="#"><img src="/assets/images/tk.png"alt="Tiktok" style={{ width: '30px', height: '30px' }} /></a>
                    <a href="#"><img src="/assets/images/x.png" alt="X" style={{ width: '30px', height: '30px' }} /></a>
                    <a href="#"><img src="/assets/images/yt.png" alt="Youtube" style={{ width: '30px', height: '30px' }} /></a>
                </div>

            </div>
        </footer>
        </div>
    );
};

export default Footer;
