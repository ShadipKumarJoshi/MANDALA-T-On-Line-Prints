import React from 'react';
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import '@testing-library/jest-dom/extend-expect';
import Order from './Order';
import { getAllOrderApi, getUserOrderApi, updateOrderStatusApi } from '../../apis/api';
import { toast } from 'react-toastify';

jest.mock('../../apis/api');
jest.mock('react-toastify', () => ({
  toast: {
    success: jest.fn(),
    error: jest.fn(),
  },
}));

describe('Order Component', () => {
  const mockOrders = [
    {
      _id: 'order1',
      userId: { fullName: 'John Doe' },
      createdAt: '2024-08-01T00:00:00Z',
      carts: { total: 100 },
      status: 'Pending',
    },
    {
      _id: 'order2',
      userId: { fullName: 'Jane Smith' },
      createdAt: '2024-08-02T00:00:00Z',
      carts: { total: 200 },
      status: 'Shipped',
    },
  ];

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('renders the Order component and fetches orders for admin', async () => {
    localStorage.setItem('user', JSON.stringify({ role: 'admin' }));
    getAllOrderApi.mockResolvedValue({ data: { orders: mockOrders } });

    render(<Order />);

    expect(screen.getByText(/ORDER MANAGEMENT/i)).toBeInTheDocument();
    await waitFor(() => {
      expect(screen.getByText('John Doe')).toBeInTheDocument();
      expect(screen.getByText('Nrs. 100')).toBeInTheDocument();
      expect(screen.getByText('Mark as Shipped')).toBeInTheDocument();
    });
  });

  it('renders the Order component and fetches orders for regular user', async () => {
    localStorage.setItem('user', JSON.stringify({ role: 'user' }));
    getUserOrderApi.mockResolvedValue({ data: { orders: mockOrders } });

    render(<Order />);

    expect(screen.getByText(/ORDER MANAGEMENT/i)).toBeInTheDocument();
    await waitFor(() => {
      expect(screen.getByText('John Doe')).toBeInTheDocument();
      expect(screen.getByText('Nrs. 100')).toBeInTheDocument();
      expect(screen.queryByText('Mark as Shipped')).not.toBeInTheDocument(); // Admin only
    });
  });

  it('updates the order status and shows success message', async () => {
    localStorage.setItem('user', JSON.stringify({ role: 'admin' }));
    getAllOrderApi.mockResolvedValue({ data: { orders: mockOrders } });
    updateOrderStatusApi.mockResolvedValue({});

    render(<Order />);

    await waitFor(() => expect(screen.getByText('Mark as Shipped')).toBeInTheDocument());

    fireEvent.click(screen.getByText('Mark as Shipped'));

    await waitFor(() => {
      expect(updateOrderStatusApi).toHaveBeenCalledWith('order1', { status: 'Shipped' });
      expect(toast.success).toHaveBeenCalledWith('Order status updated successfully');
    });
  });

  it('handles errors when fetching orders', async () => {
    localStorage.setItem('user', JSON.stringify({ role: 'admin' }));
    getAllOrderApi.mockRejectedValue(new Error('Failed to fetch orders'));

    render(<Order />);

    await waitFor(() => {
      expect(toast.error).toHaveBeenCalledWith('Failed to fetch orders');
    });
  });

  it('handles errors when updating order status', async () => {
    localStorage.setItem('user', JSON.stringify({ role: 'admin' }));
    getAllOrderApi.mockResolvedValue({ data: { orders: mockOrders } });
    updateOrderStatusApi.mockRejectedValue(new Error('Failed to update order status'));

    render(<Order />);

    await waitFor(() => expect(screen.getByText('Mark as Shipped')).toBeInTheDocument());

    fireEvent.click(screen.getByText('Mark as Shipped'));

    await waitFor(() => {
      expect(toast.error).toHaveBeenCalledWith('Failed to update order status');
    });
  });
});
