import React from "react";
import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import "@testing-library/jest-dom/extend-expect";
import Favourites from "./Favourites";
import * as api from "../../apis/api";
import { message } from "antd";

jest.mock("../../apis/api");
jest.mock("antd", () => {
  const antd = jest.requireActual("antd");
  return {
    ...antd,
    message: {
      success: jest.fn(),
      error: jest.fn(),
    },
  };
});

describe("Favourites Component", () => {
  const mockFavourites = [
    {
      _id: "fav1",
      designId: {
        _id: "design1",
        designName: "Design 1",
        designPrice: 100,
        designImage: "design1.png",
        designDescription: "Description of Design 1",
      },
    },
    {
      _id: "fav2",
      designId: {
        _id: "design2",
        designName: "Design 2",
        designPrice: 200,
        designImage: "design2.png",
        designDescription: "Description of Design 2",
      },
    },
  ];

  beforeEach(() => {
    api.getFavoriteByUserApi.mockResolvedValue({ data: { favorites: mockFavourites } });
  });

  it("renders the Favourites component", async () => {
    render(<Favourites />);

    expect(screen.getByText(/Favourites/i)).toBeInTheDocument();
    await waitFor(() => expect(screen.getByText("Design 1")).toBeInTheDocument());
  });

  it("shows loading skeleton while fetching data", async () => {
    render(<Favourites />);

    expect(screen.getAllByText(/loading/i).length).toBeGreaterThan(0); // Check that loading skeletons are rendered
    await waitFor(() => expect(screen.getByText("Design 1")).toBeInTheDocument()); // Wait for data to load
  });

  it("displays favourite items", async () => {
    render(<Favourites />);

    await waitFor(() => expect(screen.getByText("Design 1")).toBeInTheDocument());
    expect(screen.getByText("Description of Design 1")).toBeInTheDocument();
    expect(screen.getByText("Rs. 100")).toBeInTheDocument();
  });

  it("displays empty favourites message when no items", async () => {
    api.getFavoriteByUserApi.mockResolvedValueOnce({ data: { favorites: [] } });

    render(<Favourites />);

    await waitFor(() => expect(screen.getByText(/Your favourites list is empty/i)).toBeInTheDocument());
  });

  it("removes a favourite item", async () => {
    render(<Favourites />);

    await waitFor(() => expect(screen.getByText("Design 1")).toBeInTheDocument());

    fireEvent.click(screen.getByRole("button", { name: /remove/i }));

    await waitFor(() => {
      expect(api.deleteFromFavoriteApi).toHaveBeenCalledWith("design1");
      expect(message.success).toHaveBeenCalledWith("Item removed from favourites");
    });
  });

  afterEach(() => {
    jest.clearAllMocks();
  });
});
