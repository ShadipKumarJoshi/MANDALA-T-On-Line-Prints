const orderModel = require("../models/orderModel");

exports.addOrder = async (req, res) => {
  console.log(req.body);
  const { carts, address, total, paymentType } = req.body;

  try {
    const order = await orderModel({
      carts,
      address,
      total,
      paymentType,
      userId: req.user.id,
    });

    await order.save();

    res.status(201).json({ success: true, order });
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: error.message });
  }
};

// Update Order Status function
exports.updateOrderStatus = async (req, res) => {
  const { id } = req.params;
  const { status } = req.body;

  try {
    const order = await orderModel.findByIdAndUpdate(id, { status }, { new: true });

    if (!order) {
      return res.status(400).json({ error: "Order not found" });
    }

    res.status(201).json({ success: true, order });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};


// Get All Orders function
exports.getAllOrders = async (req, res) => {
  try {
    const orders = await orderModel.find().populate('carts');

    res.status(201).json({ success: true, orders });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Get User Orders function
exports.getUserOrders = async (req, res) => {
  const userId = req.user.id;

  try {
    const orders = await orderModel.find({ userId }).populate('carts');

    res.status(201).json({ success: true, orders });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};