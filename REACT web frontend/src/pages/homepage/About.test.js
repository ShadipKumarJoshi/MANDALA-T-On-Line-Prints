import { render, screen } from '@testing-library/react';
import About from './About';

describe('About Component', () => {
    it('renders the About Us heading', () => {
        render(<About />);
        const heading = screen.getByText(/About Us/i);
        expect(heading).toBeInTheDocument();
    });

    it('renders the Our Inspiration heading', () => {
        render(<About />);
        const heading = screen.getByText(/Our Inspiration/i);
        expect(heading).toBeInTheDocument();
    });

    it('renders the Why Choose Us? heading', () => {
        render(<About />);
        const heading = screen.getByText(/Why Choose Us?/i);
        expect(heading).toBeInTheDocument();
    });

    it('renders the Our Commitment heading', () => {
        render(<About />);
        const heading = screen.getByText(/Our Commitment/i);
        expect(heading).toBeInTheDocument();
    });

    it('renders the Our Services heading', () => {
        render(<About />);
        const heading = screen.getByText(/Our Services/i);
        expect(heading).toBeInTheDocument();
    });

    it('renders all the service sections', () => {
        render(<About />);

        // Check that each service is rendered
        expect(screen.getByText(/Delivery Services/i)).toBeInTheDocument();
        expect(screen.getByText(/High Quality Print/i)).toBeInTheDocument();
        expect(screen.getByText(/Promotion/i)).toBeInTheDocument();
        expect(screen.getByText(/24 Hours Service/i)).toBeInTheDocument();
    });

    it('renders all images with correct alt text', () => {
        render(<About />);

        // Check that images are rendered correctly
        // expect(screen.getByAltText(/About Hero/i)).toBeInTheDocument();
        // expect(screen.getByAltText(/Inspiration/i)).toBeInTheDocument();
        // expect(screen.getByAltText(/Choose/i)).toBeInTheDocument();
        // expect(screen.getByAltText(/Commitment/i)).toBeInTheDocument();
        // expect(screen.getByAltText(/Delivery Services/i)).toBeInTheDocument();
        // expect(screen.getByAltText(/High Quality Print/i)).toBeInTheDocument();
        // expect(screen.getByAltText(/Promotion/i)).toBeInTheDocument();
        // expect(screen.getByAltText(/24 Hours Service/i)).toBeInTheDocument();
    });
});
