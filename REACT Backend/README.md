# Mandala T-On-Line_Prints - Backend

## Overview
The backend for the **Mandala T-On-Line_Prints** is built with Node.js and provides essential functionalities for customizing design prints on garments. It handles data management, authentication, and various API endpoints for products, designs, customer management, and billing.

## Features
API Endpoints
### User API
Api.post('/api/user/createUser', data)

Api.post('/api/user/loginUser', data)

Api.get('/api/user/getUser', config) 

Api.put('/api/user/updateUserProfile', data, config)

### Product API
Api.post('/api/product/createProduct', data, config)

Api.get('/api/product/getAllProducts', config)

Api.get(`/api/product/getSingleProduct/${id}`, config)

Api.delete(`/api/product/deleteProduct/${id}`, config)

Api.put(`/api/product/updateProduct/${id}`, data, config) 


### Design API
Api.post('/api/design/createDesign', data, config)

 Api.get('/api/design/getAllDesigns', config)

 Api.get(`/api/design/getPaginationDesigns?page=${page}`, config)

 Api.delete(`/api/design/deleteDesign/${id}`, config)


### Favourites API
 Api.post('/api/review/createReview', data, config)

 Api.get('/api/review/getAllReviews', config)


### Cart API
 Api.post("/api/cart/add", data, config);

 Api.get("/api/cart/all", config);

 Api.put(`/api/cart/update/${id}`, data, config);

Api.delete(`/api/cart/delete/${id}`, config);


### Order API
Api.get("/api/order/getAllOrders", config);

Api.post("/api/order/create", data, jsonConfig);

Api.put(`/api/order/update/${id}`, data, config);


## Technologies Used
**Node.js:** Server-side runtime environment.

**Express.js:** Backend framework for building web applications.

**MongoDB:** NoSQL database for storing data.

**Mongoose:** Object Data Modeling (ODM) library for MongoDB and Node.js.
## Environment Variables
The following environment variables must be set:

PORT = 8000
MONGODB_CLOUD: MongoDB connection string.
JWT_SECRET: Secret key for JWT authentication.
EMAIL='your_eail@gmail.com'
EMAIL_PASSWORD='your email key

## Environment Variables
[REACT_APP_Frontend_URL](https://github.com/st6003/frontend-seca-ShadipKumarJoshi.git)

## Author
Shadip Kumar Joshi

