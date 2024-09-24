import React, { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { toast } from 'react-toastify'
import { createProductApi, deleteProduct, getAllProducts } from '../../../apis/api'

// 1. UI 
const AdminDashboard = () => {

  // X.1. Use state for all fetched products from backend
  const [products, setProducts] = useState([]) // array[]

  // X.2. Call API initially (Page load) - Set all fetch products to state (X.1.)
  useEffect(() => {

    getAllProducts().then((res) => {

      // response : res.data.products (All Products)
      setProducts(res.data.products)


    }).catch((error) => {
      console.log(error)

    })
  }, []) // [] is dependencies of useEffect ie . useEffect works only when [] is supplied
  console.log(products)


  //  2. use State define
  const [productCategory, setProductCategory] = useState('T-shirt')
  const [productPrice, setProductPrice] = useState('')
  // const [productSize, setProductSize] = useState('')

  //  state management for multiple checkboxes
  const [productSize, setProductSize] = useState([]); // array of selected Size

  // const [productColor, setProductColor] = useState('')
  const [productColor, setProductColor] = useState([]);

  const [productDescription, setProducDescription] = useState('')
  // 2.1. useState for image
  const [productImage, setProductImage] = useState('')
  const [previewImage, setPreviewImage] = useState('')

  // 3. image upload handler // can use e/event below
  const handleImage = (event) => { // can use e also instead of event
    const file = event.target.files[0]
    setProductImage(file) //for backend
    setPreviewImage(URL.createObjectURL(file)) // for temporary preview


  }


  // handle  product Size change in array 
  const handleSizeChange = (e) => {
    const { value, checked } = e.target;
    if (checked) {
      setProductSize((prev) => [...prev, value]);
    } else {
      setProductSize((prev) => prev.filter((size) => size !== value));
    }
  };

  // handle product Color change in array 
  const handleColorChange = (e) => {
    const { value, checked } = e.target;
    if (checked) {
      setProductColor((prev) => [...prev, value]);
    } else {
      setProductColor((prev) => prev.filter((color) => color !== value));
    }
  };

  // handle submit
  const handleSubmit = (e) => {
    e.preventDefault()
    // console.log(
    //   productCategory,
    //   productPrice,
    //   productSize,
    //   productDescription,
    //   productImage
    // )

    // make a from-data (txt, file)
    const formData = new FormData()
    formData.append('productCategory', productCategory)
    formData.append('productPrice', productPrice)
    // formData.append('productSize', productSize)

    // Convert array to comma-separated string
    formData.append('productSize', productSize.join(','));

    // formData.append('productColor', productColor)
    formData.append('productColor', productColor.join(','));
    formData.append('productDescription', productDescription)
    formData.append('productImage', productImage)

    // Make a api call
    createProductApi(formData).then((res) => {
      // if(res.data.success ===false){
      //   toast.error(res.data.message)
      // } else {
      //   toast.success(res.data.message)
      // }

      // For SUCCESSFUL API
      if (res.status === 201) {
        toast.success(res.data.message);
        window.location.reload();
      }

    }).catch((error) => {
      // For ERROR status code
      if (error.response) {
        if (error.response.status === 400) {
          toast.warning(error.response.data.message)
        } else if (error.response.status === 500) {
          toast.error(error.response.data.message)
        } else {
          toast.error("Something went wrong!")
        }

      } else {
        toast.error("Something went wrong!")
      }

    });

  };



  // handle delete product

  const handleDelete = (id) => {
    const confirmDialog = window.confirm("Are you sure you want to delete?");
    if (confirmDialog) {
      // calling API
      deleteProduct(id).then((res) => {
        if (res.status === 201) {
          toast.success(res.data.message);

          // reload
          window.location.reload();
        }

      }).catch((error) => {
        if (error.response.status === 500) {
          toast.error(error.response.data.message);
        }

      });

    }

  };

  return (
    <>
      <div className='container mt-3'>
        <div className='d-flex justify-content-between' >
          <h3 style={{ fontWeight: 'bold' }}>Admin Dashboard</h3>
          {/* <button className='btn btn-danger'>Add product</button> */}

          {/* modal from getbootstrap instead of button above*/}
          {/* <!-- Button trigger modal --> */}
          <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#exampleModal" style={{
            width: '100px',
            height: '100px',
            borderRadius: '50%',
            padding: 0,
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            boxShadow: '0px 4px 6px rgba(5, 5, 5, 5)',
            backgroundColor: 'green',
            fontWeight: 'bold'
          }}>
            Add Product
          </button>

          {/* <!-- Modal --> */}
          <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <h1 class="modal-title fs-5" id="exampleModalLabel" style={{ fontWeight: 'bold' }}>Add a new product</h1>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  {/* ... */}
                  {/* Form for product */}
                  <form action="">
                    <label className='mt-2' style={{ fontWeight: 'bold' }}>Choose category</label>
                    <select value={productCategory} onChange={(e) => setProductCategory(e.target.value)} className='form-control' >

                      <option value='T-shirt' >T-shirt</option>
                      <option value='Tanktop' >Tanktop</option>
                      <option value='Long Sleeve T-shirt'>Long Sleeve T-shirt</option>
                      <option value='Sweat Shirt'>Sweat Shirt</option>
                      <option value='Hoodie'>Hoodie</option>
                    </select>
                    <label className='mt-2' style={{ fontWeight: 'bold' }}>Product Price</label>
                    <input onChange={(e) => setProductPrice(e.target.value)} type='number' className='form-control' placeholder='Enter product price'></input>

                    {/* <label className='mt-2' >Choose Product Size</label>
                    <select onChange={(e) => setProductSize(e.target.value)} className='form-control'>
                      <option value='choose'>--- Choose Size ---</option>
                      <option value='xs'>XS</option>
                      <option value='s'>S</option>
                      <option value='l'>L</option>
                      <option value='xl'>XL</option>
                      <option value='xxl'>XXL</option>
                    </select> */}

                    <label className='mt-2' style={{ fontWeight: 'bold' }}>Choose Product Size</label>
                    <div className='form-group'>
                      {['XS', 'S', 'M','L', 'XL', 'XXL'].map((size) => (
                        <div key={size} className='form-check'>
                          <input
                            type='checkbox'
                            className='form-check-input'
                            id={size}
                            value={size}
                            onChange={handleSizeChange}
                          />
                          <label className='form-check-label' htmlFor={size}>
                            {size}
                          </label>
                        </div>
                      ))}
                    </div>


                    <label className='mt-2' style={{ fontWeight: 'bold' }}>Choose Product Color</label>
                    {/* <select onChange={(e) => setProductColor(e.target.value)} className='form-control'>
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
                    </select> */}

                    <div className='form-group'>
                      {['Black', 'White', 'Grey', 'Blue', 'Red', 'Green', 'Yellow', 'Purple', 'Pink'].map((color) => (
                        <div key={color} className='form-check'>
                          <input
                            type='checkbox'
                            className='form-check-input'
                            id={color}
                            value={color}
                            onChange={handleColorChange}
                          />
                          <label className='form-check-label' htmlFor={color}>
                            <span style={{ backgroundColor: color, width: '20px', height: '20px', display: 'inline-block', marginRight: '5px', border: '1px solid black' }}></span>
                            {color}
                          </label>
                        </div>
                      ))}
                    </div>



                    <label className='mt-2' style={{ fontWeight: 'bold' }}>Product Description</label>
                    <textarea onChange={(e) => setProducDescription(e.target.value)} className='form-control' ></textarea>

                    <label className='mt-2' style={{ fontWeight: 'bold' }}>Product Image</label>
                    <input onChange={handleImage} type='file' className='form-control' ></input>

                    {/* Image Preview for dynamic preview */}
                    {
                      previewImage && <img src={previewImage} alt="preview image" className='img-fluid rounded mt-2' /> // img-fluid fits the image
                    }


                  </form>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                  <button onClick={handleSubmit} type="button" class="btn btn-primary">Save  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
        <table className="table mt-2">
          <thead className="table-dark">
            <tr>
              <th>Product Image</th>
              <th>Product Category</th>
              <th>Product Price</th>
              <th>Product Size</th>
              <th>Product Color</th>
              <th>Product Description</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {/* <tr>
              <td><img width={'40px'} height={'40px'} src="https://th.bing.com/th/id/OIP.B0FHX_50PYZIN4QKsKykdAHaHa?w=172&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7" alt="" /></td>
              <td>Ninja Cat</td>
              <td>200</td>
              <td>Indoor</td>
              <td>Lorem Ipsum</td>
              <td>
                <button className='btn btn-primary'>Edit</button>
                <button className='btn btn-danger ms-2' >Delete</button>
              </td>
            </tr> */}

            {
              products.map((singleProduct) => (
                <tr>
                  <td><img width={'100px'} height={'100px'} src={`http://localhost:8000/products/${singleProduct.productImage}`} alt="" /></td>
                  <td>{singleProduct.productCategory}</td>
                  <td>{singleProduct.productPrice}</td>
                  <td>{singleProduct.productSize}</td>
                  <td>{singleProduct.productColor}</td>
                  <td>{singleProduct.productDescription}</td>
                  <td>
                    {/* <button className='btn btn-primary'>Edit</button> */}
                    {/* 
                    LINK BUTTON TO RESPECTIVE EDIT PRODUCT
                    <Link to={`/admin/update/${singleProduct._id}`} className='btn btn-primary'>Edit</Link>
                    <button className='btn btn-danger ms-2' >Delete</button>
                    <button onClick={() => handleDelete(singleProduct._id)} className='btn btn-danger ms-2' >Delete</button>
                  </td>
                  <td> */}
                    <div style={{ display: 'flex', flexDirection: 'column' }}>
                      <Link to={`/admin/update/${singleProduct._id}`} className='btn btn-primary mb-2'>
                        <i className="fas fa-edit" style={{ marginRight: '8px' }}></i>
                        Edit
                      </Link>
                      <button
                        onClick={() => handleDelete(singleProduct._id)}
                        className='btn btn-danger'
                      >
                        <i className="fas fa-trash-alt" style={{ marginRight: '8px' }}></i>
                        Delete
                      </button>
                    </div>
                  </td>
                </tr>
              ))
            }


          </tbody>
        </table>
      </div>
    </>
  )
}

export default AdminDashboard


// EDIT PRODUCT -------------------------------------------------
//  product is in Admin Dashboard (Table)
// Make a new route (Admin Edit Product)
// Fill all the related information of the chose product only.
// It must be editable( both text , file)
// make a backend to update product.

