import React, { useEffect, useState } from "react";
import axios from "axios";
import { getAllDesigns, getAllProducts, addToCartApi } from "../../apis/api";
import ProductCard from "../../components/ProductCard";
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

const CustomiseDesigns = () => {
  const [products, setProducts] = useState([]);
  const [selectedProduct, setSelectedProduct] = useState(null);
  const [design, setDesign] = useState([]);
  const [selectedDesign, setSelectedDesign] = useState(null);
  const [chooseProductSize, setChooseProductSize] = useState('');
  const [chooseProductColor, setChooseProductColor] = useState('');

  useEffect(() => {
    getAllProducts()
      .then((res) => {
        setProducts(res.data.products);
        setSelectedProduct(res.data.products[0]);
      })
      .catch((error) => {
        console.log(error);
      });
    getAllDesigns()
      .then((res) => {
        setDesign(res.data.designs);
      })
      .catch((error) => {
        console.log(error);
      });
  }, []);

  const handleProductSelect = (product) => {
    setSelectedProduct(product);
  };

  const handleChange = (event) => {
    const selectedDesignName = event.target.value;
    setSelectedDesign(selectedDesignName);
    const designData = design.find(d => d.designName === selectedDesignName);
    setSelectedDesign(designData);
  };

  const handleAddToCart = () => {
    const cartItem = {
      productId: selectedProduct._id,
      designId: selectedDesign._id,
      productSize: chooseProductSize,
      productColor: chooseProductColor,
      customizePrice: selectedProduct.productPrice + selectedDesign.designPrice,
      quantity: 1,
      total: selectedProduct.productPrice + selectedDesign.designPrice,
    };

    addToCartApi(cartItem)
      .then((res) => {
        toast.success("Item added to cart successfully!");
        console.log("Item added to cart:", res.data);
      })
      .catch((error) => {
        toast.error("Error adding item to cart!");
        console.log("Error adding item to cart:", error);
      });
  };

  return (
    <div className="background">
      <ToastContainer />
      <div className="container">
        <div className="text-align-left align-self-center">
          <h1
            className="h1 text-success"
            style={{
              textAlign: "center",
              fontSize: "50px",
              WebkitTextStroke: "1px black",
              textShadow: "2px 2px 4px rgba(0, 0, 0, 1)",
            }}
          >
            <b>CUSTOMISE DESIGN</b>
          </h1>
        </div>
        <div>
          <img
            src="./assets/images/explore1.png"
            alt="About Hero"
            style={{
              display: "block",
              margin: "20px auto",
              maxWidth: "100%",
              height: "auto",
            }}
          ></img>
        </div>

        <h2 className="mt-2" style={{ fontWeight: "bold" }}>
          Available Products
        </h2>

        <div className="row row-cols-1 row-cols-md-4 g-4">
          {products.map((singleProduct) => (
            <div className="col" key={singleProduct._id}>
              <ProductCard
                productInformation={singleProduct}
                color={"red"}
                handleClick={() => handleProductSelect(singleProduct)}
              />
            </div>
          ))}
        </div>

        <div
          style={{
            display: "flex",
            justifyContent: "space-between",
            backgroundColor: "#fff",
            padding: "20px",
            borderRadius: "8px",
          }}
        >
          {selectedProduct && (
            <div
              className="container mt-5"
              style={{
                display: "flex",
                justifyContent: "space-between",
              }}
            >
              <div
                style={{
                  flex: "1",
                  position: "relative",
                }}
              >
                {/* "ace" container */}
                <div
                  style={{
                    position: "absolute",
                    backgroundColor: chooseProductColor,
                    width: "100%",
                    height: "100%",
                    borderRadius: "8px",
                    zIndex: "0",
                  }}
                />
                <img
                  src={`http://localhost:8000/products/${selectedProduct.productImage}`}
                  alt={selectedProduct.productName}
                  style={{
                    maxWidth: "100%",
                    height: "auto",
                    borderRadius: "8px",
                    position: "relative",
                    zIndex: "1",
                  }}
                />
                {selectedDesign?.designImage && (
                  <img
                    src={`http://localhost:8000/designs/${selectedDesign.designImage}`}
                    alt={selectedProduct.productName}
                    style={{
                      width: "200px",
                      height: "200px",
                      borderRadius: "8px",
                      position: "absolute",
                      zIndex: "10",
                      top: "45%",
                      left: "34%",
                    }}
                  />
                )}
              </div>

              <div style={{ flex: "1", marginLeft: "20px" }}>
                <h3>{selectedProduct.productName}</h3>
                <p>
                  <strong>Category:</strong> {selectedProduct.productCategory}
                </p>
                <p>
                  <strong>Price:</strong> Nrs. {selectedProduct.productPrice}
                </p>
                <p>
                  <strong>Sizes:</strong> {selectedProduct.productSize.join(", ")}
                </p>
                <p>
                  <strong>Choose Size:</strong>
                  <select onChange={(e) => setChooseProductSize(e.target.value)} className='form-control'>
                    <option value='choose'>--- Choose Size ---</option>
                    <option value='xs'>XS</option>
                    <option value='s'>S</option>
                    <option value='m'>M</option>
                    <option value='l'>L</option>
                    <option value='xl'>XL</option>
                    <option value='xxl'>XXL</option>
                  </select>
                </p>
                <p>
                  <strong>Colors:</strong> {selectedProduct.productColor.join(", ")}
                </p>
                <p>
                  <strong>Choose Color:</strong>
                  <select onChange={(e) => setChooseProductColor(e.target.value)} className='form-control'>
                    <option value='choose'>--- Choose Color ---</option>
                    <option value='black'>Black</option>
                    <option value='white'>White</option>
                    <option value='grey'>Grey</option>
                    <option value='blue'>Blue</option>
                    <option value='red'>Red</option>
                    <option value='green'>Green</option>
                    <option value='yellow'>Yellow</option>
                    <option value='purple'>Purple</option>
                    <option value='pink'>Pink</option>
                  </select>
                </p>
                <p>
                  <strong>Description:</strong><br /> {selectedProduct.productDescription}
                </p>
                <strong> Design:</strong>
                <select id="nameSelect" value={selectedDesign?.designName || ''} onChange={handleChange}>
                  <option value="" disabled>Select a design</option>
                  {design.map((item, index) => (
                    <option key={index} value={item.designName}>{item.designName}</option>
                  ))}
                </select>

                {selectedDesign && (
                  <div style={{ width: "200px", margin: "20px 0px" }}>
                    <p><strong>Design Name:</strong> {selectedDesign.designName}</p>
                    <p><strong>Design ID:</strong> {selectedDesign._id}</p>
                    <p><strong>Design Price:</strong> {selectedDesign.designPrice}</p>
                  </div>
                )}

                {selectedProduct && selectedDesign && (
                  <div>
                    <p><strong>Total Price:</strong> {selectedProduct.productPrice + selectedDesign.designPrice}</p>
                  </div>
                )}

                <div>
                  <button className="btn btn-success" onClick={handleAddToCart}>Add to Cart</button>
                </div>
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default CustomiseDesigns;
