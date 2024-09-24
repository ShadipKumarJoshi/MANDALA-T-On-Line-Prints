import axios from "axios";

// Creating backend Config!
const Api = axios.create({
    baseURL: "http://localhost:8000",
    withCredentials: true,
    headers: {
        "Content-Type": "multipart/form-data"

        // authorisation here means all can see the admin data, SO no authorisation here
        // 'authorization'
    }
})

// make a config for admin authorisation only
const config = {
    headers: {
        'authorization': `Bearer ${localStorage.getItem('token')}`,
    }
}

const jsonConfig = {
    headers: {
      "Content-Type": "application/json",
      authorization: "Bearer " + localStorage.getItem("token"),
    },
  };

// Test API
export const testApi = () => Api.get('/test') // same as in backend  /test

// Register API
export const registerUserApi = (data) => Api.post('/api/user/createUser', data) // (data) from frontend is received and sent to data in backend

// Login API
export const loginUserApi = (data) => Api.post('/api/user/loginUser', data)

// Forgot Password API by phone number
export const forgotPassword = (data) => Api.post('/api/user/forgotPassword', data)

// Forgot Password API by email
export const forgotPasswordByEmail = (data) => Api.post('/api/user/forgotPasswordByEmail', data)

// Verify Otp and set new password API
export const verifyOtpAndSetPassword = (data) => Api.post('/api/user/verifyOtpAndSetPassword', data)

// View User API
export const getUserProfile = () => Api.get('/api/user/getUser', config)

// update User API
export const updateUserProfile = (data) => Api.put('/api/user/updateUserProfile', data, config)

// update User Settings API
export const updateUserSettings = (data) => Api.put('/api/user/updateUserSettings', data, config)

// delete User API
export const deleteUserProfile = () => Api.delete('/api/user/deleteUser', config)


// ---------------//

// Create product API
export const createProductApi = (data) => Api.post('/api/product/createProduct', data, config)

// Get all products Api
// export const getAllProducts = () => Api.get('/api/product/get_all_products')
export const getAllProducts = () => Api.get('/api/product/getAllProducts', config)

// get single product  APi {ID is important} / use tilde 
// export const getSingleProduct = (id) => Api.get(`/api/product/get_single_product/${id}`)
export const getSingleProduct = (id) => Api.get(`/api/product/getSingleProduct/${id}`, config)

// delete single product  APi {ID is important} / use tilde 
// export const deleteProduct = (id) => Api.delete(`/api/product/delete_product/${id}`)

// delete single product  APi {ID is important} / use tilde : with ADMINGUARD
export const deleteProduct = (id) => Api.delete(`/api/product/deleteProduct/${id}`, config)

// update product
// export const updateProduct = (id, data) => Api.put(`/api/product/update_product/${id}`, data) // form data is also going / update

// update product : with ADMINGUARD
export const updateProduct = (id, data) => Api.put(`/api/product/updateProduct/${id}`, data, config) // form data is also going / update

// ------------ //

// Create design API
export const createDesignApi = (data) => Api.post('/api/design/createDesign', data, config)

// Get all designs Api
export const getAllDesigns = () => Api.get('/api/design/getAllDesigns', config)

//pagination for designs
export const getPaginationDesigns = (page) => Api.get(`/api/design/getPaginationDesigns?page=${page}`, config)


// search designs
export const searchDesigns = (search) => Api.get(`/api/design/searchDesigns?search=${search}`, config)

// Get User designs Api
// export const getAllDesigns = () => Api.get('/api/design/get_all_designs')
export const getUserDesigns = () => Api.get('/api/design/getUserDesigns', config)

// get single design  APi {ID is important} / use tilde 
// export const getSingleDesign = (id) => Api.get(`/api/design/get_single_design/${id}`)
export const getSingleDesign = (id) => Api.get(`/api/design/getSingleDesign/${id}`, config)

// delete single design  APi {ID is important} / use tilde 
export const deleteDesign = (id) => Api.delete(`/api/design/deleteDesign/${id}`, config)

// update design
export const updateDesign = (id, data) => Api.put(`/api/design/updateDesign/${id}`, data, config) // form data is also going / update

export const addToFavoriteApi = (data) =>
    Api.post("/api/favourite/add", data, config);

// get favorite by user
export const getFavoriteByUserApi = () => Api.get("/api/favourite/get", config);

// get all favorite
export const getAllFavoriteApi = () => Api.get("/api/favourite/all", config);

// delete favorite
export const deleteFromFavoriteApi = (id) =>
    Api.delete(`/api/favourite/delete/${id}`, config);

// Create design API
export const createReviewApi = (data) => Api.post('/api/review/createReview', data, config)

// Get all designs Api
export const getAllReviews = () => Api.get('/api/review/getAllReviews', config)

// add to cart
export const addToCartApi = (data) => Api.post("/api/cart/add", data, config);

// get all cart
export const getAllCartApi = () => Api.get("/api/cart/all", config);

// update cart
export const updateCartApi = (id, data) =>
  Api.put(`/api/cart/update/${id}`, data, config);

// delete cart
export const deleteCartApi = (id) =>
  Api.delete(`/api/cart/delete/${id}`, config);

// get orders/bills
export const getAllOrderApi = () => Api.get("/api/order/getAllOrders", config);

// create order
export const addOrderApi = (data) =>
  Api.post("/api/order/create", data, jsonConfig);

// update order
// export const updateOrderApi = (id, data) =>
//   Api.put(`/api/order/update/${id}`, data, config);

// update Status order
export const updateOrderStatusApi = (id, data) =>
  Api.put(`/api/order/update/${id}`, data, config);

// get user order
export const getUserOrderApi = () => Api.get("/api/order/getUserOrders", config);

// update carts status
export const updateCartStatusApi = (data) =>
  Api.put(`/api/cart/status`, data, config);


// http://localhost:8000/test