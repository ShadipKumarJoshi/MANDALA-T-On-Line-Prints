const path = require('path')
const productModel = require('../models/productModel')
const fs = require('fs') // fs= filesystem

const createProduct = async (req, res) => {
    // res.send("Create product API is working...")

    // Check incoming data // form data // not raw data
    // npm install express-fileupload
    console.log(req.body)
    console.log(req.files)

    // Destructuring the body data (json)
    const { productCategory,
        productPrice,
        productSize,
        productColor,
        productDescription
    } = req.body;

    // Validation
    if (!productCategory || !productPrice || !productSize || !productColor || !productDescription) {
        return res.status(400).json({
            "success": false,
            "message": "Enter all fields!"
        })
    }

    // validate for image
    if (!req.files || !req.files.productImage) {
        return res.status(400).json({
            "success": false,
            "message": "Image not found!"
        })
    }
    const { productImage } = req.files;

    // Upload image
    // 1. Generate new unique image name (abc.png) -> (213456-abc.png)
    const imageName = `${Date.now()}-${productImage.name}`

    // 2. Make an upload path (/path/upload - directory)
    const imageUploadPath = path.join(__dirname, `../public/products/${imageName}`)    // 2 underscores __directory name, then make a public folder with products

    // 3. Move to that directory (await for background upload, try-catch  for internet crashes)
    try {
        await productImage.mv(imageUploadPath) // mv is move
        // res.send("Image Uploaded Successfully!")

        // Save to database
        const newProduct = new productModel({
            productCategory: productCategory,
            productPrice: productPrice,
            productSize: productSize,
            productColor: productColor,
            productDescription: productDescription,
            productImage: imageName // product iumage is imageName that is changed as a unique name
        })
        const product = await newProduct.save() // it takes time to save to database
        res.status(201).json({
            "success": true,
            "message": "Product Created Successfuly!",
            "data": product
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


// Fetch all products
const getAllProducts = async (req, res) => {
    // try catch
    try {
        const allProducts = await productModel.find({})
        res.status(201).json({
            "success": true,
            "message": "Product Fetched Successfully!",
            "products": allProducts
        })
    } catch (error) {
        console.log(error)
        res.status(500).json({
            "success": false,
            "message": "Internal server error!",
            "error": error
        })

    }
    // Fetch ALL products
    // Send Response


}

// Fetch single product
const getSingleProduct = async (req, res) => {

    // get product id of editable product from URL (params) 
    const productId = req.params.id;

    // Find the product from id
    try {
        const product = await productModel.findById(productId)
        if (!product) {
            res.status(400).json({
                "success": false,
                "message": "No product found!",
            })

        }
        res.status(201).json({
            "success": true,
            "message": "Product Fetched Successfully!",
            "products": product
        })

    } catch (error) {
        res.status(500).json({
            "success": false,
            "message": "Internal server error!",
            "error": error
        })
    }

}

// delete prosuct
const deleteProduct = async (req, res) => {

    // ---- product delete/ but doesn't delete pic in backend public folder
    // try {
    //     await productModel.findByIdAndDelete(req.params.id)
    //     res.status(201).json({
    //         "success": true,
    //         "message": "Product deleted succesfully!",
    //     })

    // } catch (error) {
    //     console.log(error)
    //     res.status(500).json({
    //         "success": false,
    //         "message": "Internal server error!",
    //         "error": error
    //     })
    // }


    // .......... product delete and image from backend in public delete too


    try {
        // Find the product by ID to get the image filename
        const product = await productModel.findById(req.params.id);

        // If product does not exist, return an error response
        if (!product) {
            return res.status(400).json({
                "success": false,
                "message": "No product found!"
            });
        }

        // Delete the product from the database
        await productModel.findByIdAndDelete(req.params.id);

        // Path of the image to be deleted
        const imagePath = path.join(__dirname, `../public/products/${product.productImage}`);

        // Delete the image file from the filesystem
        fs.unlink(imagePath, (err) => {
            if (err) {
                console.error("Error deleting the image file:", err);
                return res.status(500).json({
                    "success": false,
                    "message": "Product deleted but failed to delete image!",
                    "error": err
                });
            }
            res.status(201).json({
                "success": true,
                "message": "Product deleted successfully!"
            });
        });

    } catch (error) {
        console.log(error)
        res.status(500).json({
            "success": false,
            "message": "Internal server error!",
            "error": error
        })
    }
}

// Update Product
// 1. get product id (url)
// 2. if image :
// 3. New image should be upoaded
// 4. Old image should be deleted
// 5. find product (database) productImage
// 6. find the image in directory
// 7. delete the image
// 8. update the product

const updateProduct = async (req, res) => {
    try {
        // if there is image
        if (req.files && req.files.productImage) {
            // destructuring 
            const { productImage } = req.files;

            // upload image to /public/products folder
            // 1. Generate new unique image name (abc.png) -> (213456-abc.png)
            const imageName = `${Date.now()}-${productImage.name}`

            // 2. Make an upload path (/path/upload - directory)
            const imageUploadPath = path.join(__dirname, `../public/products/${imageName}`)    // 2 underscores __directory name, then make a public folder with products


            // move to folder
            await productImage.mv(imageUploadPath)

            // req.params has  (id ), req.body( has updated data - product name, pp, pc, pd), req. files (image)
            // add new field to req.body (productImage -> namae)
            req.body.productImage = imageName; // image uploaded and  its generated name

            // if image is uploaded and req.body is assigned ==>delete old image
            if (req.body.productImage) {

                // Finding existing product
                const existingProduct = await productModel.findById(req.params.id)

                // Searching in the directory/folder
                const oldImagePath = path.join(__dirname, `../public/products/${existingProduct.productImage}`)    // 2 underscores __directory name, then make a public folder with products

                // delete old image from filesystem
                fs.unlinkSync(oldImagePath)
            }

        }

        // update the data
        const updatedProduct = await productModel.findByIdAndUpdate(req.params.id, req.body)
        res.status(201).json({
            "success": true,
            "message": "Product updated!",
            "product": updatedProduct

        })


    } catch (error) {
        console.log(error) 
            res.status(500).json({
                "success": false,
                "message": "Internal server error!",
                "error": error
            })
        }
    

}

// PAGINATION

const getPaginationProducts = async (req, res) => {

    // page no
    const pageNo = req.query.page || 1; // default value is 1 

    // Result per page
    const resultPerPage = 4;
    try {
        // Find all products, skip, limit
        const products = await productModel.find({})
            .skip((pageNo - 1) * resultPerPage)
            .limit(resultPerPage)

        // if page 6 is requested, result is 0 if no product
        if (products.length === 0) {
            return res.status(400).json({
                'success': false,
                'message': "No product Found!"
            })
        }

        // response
        res.status(201).json({
            'success': true,
            'message': "Product Fetched!",
            'products': products
        })

    } catch (error) {
        console.log(error)
        res.status(500).json({
            'success': false,
            'message': "Internal Server Error"
        })
    }



}

module.exports = {
    createProduct,
    getAllProducts,
    getSingleProduct,
    deleteProduct,
    updateProduct,
    getPaginationProducts
}