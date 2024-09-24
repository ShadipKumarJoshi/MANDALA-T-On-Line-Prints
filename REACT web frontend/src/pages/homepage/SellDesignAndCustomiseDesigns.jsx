import React from 'react'
import '../../styles/Auth.css';

const SellArtAndCustomiseDesigns = () => {
    return (
        <div className="background">
            <div className="container">
            <div className="text-align-left align-self-center">
                <h1 className="h1 text-success" style={{ textAlign: 'center', fontSize: '50px', WebkitTextStroke: '1px black', textShadow: '2px 2px 4px rgba(0, 0, 0, 1)' }}>
                    <b>YOUR DESIGN</b>
                </h1> 
               
            </div>
            <div id="carouselExampleCaptions" class="carousel slide">
                    <div class="carousel-indicators">
                        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
                        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
                    </div>
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="./assets/images/explore1.png" class="d-block w-100" alt="..." />
                            <div class="carousel-caption d-none d-md-block">
                                
                            </div>
                        </div>
                        <div class="carousel-item">
                            <img src="./assets/images/sell.jpg"class="d-block w-100" alt="..." />
                            <div class="carousel-caption d-none d-md-block">
                                
                            </div>
                        </div>
                        <div class="carousel-item">
                            <img src="./assets/images/explore.png"class="d-block w-100" alt="..." />
                            <div class="carousel-caption d-none d-md-block">
                                
                            </div>
                        </div>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
                <div className="divider"></div>
                <form className="auth-form">

                    <h1 className="h1 text-success" style={{ WebkitTextStroke: '1px black', textShadow: '2px 2px 4px rgba(0, 0, 0, 1)' }} >LOGIN to ENJOY this FEATURE</h1>

                    <img src="assets/images/login.png" alt="Centered Image" style={{ display: 'block', margin: '20px auto', maxWidth: '50%', height: 'auto' }} />
                    <div >
                        <h6 style={{ textAlign: 'center', fontWeight: 'bold', }}>Already have an account? <a href="/login">Login here!</a></h6>
                    </div>
                    <div className="divider"></div>
                    <div >
                        <h6 style={{ textAlign: 'center', fontWeight: 'bold', }}>Don't have an account? <a href="/register">Create an account!</a></h6>
                    </div>


                </form>
            </div>
        </div>
    )
}

export default SellArtAndCustomiseDesigns
