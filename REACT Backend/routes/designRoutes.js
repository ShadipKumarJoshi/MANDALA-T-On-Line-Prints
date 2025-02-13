const router = require('express').Router();
const designController = require('../controllers/designControllers')
const { authGuard } = require('../middleware/authGuard');

router.post('/createDesign', authGuard, designController.createDesign)

// fetch all  designs by logged-in user
router.get('/getAllDesigns', designController.getAllDesigns)
router.get('/getUserDesigns', authGuard, designController.getUserDesigns);
// router.get('/getUserDesigns', designController.getUserDesigns);



// fetch single design
// router.get('/get_single_design/:id', designController.getSingleDesign)
router.get('/getSingleDesign/:id', authGuard, designController.getSingleDesign)

// delete design
router.delete('/deleteDesign/:id', authGuard, designController.deleteDesign)

// update design
router.put('/updateDesign/:id', authGuard, designController.updateDesign)

// pagination query params for designs
router.get('/getPaginationDesigns', designController.getPaginationDesigns)

// search design
router.get('/searchDesign', designController.searchDesign)

module.exports = router