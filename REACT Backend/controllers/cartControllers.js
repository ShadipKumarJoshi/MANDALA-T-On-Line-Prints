// controllers/cartController.js
const path = require('path')
const Cart = require("../models/cartModel");
const Product = require("../models/productModel");
const Design = require("../models/designModel");

exports.addToCart = async (req, res) => {
    const { productId, designId, quantity, productSize, productColor, total } = req.body;
    const userId = req.user.id;

    if (!productId || !designId || !quantity || !productSize || !productColor || !total) {
        return res.status(400).json({ message: "Please enter all fields" });
    }

    try {
        const product = await Product.findById(productId);
        const design = await Design.findById(designId);

        if (!product) {
            return res.status(404).json({ message: "Product not found" });
        }

        if (!design) {
            return res.status(404).json({ message: "Design not found" });
        }

        const itemInCart = await Cart.findOne({
            productId: productId,
            designId: designId,
            userId: userId,
            productSize: productSize,
            productColor: productColor,
            status: "active",
        });

        const customizePrice = product.productPrice + design.designPrice;

        if (itemInCart) {
            itemInCart.quantity += parseInt(quantity, 10);
            itemInCart.total = itemInCart.quantity * (total / quantity);
            itemInCart.customizePrice = customizePrice;
            await itemInCart.save();
            return res.status(201).json({ message: "Item quantity updated", cartItem: itemInCart });
        }

        const cartItem = new Cart({
            productId: productId,
            designId: designId,
            quantity: parseInt(quantity, 10),
            productSize: productSize,
            productColor: productColor,
            total: total,
            userId: userId,
            customizePrice: customizePrice,
        });

        await cartItem.save();
        res.status(201).json({ message: "Item added to cart", cartItem });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.getAllCartItems = async (req, res) => {
    const userId = req.user.id;
    try {
        const cartItems = await Cart.find({
            userId: userId,
            status: "active",
        }).populate("productId designId");
        res.status(201).json({ carts: cartItems });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.deleteCartItem = async (req, res) => {
    try {

        console.log(req.params);
        const { id } = req.params;

        console.log(req.params);
        await Cart.findByIdAndDelete(id);
        res.json({ message: "Item deleted successfully" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.updateCartItem = async (req, res) => {
    try {
        const { id } = req.params;
        let { quantity, total, productSize, productColor } = req.body;

        quantity = Number(quantity);
        if (isNaN(quantity) || quantity <= 0) {
            return res.status(400).json({ error: "Quantity must be a valid number greater than zero" });
        }

        await Cart.findByIdAndUpdate(id, { quantity, total, productSize, productColor });
        res.status(201).json({ message: "Item updated successfully" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.updateUserCartStatus = async (req, res) => {
    try {
        const userId = req.user.id;
        const { status } = req.body;

        const cartItems = await Cart.updateMany({ userId: userId }, { status: status });
        res.status(201).json({ message: "Cart status updated successfully", cartItems });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
