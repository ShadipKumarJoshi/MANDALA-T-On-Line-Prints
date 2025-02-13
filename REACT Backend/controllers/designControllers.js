const path = require('path')
const designModel = require('../models/designModel')
const fs = require('fs') // fs= filesystem

const createDesign = async (req, res) => {
    // res.send("Create design API is working...")

    // Check incoming data // form data // not raw data
    // npm install express-fileupload
    console.log(req.body)
    console.log(req.files)

    // Destructuring the body data (json)
    const { designName,
        designPrice,
        designCategory,
        designDescription
    } = req.body;

    // Validation
    if (!designName || !designPrice || !designCategory || !designDescription) {
        return res.status(400).json({
            "success": false,
            "message": "Enter all fields!"
        })
    }

    // validate for image
    if (!req.files || !req.files.designImage) {
        return res.status(400).json({
            "success": false,
            "message": "Image not found!"
        })
    }
    const { designImage } = req.files;

    // Upload image
    // 1. Generate new unique image name (abc.png) -> (213456-abc.png)
    const imageName = `${Date.now()}-${designImage.name}`

    // 2. Make an upload path (/path/upload - directory)
    const imageUploadPath = path.join(__dirname, `../public/designs/${imageName}`)    // 2 underscores __directory name, then make a public folder with designs

    // 3. Move to that directory (await for background upload, try-catch  for internet crashes)
    try {
        await designImage.mv(imageUploadPath) // mv is move
        // res.send("Image Uploaded Successfully!")'

        console.log(req.user)

        // Save to database
        const newDesign = new designModel({
            designName: designName,
            designPrice: designPrice,
            designCategory: designCategory,
            designDescription: designDescription,
            designImage: imageName, // design iumage is imageName that is changed as a unique name
            createdBy: req.user.id
        })
        const design = await newDesign.save() // it takes time to save to database
        return res.status(201).json({
            "success": true,
            "message": "Design Created Successfuly!",
            "data": design
        })


    } catch (error) {
        console.log(error)
        return res.status(500).json({
            "success": false,
            "message": "Internal Server Error!",
            "error": error
        })

    }


};


// Fetch all designs
const getUserDesigns = async (req, res) => {
    // Get the ID of the logged-in user from the request object
    const loggedInUserId = req.user.id;
    // try catch
    try {
        // const allDesigns = await designModel.find({})
        // Find all designs created by the logged-in user
        const userDesigns = await designModel.find({ createdBy: loggedInUserId });

        console.log(userDesigns)

        return res.status(201).json({
            "success": true,
            "message": "Design Fetched Successfully!",
            // "designs": allDesigns
            "designs": userDesigns
        })
    } catch (error) {
        console.log(error)
        return res.status(500).json({
            "success": false,
            "message": "Internal server error!",
            "error": error
        })

    }
    // Fetch ALL designs
    // Send Response


}

// Fetch all designs
const getAllDesigns = async (req, res) => {
    try {
        const allDesigns = await designModel.find({});
        return res.status(201).json({
            "success": true,
            "message": "Designs Fetched Successfully!",
            "designs": allDesigns
        });
    } catch (error) {
        console.log(error);
        return res.status(500).json({
            "success": false,
            "message": "Internal server error!",
            "error": error
        });
    }
};

// Fetch single design
const getSingleDesign = async (req, res) => {

    // get design id of editable design from URL (params) 
    const designId = req.params.id;

    // Find the design from id
    try {
        const design = await designModel.findById(designId)

        // Check if the design exists and belongs to the logged-in user
        // if (!design) {
        if (!design || !design.createdBy.equals(req.user.id)) {
            return res.status(400).json({
                "success": false,
                "message": "No design found!",
            })

        }
        return res.status(201).json({
            "success": true,
            "message": "Design Fetched Successfully!",
            "designs": design
        })

    } catch (error) {
        return res.status(500).json({
            "success": false,
            "message": "Internal server error!",
            "error": error
        })
    }

}

// delete prosuct
const deleteDesign = async (req, res) => {

    // ---- design delete/ but doesn't delete pic in backend public folder
    // try {
    //     await designModel.findByIdAndDelete(req.params.id)
    //     return res.status(201).json({
    //         "success": true,
    //         "message": "Design deleted succesfully!",
    //     })

    // } catch (error) {
    //     console.log(error)
    //     return res.status(500).json({
    //         "success": false,
    //         "message": "Internal server error!",
    //         "error": error
    //     })
    // }


    // .......... design delete and image from backend in public delete too


    try {
        // Find the design by ID to get the image filename
        const design = await designModel.findById(req.params.id);

        // If design does not exist, return an error response
        // if (!design) {

        // Check if the design exists and belongs to the logged-in user
        if (!design || !design.createdBy.equals(req.user.id)) {
            return res.status(400).json({
                "success": false,
                "message": "No design found!"
            });
        }

        // Delete the design from the database
        await designModel.findByIdAndDelete(req.params.id);

        // Path of the image to be deleted
        const imagePath = path.join(__dirname, `../public/designs/${design.designImage}`);

        // Delete the image file from the filesystem
        fs.unlink(imagePath, (err) => {
            if (err) {
                console.error("Error deleting the image file:", err);
                return res.status(400).json({
                    "success": false,
                    "message": "Design deleted but failed to delete image!",
                    "error": err
                });
            }
            return res.status(201).json({
                "success": true,
                "message": "Design deleted successfully!"
            });
        });

    } catch (error) {
        console.log(error)
        return res.status(500).json({
            "success": false,
            "message": "Internal server error!",
            "error": error
        })
    }
}

// Update Design
// 1. get design id (url)
// 2. if image :
// 3. New image should be upoaded
// 4. Old image should be deleted
// 5. find design (database) designImage
// 6. find the image in directory
// 7. delete the image
// 8. update the design

const updateDesign = async (req, res) => {
    try {
        // if there is image
        if (req.files && req.files.designImage) {
            // destructuring 
            const { designImage } = req.files;

            // upload image to /public/designs folder
            // 1. Generate new unique image name (abc.png) -> (213456-abc.png)
            const imageName = `${Date.now()}-${designImage.name}`

            // 2. Make an upload path (/path/upload - directory)
            const imageUploadPath = path.join(__dirname, `../public/designs/${imageName}`)    // 2 underscores __directory name, then make a public folder with designs


            // move to folder
            await designImage.mv(imageUploadPath)

            // req.params has  (id ), req.body( has updated data - design name, pp, pc, pd), req. files (image)
            // add new field to req.body (designImage -> namae)
            req.body.designImage = imageName; // image uploaded and  its generated name

            // if image is uploaded and req.body is assigned ==>delete old image
            if (req.body.designImage) {

                // Finding existing design
                const existingDesign = await designModel.findById(req.params.id)

                // Searching in the directory/folder
                const oldImagePath = path.join(__dirname, `../public/designs/${existingDesign.designImage}`)    // 2 underscores __directory name, then make a public folder with designs

                // delete old image from filesystem
                fs.unlinkSync(oldImagePath)
            }

        }

        // update the data
        const updatedDesign = await designModel.findByIdAndUpdate(req.params.id, req.body)
        return res.status(201).json({
            "success": true,
            "message": "Design updated!",
            "design": updatedDesign

        })


    } catch (error) {
        console.log(error)
        return res.status(500).json({
            "success": false,
            "message": "Internal server error!",
            "error": error
        })
    }


}
// PAGINATION

const getPaginationDesigns = async (req, res) => {

    // page no
    const pageNo = req.query.page || 1; // default value is 1 

    // Result per page
    // const resultPerPage = 4;
    const resultPerPage = req.query.limit || 4; // default value is 4
    try {
        // Find all designs, skip, limit
        const designs = await designModel.find({})
            .skip((pageNo - 1) * resultPerPage)
            .limit(resultPerPage)

        // if page 6 is requested, result is 0 if no design
        if (designs.length === 0) {
            return res.status(400).json({
                'success': false,
                'message': "No design Found!"
            })
        }

        // response
        res.status(201).json({
            'success': true,
            'message': "Design Fetched!",
            'designs': designs
        })

    } catch (error) {
        console.log(error)
        res.status(500).json({
            'success': false,
            'message': "Internal Server Error"
        })
    }



}

// Searching
const searchDesign = async (req, res) => {
    const searchQuery = req.query.q || '';
    const searchCategory = req.query.category || '';

    try {
        // search and filter using name and category
        const filter = {};

        // if searchQuery is not empty
        if (searchQuery) {
            filter.designName = { $regex: searchQuery, $options: 'i' };
        }

        // if searchCategory is not empty
        if (searchCategory) {
            filter.designCategory = { $regex: searchCategory, $options: 'i' };
        }

        // find designs
        const designs = await designModel.find(filter);

        // send the found designs as response
        res.status(201).json({
            'success': true,
            'message': "Design Fetched!",
            'designs': designs
        });
    } catch (error) {
        console.log(error);

        // handle error
        res.status(500).json({
            'success': false,
            'message': "Server Error!"
        });
    }
};


module.exports = {
    createDesign,
    getAllDesigns,
    getUserDesigns,
    getSingleDesign,
    deleteDesign,
    updateDesign,
    getPaginationDesigns,
    searchDesign
}