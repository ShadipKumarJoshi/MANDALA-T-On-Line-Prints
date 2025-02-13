const path = require('path')
const reviewModel = require('../models/reviewModel')
const fs = require('fs') // fs= filesystem

const createReview = async (req, res) => {
    // res.send("Create review API is working...")

    // Check incoming data // form data // not raw data
    // npm install express-fileupload
    console.log(req.body)
    console.log(req.files)

    // Destructuring the body data (json)
    const { reviewName,
        reviewDescription,
        reviewRating,
    } = req.body;

    // Validation
    if (!reviewName || !reviewDescription || !reviewRating) {
        return res.status(400).json({
            "success": false,
            "message": "Enter all fields!"
        })
    }

    // validate for image
    if (!req.files || !req.files.reviewImage) {
        return res.status(400).json({
            "success": false,
            "message": "Image not found!"
        })
    }
    const { reviewImage } = req.files;

    // Upload image
    // 1. Generate new unique image name (abc.png) -> (213456-abc.png)
    const imageName = `${Date.now()}-${reviewImage.name}`

    // 2. Make an upload path (/path/upload - directory)
    const imageUploadPath = path.join(__dirname, `../public/reviews/${imageName}`)    // 2 underscores __directory name, then make a public folder with reviews

    // 3. Move to that directory (await for background upload, try-catch  for internet crashes)
    try {
        await reviewImage.mv(imageUploadPath) // mv is move
        // res.send("Image Uploaded Successfully!")

        // Save to database
        const newReview = new reviewModel({
            reviewName: reviewName,
            reviewDescription: reviewDescription,
            reviewRating: reviewRating,
            reviewImage: imageName // review iumage is imageName that is changed as a unique name
        })



        const review = await newReview.save() // it takes time to save to database
        res.status(201).json({
            "success": true,
            "message": "Review Created Successfuly!",
            "data": review
        })


    } catch (error) {
        console.log(error)
        res.status(500).json({
            "success": false,
            "message": "Internal Server Error!",
            "error": error
        })

    }


};


// Fetch all reviews
const getAllReviews = async (req, res) => {
    // try catch
    try {
        const allReviews = await reviewModel.find({})
        res.status(201).json({
            "success": true,
            "message": "Review Fetched Successfully!",
            "reviews": allReviews
        })
    } catch (error) {
        console.log(error)
        res.status(500).json({
            "success": false,
            "message": "Internal server error!",
            "error": error
        })

    }
    // Fetch ALL reviews
    // Send Response


}

module.exports = {
    createReview,
    getAllReviews,

}