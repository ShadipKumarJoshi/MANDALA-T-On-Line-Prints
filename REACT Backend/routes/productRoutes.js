const router = require('express').Router();
const productController = require('../controllers/productControllers')
const { authGuard, adminGuard } = require('../middleware/authGuard');

router.post('/createProduct', adminGuard, productController.createProduct)

// fetch all products
// router.get('/get_all_products', productController.getAllProducts)
router.get('/getAllProducts', authGuard, productController.getAllProducts)

// fetch single product
// router.get('/get_single_product/:id', productController.getSingleProduct)
// router.get('/getSingleProduct/:id', authGuard, productController.getSingleProduct)
router.get('/getSingleProduct/:id', productController.getSingleProduct)

// delete product
router.delete('/deleteProduct/:id', adminGuard, productController.deleteProduct)

// update product
router.put('/updateProduct/:id', adminGuard, productController.updateProduct)

// pagination query params for products
router.get('/getPaginationProducts', productController.getPaginationProducts)



module.exports = router