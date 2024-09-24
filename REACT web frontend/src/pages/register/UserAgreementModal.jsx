import React from 'react';
import { Button, Modal } from 'react-bootstrap';

const UserAgreementModal = ({ show, handleClose, handleAgree }) => {
    return (
        <Modal show={show} onHide={handleClose}>
            <Modal.Header closeButton>
                <Modal.Title>User Agreement</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <p>Welcome to Mandala T-On-Line T-Shirts, an online platform ("the Platform") provided by Mandala Prints Pvt. Ltd. ("Mandala Prints", "we", "us", or "our"). These terms of use (the "User Agreement") govern your use of the Platform, whether you are a user browsing the Platform ("User", "you", and "your") or an artist selling designs on the Platform ("Artist", "Seller").</p>

                <p>By accessing or using the Platform, you agree to be bound by the terms of this User Agreement. If you do not agree to these terms, you may not use the Platform.</p>

                <h4>I. General Terms for All Users</h4>
                <p><strong>Eligibility:</strong> The Platform is only available to individuals who can form legally binding contracts under applicable law. By using the Platform, you represent and warrant that you are at least 18 years old. Minors are not permitted to use the Platform unless supervised by a parent or legal guardian.</p>

                <p><strong>Amendments:</strong> Mandala Prints reserves the right to amend this User Agreement at any time in its sole discretion. We will make reasonable efforts to notify users of material changes. Your continued use of the Platform after such changes constitutes your acceptance of the revised User Agreement.</p>

                <p><strong>Account Management:</strong> When creating an account on the Platform, you must provide accurate and complete information. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. You must notify Mandala Prints immediately of any unauthorized use of your account or any other breach of security. Mandala Prints reserves the right to suspend or terminate your account if you provide false information or violate any terms of this User Agreement.</p>

                <h4>II. Special Terms for Buyers</h4>
                <ul>
                    <li>Buyers must ensure that they provide accurate shipping information to Mandala Prints.</li>
                    <li>Buyers are responsible for any customs duties or taxes associated with their purchases.</li>
                    <li>Buyers may only use the Platform for lawful purposes and may not engage in any fraudulent or illegal activities.</li>
                </ul>

                <h4>III. Special Terms for Artists</h4>
                <ul>
                    <li>Artists retain ownership of the designs they upload to the Platform.</li>
                    <li>By uploading designs, artists grant Mandala Prints a non-exclusive, worldwide, royalty-free license to use, display, and reproduce their designs for the purpose of promoting and selling products on the Platform.</li>
                    <li>Artists are responsible for ensuring that their designs comply with copyright and intellectual property laws. Mandala Prints reserves the right to remove any designs that violate these laws or our content guidelines.</li>
                    <li>Artists are entitled to receive royalties for each sale of products featuring their designs, as specified in our royalty policy.</li>
                </ul>

                <h4>IV. Dispute Resolution</h4>
                <p>Any dispute arising out of or relating to this User Agreement or your use of the Platform shall be resolved exclusively through arbitration in accordance with the rules of the [Arbitration Institution]. The arbitration shall be conducted by a single arbitrator appointed in accordance with those rules. You waive any right to participate in a class action lawsuit or class-wide arbitration.</p>

                <p>By using the Platform, you acknowledge and agree to abide by the terms of this User Agreement.</p>

                <p>This User Agreement is effective as of 2024-01-11.</p>
            </Modal.Body>

            <Modal.Footer>
                <Button variant="primary" onClick={handleAgree}>
                    I have read the User Agreement
                </Button>
            </Modal.Footer>
        </Modal>
    );
};

export default UserAgreementModal;
