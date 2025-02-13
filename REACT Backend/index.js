// http://localhost:8000 
// console.log('hello Mandala users')

// importing libraries
const express = require('express');
// const mongoose = require("mongoose");
// const connectDatabase = require('./database/database');
const dotenv = require('dotenv');
const { options } = require('./routes/userRoutes');
const cors = require('cors');
const connectDatabase = require('./database/database')
const acceptFormData = require('express-fileupload')
const favouritesRoutes = require("./routes/favouritesRoutes"); // Import favourites routes
const cartRoutes = require("./routes/cartRoutes"); // Import cart routes

//instance of express application
const app = express();

// Configure Cors Policy
const CorsOptions = {
    origin: true,
    credentials: true,
    optionSuccessStatus: 200
}
app.use(cors(CorsOptions))
app.set('view engine', 'ejs');
app.use(express.urlencoded({ extended: true }));


// Express Json Config
app.use(express.json())

// Config form-data
app.use(acceptFormData())

// Make a static public folder for image
app.use(express.static("./public"))

// configuration dotenv
dotenv.config()




// Connecting to database
connectDatabase()

// mongoose.connect('mongodb://localhost:27017').then(() => {

//     console.log("DB CONNECTED!");

// });

// Define PORT and listen to the app
const PORT = process.env.PORT;


/// CODE AREA

// Making a test endpoint
// Endpoints : 4 types : POST, GET, PUT, DELETE needs path and function
// path , function

app.get('/test', (req, res) => {
    res.send("Test API is working!...")
})

// http://localhost:8000/test // api url generated

// Configuring Routes of User
app.use('/api/user', require('./routes/userRoutes'))

// Configuring Routes of Product
app.use('/api/product', require('./routes/productRoutes'))
app.use('/api/design', require('./routes/designRoutes'))
app.use('/api/review', require('./routes/reviewRoutes'))

// Use favouritesRoutes for /api/favourites endpoints
app.use("/api/favourite", favouritesRoutes);

// Use cartRoutes for /api/cart endpoints
app.use("/api/cart", cartRoutes);

app.use("/api/order", require("./routes/orderRoutes"));

// for testing
module.exports = app;





//http://localhost:8000/api/user/create
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`)
});

// Create a test route.
app.get('/', (req, res) => {

    res.send('Hello World!');

});