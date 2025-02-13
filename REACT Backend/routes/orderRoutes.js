const router = require("express").Router();

const orderController = require("../controllers/orderController");
const { authGuard } = require("../middleware/authGuard");

router.post("/create", authGuard, orderController.addOrder);
router.put("/update/:id", authGuard, orderController.updateOrderStatus);
router.get("/getAllOrders",  orderController.getAllOrders);
router.get("/getUserOrders", authGuard, orderController.getUserOrders);

module.exports = router;
