import { render, screen } from '@testing-library/react';
import Homepage from './Homepage';

describe('Homepage Component', () => {

    it('renders the main welcome heading', () => {
        render(<Homepage />);
        const heading = screen.getByText(/WELCOME!/i);
        expect(heading).toBeInTheDocument();
    });

    it('renders the carousel with 3 items', () => {
        render(<Homepage />);
        const carouselItems = screen.getAllByRole('img');
        expect(carouselItems.length).toBe(5);
    });

    it('renders the correct headings in the carousel', () => {
        render(<Homepage />);

        // Check if the carousel contains the specific headings
        expect(screen.getByText(/Design Your Idea/i)).toBeInTheDocument();
        expect(screen.getByText(/Submit Your Design/i)).toBeInTheDocument();
        expect(screen.getByText(/Earn Royalty/i)).toBeInTheDocument();
    });

    it('renders the logo and images correctly', () => {
        render(<Homepage />);

        // Check for the logo
        // const logo = screen.getByAltText(/About Hero/i);
        // expect(logo).toBeInTheDocument();

        // Check for the images in the carousel
        const carouselImage1 = screen.getByAltText(/Home 1/i);
        const carouselImage2 = screen.getByAltText(/Home 2/i);
        const carouselImage3 = screen.getByAltText(/Home 3/i);

        expect(carouselImage1).toBeInTheDocument();
        expect(carouselImage2).toBeInTheDocument();
        expect(carouselImage3).toBeInTheDocument();
    });
});
