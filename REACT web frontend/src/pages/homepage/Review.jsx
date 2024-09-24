import React, { useEffect, useState } from 'react'
import { toast } from 'react-toastify'
import { createReviewApi, getAllReviews } from '../../apis/api'

// 1. UI 
const Review = () => {

    // X.1. Use state for all fetched reviews from backend
    const [reviews, setReviews] = useState([]) // array[]

    // X.2. Call API initially (Page load) - Set all fetch reviews to state (X.1.)
    useEffect(() => {

        getAllReviews().then((res) => {

            // response : res.data.reviews (All Reviews)
            setReviews(res.data.reviews)


        }).catch((error) => {
            console.log(error)

        })
    }, []) // [] is dependencies of useEffect ie . useEffect works only when [] is supplied
    console.log(reviews)

    //  2. use State define
    const [reviewName, setReviewName] = useState('')
    const [reviewDescription, setProducDescription] = useState('')
    const [reviewRating, setReviewRating] = useState('5 STARS')
    // 2.1. useState for image
    const [reviewImage, setReviewImage] = useState('')
    const [previewImage, setPreviewImage] = useState('')

    // 3. image upload handler // can use e/event below
    const handleImage = (event) => { // can use e also instead of event
        const file = event.target.files[0]
        setReviewImage(file) //for backend
        setPreviewImage(URL.createObjectURL(file)) // for temporary preview


    }



    // handle submit
    const handleSubmit = (e) => {
        e.preventDefault()


        // make a from-data (txt, file)
        const formData = new FormData()
        formData.append('reviewName', reviewName)
        formData.append('reviewDescription', reviewDescription)

        formData.append('reviewRating', reviewRating)
        formData.append('reviewImage', reviewImage)

        // Make a api call
        createReviewApi(formData).then((res) => {


            // For SUCCESSFUL API
            if (res.status === 201) {
                toast.success(res.data.message);
                window.location.reload();
            }

        }).catch((error) => {
            // For ERROR status code
            if (error.response) {
                if (error.response.status === 400) {
                    toast.warning(error.response.data.message)
                } else if (error.response.status === 500) {
                    toast.error(error.response.data.message)
                } else {
                    toast.error("Something went wrong!")
                }

            } else {
                toast.error("Something went wrong!")
            }

        });

    };



    return (
        <>
            <div className='container mt-3'>
                <div className='d-flex justify-content-between' >
                    <h3 style={{ fontWeight: 'bold' }}>REVIEW and RATINGS</h3>
                    {/* <button className='btn btn-danger'>Add review</button> */}

                    {/* modal from getbootstrap instead of button above*/}
                    {/* <!-- Button trigger modal --> */}
                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#exampleModal" style={{
                        width: '100px',
                        height: '100px',
                        borderRadius: '50%',
                        padding: 0,
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        boxShadow: '0px 4px 6px rgba(5, 5, 5, 5)',
                        backgroundColor: 'green',
                        fontWeight: 'bold'
                    }}>
                        Add Review
                    </button>

                    {/* <!-- Modal --> */}
                    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="exampleModalLabel" style={{ fontWeight: 'bold' }}>Add a new review</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    {/* ... */}
                                    {/* Form for review */}
                                    <form action="">

                                        <label className='mt-2' style={{ fontWeight: 'bold' }}>Display Name</label>
                                        <input onChange={(e) => setReviewName(e.target.value)} className='form-control' placeholder='Enter your display name?'></input>

                                        <label className='mt-2' style={{ fontWeight: 'bold' }}>Review Description</label>
                                        <textarea onChange={(e) => setProducDescription(e.target.value)} className='form-control' ></textarea>


                                        <label className='mt-2' style={{ fontWeight: 'bold' }}>Rating</label>
                                        <select value={reviewName} onChange={(e) => setReviewRating(e.target.value)} className='form-control' >

                                            <option value='T-5 STARS' >5 STARS</option>
                                            <option value='4 STAR' >4 STAR</option>
                                            <option value='3 STAR'>3 STAR</option>
                                            <option value='2 STAR'>2 STAR</option>
                                            <option value='1 STAR'>1 STAR</option>
                                        </select>


                                        <label className='mt-2' style={{ fontWeight: 'bold' }}>Review Image</label>
                                        <input onChange={handleImage} type='file' className='form-control' ></input>

                                        {/* Image Preview for dynamic preview */}
                                        {
                                            previewImage && <img src={previewImage} alt="preview image" className='img-fluid rounded mt-2' /> // img-fluid fits the image
                                        }


                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                    <button onClick={handleSubmit} type="button" class="btn btn-primary">Save  </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <table className="table mt-2">
                    <thead className="table-dark">
                        <tr>
                            <th>Image</th>
                            <th>Review Name</th>
                            <th>Review Description</th>
                            <th>Review Rating</th>
                        </tr>



                    </thead>
                    <tbody>

                        {
                            reviews.map((singleReview) => (
                                <tr>
                                    <td><img width={'100px'} height={'100px'} src={`http://localhost:8000/reviews/${singleReview.reviewImage}`} alt="" /></td>
                                    <td>{singleReview.reviewName}</td>
                                    <td>{singleReview.reviewDescription}</td>
                                    <td>{singleReview.reviewRating}</td>
                                    <td>


                                    </td>
                                </tr>
                            ))
                        }


                    </tbody>
                </table>
            </div>
        </>
    )
}

export default Review


// EDIT PRODUCT -------------------------------------------------
//  review is in Admin Dashboard (Table)
// Make a new route (Admin Edit Review)
// Fill all the related information of the chose review only.
// It must be editable( both text , file)
// make a backend to update review.

