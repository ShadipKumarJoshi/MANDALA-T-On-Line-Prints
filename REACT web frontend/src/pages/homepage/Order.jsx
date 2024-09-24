import React, { useEffect, useState } from 'react';
import { toast } from 'react-toastify';
import { getAllOrderApi, getUserOrderApi, updateOrderStatusApi } from '../../apis/api';

const Order = () => {
  const [orders, setOrders] = useState([]);
  const [isAdmin, setIsAdmin] = useState(false);

  useEffect(() => {
    const user = JSON.parse(localStorage.getItem('user'));
    if (user && user.isAdmin === true) {
      setIsAdmin(true);
    } else {
      setIsAdmin(false);
    }

    const fetchOrders = async () => {
      try {
        const response = isAdmin ? await getAllOrderApi() : await getUserOrderApi();
        setOrders(response.data.orders);
      } catch (error) {
        toast.error("Failed to fetch orders");
      }
    };

    fetchOrders();
  }, [isAdmin]);

  const handleStatusChange = async (orderId, status) => {
    try {
      await updateOrderStatusApi(orderId, { status });
      setOrders(prevOrders => prevOrders.map(order => order._id === orderId ? { ...order, status } : order));
      toast.success("Order status updated successfully");
    } catch (error) {
      toast.error("Failed to update order status");
    }
  };

  return (
    <div className='container mt-3' style={{ backgroundColor: 'white', padding: '20px', borderRadius: '5px', boxShadow: '0px 0px 10px rgba(0, 0, 0, 0.1)' }}>
      <div className="text-align-left align-self-center">
        <h1 className="h1 text-success" style={{ textAlign: 'center', fontSize: '50px', WebkitTextStroke: '1px black', textShadow: '2px 2px 4px rgba(0, 0, 0, 1)' }}>
          <b>ORDER MANAGEMENT</b>
        </h1>
      </div>

      <table className="table mt-3">
        <thead className="table-dark">
          <tr>
            <th>Order ID</th>
            <th>Order Date</th>
            <th>Status</th>
            {isAdmin && <th>Actions</th>}
          </tr>
        </thead>
        <tbody>
          {orders.map((order) => (
            <tr key={order._id}>
              <td>{order._id}</td>
              <td>{new Date(order.createdAt).toLocaleDateString()}</td>
              <td>{order.status}</td>
              <td>
                {isAdmin && (
                  <div style={{ display: 'flex', flexDirection: 'column' }}>
                    <button
                      onClick={() => handleStatusChange(order._id, 'Pending')}
                      className='btn btn-warning btn-sm mb-2'
                    >
                      Mark as Pending
                    </button>
                    <button
                      onClick={() => handleStatusChange(order._id, 'Shipped')}
                      className='btn btn-info btn-sm mb-2'
                    >
                      Mark as Shipped
                    </button>
                    <button
                      onClick={() => handleStatusChange(order._id, 'Delivered')}
                      className='btn btn-success btn-sm'
                    >
                      Mark as Delivered
                    </button>
                  </div>
                )}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default Order;
