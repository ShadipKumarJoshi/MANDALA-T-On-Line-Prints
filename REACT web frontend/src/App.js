import { Route, BrowserRouter as Router, Routes } from "react-router-dom";
import './App.css';
import Footer from "./components/Footer";
import Navbar from "./components/Navbar";
import AdminDashboard from "./pages/admin/admin_dashboard/AdminDashboard";
import UpdateProduct from "./pages/admin/update_product/UpdateProduct";
import Homepage from "./pages/homepage/Homepage";
import Login from "./pages/login/Login";
import Register from "./pages/register/Register";

// import Sidebar from "./components/Sidebar";

// Toast config
import { ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import ForgotPassword from "./pages/forgotPassword/ForgotPassword";
import ForgotPasswordByEmail from "./pages/forgotPassword/ForgotPasswordByEmail";
import About from "./pages/homepage/About";
import Cart from "./pages/homepage/Cart";
import CustomiseDesigns from "./pages/homepage/CustomiseDesigns";
import ExploreDesign from "./pages/homepage/ExploreDesign";
import Favourites from "./pages/homepage/Favourites";
import Home from "./pages/homepage/Homepage";
import Review from "./pages/homepage/Review";
import SellDesign from "./pages/homepage/SellDesign";
import SellDesignAndCustomiseDesigns from "./pages/homepage/SellDesignAndCustomiseDesigns";
import UpdateDesign from "./pages/homepage/UpdateDesign";
import Delete from "./pages/profile/Delete";
import Profile from "./pages/profile/Profile";
import Settings from "./pages/profile/Settings";
import AdminRoutes from "./protected_routes/AdminRoutes";
import UserRoutes from "./protected_routes/UserRoutes";
import Orders from "./pages/homepage/Order";


function App() {

  return (

    <Router>
      <Navbar />
      <ToastContainer
        position="top-right"

      />
      {/* <Sidebar/> */}

      <Routes>
        {/* Initial Route */}
        <Route path="/" element={<Homepage />} />
        <Route path='/home' element={<Home />} />
        <Route path='/about' element={<About />} />
        <Route path='/home-design-customise' element={<SellDesignAndCustomiseDesigns />} />
        <Route path='/sell-design' element={<SellDesign />} />
        <Route path='/update-design/:id' element={<UpdateDesign />} />
        <Route path="/review" element={<Review />} />


        <Route path="/favourites" element={<Favourites />} />
        <Route path="/cart" element={<Cart />} />
        <Route path="/order" element={<Orders />} />
        

        <Route path='/explore-designs' element={<ExploreDesign />} />
        <Route path='/customise-designs' element={<CustomiseDesigns />} />
        <Route path='/register' element={<Register />} />
        <Route path='/login' element={<Login />} />
        <Route path='/forgot-password' element={<ForgotPassword />} />
        <Route path='/forgot-password-email' element={<ForgotPasswordByEmail />} />
        <Route path='/delete-account' element={<Delete />} />
        {/* Admin Routes without AdminGuard */}
        {/* <Route path='/admin/dashboard' element={<AdminDashboard />} />
        <Route path='/admin/update/:id' element={<UpdateProduct />} /> */}

        {/* Admin Routes with AdminGuard */}
        <Route element={<AdminRoutes />}>
          <Route path='/admin/dashboard' element={<AdminDashboard />} />
          <Route path='/admin/update/:id' element={<UpdateProduct />} />
        </Route>

        {/* User Routes */}
        <Route element={<UserRoutes />}>
          <Route path='/profile' element={<Profile />} />
          <Route path='/settings' element={<Settings />} />
        </Route>


      </Routes>
      <Footer />

    </Router>

  );

}

export default App;