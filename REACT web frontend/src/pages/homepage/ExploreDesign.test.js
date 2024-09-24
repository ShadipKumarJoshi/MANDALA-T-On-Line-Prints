import React from "react";
import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import "@testing-library/jest-dom/extend-expect";
import ExploreDesign from "./ExploreDesign";
import * as api from "../../apis/api";

jest.mock("../../apis/api");

describe("ExploreDesign Component", () => {
  const mockDesigns = [
    {
      id: "design1",
      productName: "Design 1",
      productPrice: 100,
      productImage: "design1.png",
    },
    {
      id: "design2",
      productName: "Design 2",
      productPrice: 200,
      productImage: "design2.png",
    },
    {
      id: "design3",
      productName: "Design 3",
      productPrice: 150,
      productImage: "design3.png",
    },
    // Add more mock designs if necessary
  ];

  beforeEach(() => {
    api.getAllDesigns.mockResolvedValue({ data: { designs: mockDesigns } });
  });

  it("renders the ExploreDesign component", async () => {
    render(<ExploreDesign />);

    expect(screen.getByText(/EXPLORE DESIGN/i)).toBeInTheDocument();
    await waitFor(() => expect(screen.getByText("Design 1")).toBeInTheDocument());
  });

  it("handles search functionality", async () => {
    render(<ExploreDesign />);

    await waitFor(() => expect(screen.getByText("Design 1")).toBeInTheDocument());

    // Perform a search
    fireEvent.change(screen.getByPlaceholderText("Search for designs"), {
      target: { value: "Design 2" },
    });
    fireEvent.click(screen.getByRole("button", { name: /search/i }));

    expect(screen.queryByText("Design 1")).not.toBeInTheDocument();
    expect(screen.getByText("Design 2")).toBeInTheDocument();
  });

  it("handles sort functionality", async () => {
    render(<ExploreDesign />);

    await waitFor(() => expect(screen.getByText("Design 1")).toBeInTheDocument());

    // Sort by Price (High to Low)
    fireEvent.change(screen.getByRole("combobox"), {
      target: { value: "price_desc" },
    });

    const designs = screen.getAllByText(/Design/i);
    expect(designs[0]).toHaveTextContent("Design 2"); // Most expensive design should be first
    expect(designs[designs.length - 1]).toHaveTextContent("Design 1"); // Cheapest design should be last
  });

  it("handles pagination functionality", async () => {
    render(<ExploreDesign />);

    await waitFor(() => expect(screen.getByText("Design 1")).toBeInTheDocument());

    // Assuming there are more designs than fit on one page
    fireEvent.click(screen.getByText("2")); // Go to the second page

    expect(window.scrollTo).toHaveBeenCalledWith(0, 0);
    // Add checks to verify correct designs are shown for the second page
  });

  it("toggles between grid and list view", async () => {
    render(<ExploreDesign />);

    await waitFor(() => expect(screen.getByText("Design 1")).toBeInTheDocument());

    // Switch to list view
    fireEvent.click(screen.getByRole("button", { name: /bars/i }));

    // Assert the layout change
    // This may involve checking classes or styles that change between grid and list view
  });

  afterEach(() => {
    jest.clearAllMocks();
  });
});
