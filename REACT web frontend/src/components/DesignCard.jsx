import React, { useState } from 'react';
import { Button, Modal } from 'react-bootstrap';
import { FaHeart } from 'react-icons/fa';
import styled from "styled-components";
import { addToFavoriteApi } from "../apis/api";
import { toast } from 'react-toastify';


const DesignCard = ({ designInformation, color }) => {
    const [isFavorite, setIsFavorite] = useState(false);
    const [showModal, setShowModal] = useState(false);

    const toggleFavorite = () => setIsFavorite(!isFavorite);
    const handleShowModal = () => setShowModal(true);
    const handleCloseModal = () => setShowModal(false);

    const addToFavourites = async (design) => {
        try {
          await addToFavoriteApi({ designId: design._id });
          toast.success("Added to favourites successfully");
        } catch (error) {
          toast.error("Error adding to favourites");
        }
      };

    return (
        <>
            <div className="card" style={{ width: '15rem' }}>
                <span style={{ backgroundColor: color }} className="badge position-absolute top-0">
                    {designInformation.designCategory}
                </span>
                <img
                    src={`http://localhost:8000/designs/${designInformation.designImage}`}
                    className="card-img-top"
                    alt="..."
                    style={{ height: '15rem', objectFit: 'contain' }}
                />
                <div className="card-body">
                    <div className="d-flex justify-content-between">
                        <h5 className="card-title">{designInformation.designName}</h5>
                        <h5 className="card-title text-danger">NPR. {designInformation.designPrice}</h5>
                    </div>
                    <p>By: {designInformation.createdBy}</p>
                    <p className="card-text">{designInformation.designDescription.slice(0, 30)}</p>
                    <Button className="w-100" variant="outline-dark" onClick={handleShowModal} >View More</Button>
                </div>
                <span
                    className="position-absolute top-0 end-0 p-2"
                    style={{ cursor: 'pointer' }}
                    onClick={toggleFavorite}
                >
                    <FaHeart
                        style={{
                            color: isFavorite ? 'red' : 'transparent',
                            stroke: 'red', // Red outline for the heart
                            strokeWidth: 30, // Width of the outline
                            fontSize: '2rem', // Increase the size of the heart icon
                        }}
                        onClick={() => addToFavourites(designInformation)}
                    />
                </span>
            </div>

            <Modal show={showModal} onHide={handleCloseModal}>
                <Modal.Header closeButton>
                    <Modal.Title>Category: {designInformation.designCategory}</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <img
                        src={`http://localhost:8000/designs/${designInformation.designImage}`}
                        className="card-img-top"
                        alt={designInformation.designName}
                        style={{ height: '25rem', objectFit: 'contain' }} // Maintain aspect ratio
                    />
                    <span
                        className="position-absolute top-0 end-0 p-2"
                        style={{ cursor: 'pointer' }}
                        onClick={toggleFavorite}
                    >
                        <FaHeart
                            style={{
                                color: isFavorite ? 'red' : 'transparent',
                                stroke: 'red', // Red outline for the heart
                                strokeWidth: 30, // Width of the outline
                                fontSize: '2rem', // Increase the size of the heart icon
                            }}
                            onClick={() => addToFavourites(designInformation)}
                        />
                    </span>
                    <div className="d-flex justify-content-between">
                        <h5 className="card-title">{designInformation.designName}</h5>
                        <h5 className="card-title text-danger">NPR. {designInformation.designPrice}</h5>
                    </div>
                    <p>{designInformation.designDescription}</p>


                </Modal.Body>
                <Modal.Footer>
                    <Button variant="secondary" onClick={handleCloseModal}>
                        Close
                    </Button>
                    <Button variant="primary" >
                        Print
                    </Button>
                </Modal.Footer>
            </Modal>
        </>
    );
};

export default DesignCard;
