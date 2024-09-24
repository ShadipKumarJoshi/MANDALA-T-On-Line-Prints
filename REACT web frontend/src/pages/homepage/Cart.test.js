import React from 'react';
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import Cart from './Cart'; // Adjust the import path as needed
import { getAllCartApi, deleteCartApi, updateCartApi, addOrderApi, updateCartStatusApi } from '../../apis/api';
import { message } from 'antd';

jest.mock('../../apis/api');
jest.mock('antd', () => ({
    ...jest.requireActual('antd'),
    message: {
        success: jest.fn(),
        error: jest.fn(),
        info: jest.fn(),
    },
}));

const mockCartItems = [
    {
        _id: 'cartItemId1',
        productId: { productCategory: 'T-shirt' },
        productSize: 'M',
        productColor: 'Red',
        designId: { _id: 'designId1', designName: 'Cool Design', designImage: 'image1.png' },
        customizePrice: 100,
        quantity: 2,
        total: 200,
    },
];

describe('Cart Component', () => {
    beforeEach(() => {
        jest.clearAllMocks();
    });

    test('renders loading state initially', async () => {
        getAllCartApi.mockResolvedValueOnce({ data: { carts: [] } });
        render(<Cart />);
        expect(screen.getByText(/loading/i)).toBeInTheDocument();
        await waitFor(() => expect(screen.queryByText(/loading/i)).not.toBeInTheDocument());
    });

    test('renders empty cart message when no items in the cart', async () => {
        getAllCartApi.mockResolvedValueOnce({ data: { carts: [] } });
        render(<Cart />);
        await waitFor(() => expect(screen.getByText(/your cart is empty/i)).toBeInTheDocument());
    });

    test('renders cart items when available', async () => {
        getAllCartApi.mockResolvedValueOnce({ data: { carts: mockCartItems } });
        render(<Cart />);
        await waitFor(() => {
            expect(screen.getByText(/Cool Design/i)).toBeInTheDocument();
            expect(screen.getByText(/Category: T-shirt/i)).toBeInTheDocument();
            expect(screen.getByText(/Size: M/i)).toBeInTheDocument();
            expect(screen.getByText(/Color: Red/i)).toBeInTheDocument();
            expect(screen.getByText(/Rs. 100/i)).toBeInTheDocument();
            expect(screen.getByDisplayValue('2')).toBeInTheDocument();
        });
    });

    test('updates item quantity', async () => {
        getAllCartApi.mockResolvedValueOnce({ data: { carts: mockCartItems } });
        updateCartApi.mockResolvedValueOnce({});
        render(<Cart />);
        await waitFor(() => {
            expect(screen.getByText(/Cool Design/i)).toBeInTheDocument();
        });

        const quantityInput = screen.getByDisplayValue('2');
        fireEvent.change(quantityInput, { target: { value: '3' } });
        expect(updateCartApi).toHaveBeenCalledWith('cartItemId1', { quantity: 3, total: 300 });
        await waitFor(() => expect(message.success).toHaveBeenCalledWith('Cart updated successfully'));
    });

    test('deletes a cart item', async () => {
        getAllCartApi.mockResolvedValueOnce({ data: { carts: mockCartItems } });
        deleteCartApi.mockResolvedValueOnce({});
        render(<Cart />);
        await waitFor(() => {
            expect(screen.getByText(/Cool Design/i)).toBeInTheDocument();
        });

        const deleteButton = screen.getByRole('button', { name: /delete/i });
        fireEvent.click(deleteButton);
        expect(deleteCartApi).toHaveBeenCalledWith('cartItemId1');
        await waitFor(() => expect(message.success).toHaveBeenCalledWith('Item deleted successfully'));
    });

    test('handles successful Khalti payment', async () => {
        getAllCartApi.mockResolvedValueOnce({ data: { carts: mockCartItems } });
        updateCartStatusApi.mockResolvedValueOnce({});
        addOrderApi.mockResolvedValueOnce({});
        render(<Cart />);

        await waitFor(() => {
            expect(screen.getByText(/Cool Design/i)).toBeInTheDocument();
        });

        const addressInput = screen.getByPlaceholderText(/enter your address/i);
        fireEvent.change(addressInput, { target: { value: '123 Street' } });

        const khaltiRadio = screen.getByLabelText(/khalti/i);
        fireEvent.click(khaltiRadio);

        const placeOrderButton = screen.getByRole('button', { name: /place order/i });
        fireEvent.click(placeOrderButton);

        // Simulate Khalti payment success
        await waitFor(() => expect(message.success).toHaveBeenCalledWith('Payment successful'));
    });
});
