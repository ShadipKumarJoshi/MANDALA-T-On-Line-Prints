import React from "react";
import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import "@testing-library/jest-dom/extend-expect";
import CustomiseDesigns from "./CustomiseDesigns";
import * as api from "../../apis/api"; // Import the API module
import { ToastContainer } from "react-toastify";

jest.mock("../../apis/api"); // Mock the API module

describe("CustomiseDesigns Component", () => {
  const mockProducts = [
    {
      _id: "product1",
      productName: "Product 1",
      productPrice: 1000,
      productCategory: "Category 1",
      productSize: ["S", "M", "L"],
      productColor: ["Red", "Blue"],
      productDescription: "Description for Product 1",
      productImage: "product1.png",
    },
    {
      _id: "product2",
      productName: "Product 2",
      productPrice: 1500,
      productCategory: "Category 2",
      productSize: ["S", "M"],
      productColor: ["Black", "White"],
      productDescription: "Description for Product 2",
      productImage: "product2.png",
    },
  ];

  const mockDesigns = [
    {
      _id: "design1",
      designName: "Design 1",
      designPrice: 500,
      designImage: "design1.png",
    },
    {
      _id: "design2",
      designName: "Design 2",
      designPrice: 700,
      designImage: "design2.png",
    },
  ];

  beforeEach(() => {
    api.getAllProducts.mockResolvedValue({ data: { products: mockProducts } });
    api.getAllDesigns.mockResolvedValue({ data: { designs: mockDesigns } });
  });

  it("renders the component correctly", async () => {
    render(
      <>
        <ToastContainer />
        <CustomiseDesigns />
      </>
    );

    // Check if the header is rendered
    expect(screen.getByText(/CUSTOMISE DESIGN/i)).toBeInTheDocument();

    // Wait for the products to load
    await waitFor(() =>
      expect(screen.getByText("Product 1")).toBeInTheDocument()
    );
  });

  it("allows selecting a product", async () => {
    render(
      <>
        <ToastContainer />
        <CustomiseDesigns />
      </>
    );

    await waitFor(() =>
      expect(screen.getByText("Product 1")).toBeInTheDocument()
    );

    // Click on the second product
    fireEvent.click(screen.getByText("Product 2"));

    // Check if the selected product's details are shown
    expect(screen.getByText(/Description for Product 2/i)).toBeInTheDocument();
  });

  it("allows selecting a design", async () => {
    render(
      <>
        <ToastContainer />
        <CustomiseDesigns />
      </>
    );

    await waitFor(() =>
      expect(screen.getByText("Product 1")).toBeInTheDocument()
    );

    // Select a design from the dropdown
    fireEvent.change(screen.getByLabelText("Design:"), {
      target: { value: "Design 2" },
    });

    // Check if the selected design's details are shown
    expect(screen.getByText(/Design 2/i)).toBeInTheDocument();
  });

  it("handles adding to cart", async () => {
    const mockAddToCartApi = jest.spyOn(api, "addToCartApi").mockResolvedValue({
      data: { message: "Item added to cart successfully!" },
    });

    render(
      <>
        <ToastContainer />
        <CustomiseDesigns />
      </>
    );

    await waitFor(() =>
      expect(screen.getByText("Product 1")).toBeInTheDocument()
    );

    fireEvent.change(screen.getByLabelText("Design:"), {
      target: { value: "Design 1" },
    });

    fireEvent.click(screen.getByText(/Add to Cart/i));

    // Wait for the toast notification
    await waitFor(() =>
      expect(screen.getByText("Item added to cart successfully!")).toBeInTheDocument()
    );

    expect(mockAddToCartApi).toHaveBeenCalled();
  });

  afterEach(() => {
    jest.clearAllMocks();
  });
});
