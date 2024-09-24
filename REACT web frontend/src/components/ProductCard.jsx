import React from "react";

const ProductCard = ({ productInformation, color, handleClick }) => {
  const colorBoxStyle = {
    display: "inline-block",
    width: "20px",
    height: "20px",
    marginRight: "5px",
    border: "1px solid #000", // Optional: adds a border to each color box
  };

  return (
    <>
      <div class="card" style={{ width: "20rem", height: "40rem" }}>
        <img
          src={`http://localhost:8000/products/${productInformation.productImage}`}
          class="card-img-top"
          alt="..."
          style={{ height: "20rem" }}
        />
        <div class="card-body">
          <div class="d-flex justify-content-between">
            <h5 style={{ fontWeight: "bold" }} class="card-title">
              {productInformation.productCategory}
            </h5>
            <h5 class="card-title text-danger">
              NPR. {productInformation.productPrice}
            </h5>
          </div>
          <p class="card-text" style={{ fontWeight: "bold", color: "green" }}>
            {productInformation.productSize}
          </p>

          <p class="card-text" style={{ fontWeight: "bold" }}>
            Colors: {productInformation.productColor}
          </p>

          {/* <div>
                        {productInformation.productColor.map((color, index) => (
                            <span
                                key={index}
                                style={{ ...colorBoxStyle, backgroundColor: color.toLowerCase() }}
                                title={color}
                            ></span>
                        ))}
                    </div> */}

          <p class="card-text">
            {productInformation.productDescription.slice(0, 70)}
          </p>
          <button
            class="btn btn-outline-dark w-100"
            onClick={() => handleClick()}
          >
            Choose
          </button>
        </div>
      </div>
    </>
  );
};

export default ProductCard;
