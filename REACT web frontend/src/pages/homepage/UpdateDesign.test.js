import React from 'react';
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import '@testing-library/jest-dom/extend-expect';
import { MemoryRouter, Route, Routes } from 'react-router-dom';
import UpdateDesign from './UpdateDesign';
import { getSingleDesign, updateDesign } from '../../apis/api';
import { toast } from 'react-toastify';

// Mock API functions
jest.mock('../../apis/api');
jest.mock('react-toastify', () => ({
  toast: {
    success: jest.fn(),
    error: jest.fn(),
    warning: jest.fn(),
  },
}));

// Mock window.location.href
const mockLocationHref = jest.fn();
delete window.location;
window.location = { href: mockLocationHref };

describe('UpdateDesign Component', () => {
  const mockDesign = {
    _id: 'design1',
    designName: 'Design 1',
    designPrice: '100',
    designCategory: 'plants',
    designDescription: 'Description 1',
    designImage: 'image1.jpg',
  };

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('loads and displays design information', async () => {
    getSingleDesign.mockResolvedValue({ data: { designs: mockDesign } });

    render(
      <MemoryRouter initialEntries={['/update-design/design1']}>
        <Routes>
          <Route path="/update-design/:id" element={<UpdateDesign />} />
        </Routes>
      </MemoryRouter>
    );

    expect(screen.getByText(/Update design for/i)).toBeInTheDocument();
    expect(await screen.findByDisplayValue('Design 1')).toBeInTheDocument();
    expect(await screen.findByDisplayValue('100')).toBeInTheDocument();
    expect(screen.getByDisplayValue('plants')).toBeInTheDocument();
    expect(screen.getByDisplayValue('Description 1')).toBeInTheDocument();
  });

  it('handles form submission with image upload', async () => {
    getSingleDesign.mockResolvedValue({ data: { designs: mockDesign } });
    updateDesign.mockResolvedValue({ status: 201, data: { message: 'Design updated successfully' } });

    render(
      <MemoryRouter initialEntries={['/update-design/design1']}>
        <Routes>
          <Route path="/update-design/:id" element={<UpdateDesign />} />
        </Routes>
      </MemoryRouter>
    );

    // Update form values
    fireEvent.change(screen.getByPlaceholderText('Enter your Design name'), { target: { value: 'Updated Design' } });
    fireEvent.change(screen.getByPlaceholderText('Enter your Design price'), { target: { value: '150' } });
    fireEvent.change(screen.getByRole('combobox'), { target: { value: 'electronics' } });
    fireEvent.change(screen.getByRole('textbox'), { target: { value: 'Updated Description' } });

    // Simulate file input
    const file = new File(['dummy content'], 'new-image.jpg', { type: 'image/jpeg' });
    fireEvent.change(screen.getByLabelText('Choose Design Image'), { target: { files: [file] } });

    fireEvent.click(screen.getByText('Update Design'));

    await waitFor(() => {
      expect(updateDesign).toHaveBeenCalledWith('design1', expect.any(FormData));
      expect(toast.success).toHaveBeenCalledWith('Design updated successfully');
      expect(mockLocationHref).toHaveBeenCalledWith('/sell-design');
    });
  });

  it('handles form submission without new image', async () => {
    getSingleDesign.mockResolvedValue({ data: { designs: mockDesign } });
    updateDesign.mockResolvedValue({ status: 201, data: { message: 'Design updated successfully' } });

    render(
      <MemoryRouter initialEntries={['/update-design/design1']}>
        <Routes>
          <Route path="/update-design/:id" element={<UpdateDesign />} />
        </Routes>
      </MemoryRouter>
    );

    fireEvent.change(screen.getByPlaceholderText('Enter your Design name'), { target: { value: 'Updated Design' } });
    fireEvent.change(screen.getByPlaceholderText('Enter your Design price'), { target: { value: '150' } });
    fireEvent.change(screen.getByRole('combobox'), { target: { value: 'electronics' } });
    fireEvent.change(screen.getByRole('textbox'), { target: { value: 'Updated Description' } });

    fireEvent.click(screen.getByText('Update Design'));

    await waitFor(() => {
      expect(updateDesign).toHaveBeenCalledWith('design1', expect.any(FormData));
      expect(toast.success).toHaveBeenCalledWith('Design updated successfully');
      expect(mockLocationHref).toHaveBeenCalledWith('/sell-design');
    });
  });

  it('handles errors during update', async () => {
    getSingleDesign.mockResolvedValue({ data: { designs: mockDesign } });
    updateDesign.mockRejectedValue({ response: { status: 500, data: { message: 'Failed to update design' } } });

    render(
      <MemoryRouter initialEntries={['/update-design/design1']}>
        <Routes>
          <Route path="/update-design/:id" element={<UpdateDesign />} />
        </Routes>
      </MemoryRouter>
    );

    fireEvent.click(screen.getByText('Update Design'));

    await waitFor(() => {
      expect(updateDesign).toHaveBeenCalledWith('design1', expect.any(FormData));
      expect(toast.error).toHaveBeenCalledWith('Failed to update design');
    });
  });
});
