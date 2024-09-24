import React from 'react'
import { Outlet, Navigate } from 'react-router-dom'


const AdminRoutes = () => {
    // get user information
    const user = JSON.parse(localStorage.getItem('user'))

    // check user exists
    // check isAdmin = true
    // if true : Access all the route of Admin ( It is called Outlet)
    // if false : Navigate to Login

    return user != null && user.isAdmin ? <Outlet /> : <Navigate to={'/sell-design'} />




}

export default AdminRoutes
