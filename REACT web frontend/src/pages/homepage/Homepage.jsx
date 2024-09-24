import React from "react";


const Homepage = () => {
    return (
        <div className="container" >
            <div className="text-align-left align-self-center">
                <h1 className="h1 text-success" style={{ textAlign: 'center', fontSize: '100px', WebkitTextStroke: '1px black', textShadow: '2px 2px 4px rgba(0, 0, 0, 1)' }}>
                    <b>WELCOME!</b>
                </h1>


                <img src="./assets/images/logo_black.gif" alt="About Hero" style={{ display: 'block', margin: '20px auto', maxWidth: '50%', height: 'auto' }}></img>

                <div className="divider"></div>
                <div className="divider"></div>

            </div>
            <div id="template-mo-zay-hero-carousel" className="carousel slide carousel-dark" data-bs-ride="carousel" style={{ backgroundColor: 'white' }}>
                <div className="carousel-indicators" >
                    <button type="button" data-bs-target="#template-mo-zay-hero-carousel" data-bs-slide-to="0" className="active" aria-current="true" aria-label="Slide 1"></button>
                    <button type="button" data-bs-target="#template-mo-zay-hero-carousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
                    <button type="button" data-bs-target="#template-mo-zay-hero-carousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
                </div>
                <div className="carousel-inner">
                    <div className="carousel-item active" data-bs-interval="10000">
                        <div className="container">
                            <div className="row p-5">
                                <div className="mx-auto col-md-8 col-lg-6 order-lg-last">
                                    <img className="img-fluid" src="./assets/images/home1.svg" alt="Home 1" />
                                </div>
                                <div className="col-lg-6 mb-0 d-flex align-items-center">
                                    <div className="text-align-left align-self-center">
                                        <h1 className="h1 text-success" style={{ WebkitTextStroke: '1px black', textShadow: '2px 2px 4px rgba(0, 0, 0, 1)' }}>
                                            <b>Design Your Idea</b>
                                        </h1>
                                        <div style={{ marginBottom: '20px' }}></div>
                                        <h3 className="h2" ><b>Bring your idea to life.</b></h3>
                                        <h3 className="h2"><b>Design your own t-shirts and wear them with pride.</b></h3>
                                        <h3 className="h2"><b>Let your creativity shine!</b></h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div className="carousel-item" data-bs-interval="2000">
                        <div className="container">
                            <div className="row p-5">
                                <div className="mx-auto col-md-8 col-lg-6 order-lg-last">
                                    <img className="img-fluid" src="./assets/images/home2.svg" alt="Home 2" />
                                </div>
                                <div className="col-lg-6 mb-0 d-flex align-items-center">
                                    <div className="text-align-left align-self-center">
                                        <h1 className="h1 text-success" style={{ WebkitTextStroke: '1px black', textShadow: '2px 2px 4px rgba(0, 0, 0, 1)' }}>
                                            <b>Submit Your Design</b>
                                        </h1>
                                        <div style={{ marginBottom: '20px' }}></div>
                                        <h3 className="h2"><b>Are you an artist.</b></h3>
                                        <h3 className="h2"><b>Submit your own design for others to choose from.</b></h3>
                                        <h3 className="h2"><b>Share your unique style with the world!</b></h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div className="carousel-item">
                        <div className="container">
                            <div className="row p-5">
                                <div className="mx-auto col-md-8 col-lg-6 order-lg-last">
                                    <img className="img-fluid" src="./assets/images/home3.svg" alt="Home 3" />
                                </div>
                                <div className="col-lg-6 mb-0 d-flex align-items-center">
                                    <div className="text-align-left align-self-center">
                                        <h1 className="h1 text-success" style={{ WebkitTextStroke: '1px black', textShadow: '2px 2px 4px rgba(0, 0, 0, 1)' }}>
                                            <b>Earn Royalty</b>
                                        </h1>
                                        <div style={{ marginBottom: '20px' }}></div>
                                        <h3 className="h2"><b>Earn money every time your design is printed.</b></h3>
                                        <h3 className="h2"><b>Turn your passion into profit!</b></h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <button className="carousel-control-prev" type="button" data-bs-target="#template-mo-zay-hero-carousel" data-bs-slide="prev" style={{ marginLeft: '-50px' }}>
                    <span className="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span className="visually-hidden">Previous</span>
                </button>
                <button className="carousel-control-next" type="button" data-bs-target="#template-mo-zay-hero-carousel" data-bs-slide="next" style={{ marginRight: '-50px' }}>
                    <span className="carousel-control-next-icon" aria-hidden="true"></span>
                    <span className="visually-hidden">Next</span>
                </button>
            </div>
            <div className="divider"></div>
            <div className="divider"></div>
            <div >
                <img src="./assets/images/home1.jpg" alt="About Hero" style={{ display: 'block', margin: '20px auto', maxWidth: '100%', height: 'auto' }}></img>

            </div>
        </div>
    );
}

export default Homepage;
