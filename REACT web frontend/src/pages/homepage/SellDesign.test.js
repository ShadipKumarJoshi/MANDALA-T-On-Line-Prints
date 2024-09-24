import React from 'react';
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import '@testing-library/jest-dom/extend-expect';
import SellDesign from './SellDesign';
import { getUserDesigns, createDesignApi, deleteDesign } from '../../apis/api';
import { toast } from 'react-toastify';

jest.mock('../../apis/api');
jest.mock('react-toastify', () => ({
  toast: {
    success: jest.fn(),
    error: jest.fn(),
    warning: jest.fn(),
  },
}));

// Mock window.location.reload
const mockReload = jest.fn();
global.window = Object.create(window);
Object.defineProperty(window, 'location', {
  value: { reload: mockReload },
  writable: true,
});

describe('SellDesign Component', () => {
  const mockDesigns = [
    {
      _id: 'design1',
      designName: 'Design 1',
      designPrice: '100',
      designCategory: 'plants',
      designDescription: 'Description 1',
      designImage: 'image1.jpg',
    },
    {
      _id: 'design2',
      designName: 'Design 2',
      designPrice: '200',
      designCategory: 'electronics',
      designDescription: 'Description 2',
      designImage: 'image2.jpg',
    },
  ];

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('renders the SellDesign component and fetches designs', async () => {
    getUserDesigns.mockResolvedValue({ data: { designs: mockDesigns } });

    render(<SellDesign />);

    expect(screen.getByText(/SELL DESIGN/i)).toBeInTheDocument();
    await waitFor(() => {
      expect(screen.getByText('Design 1')).toBeInTheDocument();
      expect(screen.getByText('100')).toBeInTheDocument();
    });
  });

  it('handles form submission and shows success message', async () => {
    getUserDesigns.mockResolvedValue({ data: { designs: mockDesigns } });
    createDesignApi.mockResolvedValue({ status: 201, data: { message: 'Design added successfully' } });

    render(<SellDesign />);

    fireEvent.change(screen.getByPlaceholderText('Enter design name'), { target: { value: 'New Design' } });
    fireEvent.change(screen.getByPlaceholderText('Enter design price'), { target: { value: '300' } });
    fireEvent.change(screen.getByRole('combobox'), { target: { value: 'furniture' } });
    fireEvent.change(screen.getByRole('textbox'), { target: { value: 'New Description' } });

    // Simulate file input
    const file = new File(['dummy content'], 'design.jpg', { type: 'image/jpeg' });
    fireEvent.change(screen.getByLabelText('Design Image'), { target: { files: [file] } });

    fireEvent.click(screen.getByText('Save'));

    await waitFor(() => {
      expect(createDesignApi).toHaveBeenCalled();
      expect(toast.success).toHaveBeenCalledWith('Design added successfully');
      expect(mockReload).toHaveBeenCalled();
    });
  });

  it('handles design deletion and shows success message', async () => {
    getUserDesigns.mockResolvedValue({ data: { designs: mockDesigns } });
    deleteDesign.mockResolvedValue({ status: 201, data: { message: 'Design deleted successfully' } });

    render(<SellDesign />);

    await waitFor(() => expect(screen.getByText('Design 1')).toBeInTheDocument());

    fireEvent.click(screen.getByText('Delete', { selector: 'button' }));

    await waitFor(() => {
      expect(deleteDesign).toHaveBeenCalledWith('design1');
      expect(toast.success).toHaveBeenCalledWith('Design deleted successfully');
      expect(mockReload).toHaveBeenCalled();
    });
  });

  it('handles errors in form submission', async () => {
    getUserDesigns.mockResolvedValue({ data: { designs: mockDesigns } });
    createDesignApi.mockRejectedValue({ response: { status: 400, data: { message: 'Failed to add design' } } });

    render(<SellDesign />);

    fireEvent.click(screen.getByText('Save'));

    await waitFor(() => {
      expect(createDesignApi).toHaveBeenCalled();
      expect(toast.warning).toHaveBeenCalledWith('Failed to add design');
    });
  });

  it('handles errors in design deletion', async () => {
    getUserDesigns.mockResolvedValue({ data: { designs: mockDesigns } });
    deleteDesign.mockRejectedValue({ response: { status: 500, data: { message: 'Failed to delete design' } } });

    render(<SellDesign />);

    fireEvent.click(screen.getByText('Delete', { selector: 'button' }));

    await waitFor(() => {
      expect(deleteDesign).toHaveBeenCalledWith('design1');
      expect(toast.error).toHaveBeenCalledWith('Failed to delete design');
    });
  });
});
