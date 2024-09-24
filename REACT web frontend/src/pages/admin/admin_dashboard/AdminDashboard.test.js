import React from 'react';
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import '@testing-library/jest-dom';
import AdminDashboard from './AdminDashboard';
import { createProductApi, deleteProduct, getAllProducts } from '../../../apis/api';

// Mock API calls
jest.mock('../../../apis/api', () => ({
  createProductApi: jest.fn(),
  deleteProduct: jest.fn(),
  getAllProducts: jest.fn(),
}));

describe('AdminDashboard', () => {
  beforeEach(() => {
    // Reset mocks before each test
    jest.resetAllMocks();
  });

  test('renders AdminDashboard and fetches products', async () => {
    // Mock data for API
    const mockProducts = [
      {
        _id: '1',
        productImage: 'test-image.jpg',
        productCategory: 'T-shirt',
        productPrice: '100',
        productSize: 'M',
        productColor: 'Red',
        productDescription: 'A cool T-shirt',
      },
    ];

    getAllProducts.mockResolvedValue({ data: { products: mockProducts } });

    render(<AdminDashboard />);

    // Check if table header is present
    expect(screen.getByText('Product Category')).toBeInTheDocument();

    // Wait for table data to be displayed
    await waitFor(() => {
      expect(screen.getByText('T-shirt')).toBeInTheDocument();
      expect(screen.getByText('100')).toBeInTheDocument();
    });
  });

  test('opens and closes the modal', () => {
    // render(<AdminDashboard />);

    // Open modal
    fireEvent.click(screen.getByText('Add Product'));

    // Check modal content
    expect(screen.getByText('Add a new product')).toBeInTheDocument();

    // Close modal
    fireEvent.click(screen.getByText('Close'));
    expect(screen.queryByText('Add a new product')).not.toBeInTheDocument();
  });

  test('submits the form with valid data', async () => {
    // render(<AdminDashboard />);

    // Mock form submission
    createProductApi.mockResolvedValue({ status: 201, data: { message: 'Product added successfully' } });

    fireEvent.click(screen.getByText('Add Product'));

    fireEvent.change(screen.getByLabelText('Choose category'), { target: { value: 'Hoodie' } });
    fireEvent.change(screen.getByLabelText('Product Price'), { target: { value: '150' } });
    fireEvent.change(screen.getByLabelText('Product Description'), { target: { value: 'A warm hoodie' } });

    // Mock image file input
    const file = new File(['(⌐□_□)'], 'example.png', { type: 'image/png' });
    fireEvent.change(screen.getByLabelText('Product Image'), { target: { files: [file] } });

    fireEvent.click(screen.getByText('Save'));

    // Verify API call was made
    await waitFor(() => {
      expect(createProductApi).toHaveBeenCalled();
    });

    expect(screen.getByText('Product added successfully')).toBeInTheDocument();
  });

  test('deletes a product', async () => {
    const mockProducts = [
      {
        _id: '1',
        productImage: 'test-image.jpg',
        productCategory: 'T-shirt',
        productPrice: '100',
        productSize: 'M',
        productColor: 'Red',
        productDescription: 'A cool T-shirt',
      },
    ];

    getAllProducts.mockResolvedValue({ data: { products: mockProducts } });
    deleteProduct.mockResolvedValue({ status: 201, data: { message: 'Product deleted successfully' } });

    render(<AdminDashboard />);

    await waitFor(() => {
      expect(screen.getByText('T-shirt')).toBeInTheDocument();
    });

    // fireEvent.click(screen.getByText('Delete'));

    // Confirm dialog
    window.confirm = jest.fn(() => true);

    await waitFor(() => {
      expect(deleteProduct).toHaveBeenCalledWith('1');
      expect(screen.getByText('Product deleted successfully')).toBeInTheDocument();
    });
  });
});
