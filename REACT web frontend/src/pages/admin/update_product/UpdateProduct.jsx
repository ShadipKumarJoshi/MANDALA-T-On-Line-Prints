import React, { useEffect, useState } from 'react'
import { useParams } from 'react-router-dom'
import { toast } from 'react-toastify'
import { getSingleProduct, updateProduct } from '../../../apis/api'


// // Define the isChecked function
// function isChecked(value, array) {
//     return array.includes(value);
// }

const UpdateProduct = () => {
    // get id from url
    const { id } = useParams()

    // get product information (Backend)
    useEffect(() => {
        getSingleProduct(id).then((res) => {
            console.log(res.data)

            // res has -> data (message, success, product) has -> (pn,pp,pc)
            // res.data.product.productCategory
            setProductCategory(res.data.products.productCategory)
            setProductPrice(res.data.products.productPrice)

            setProductDescription(res.data.products.productDescription)
            setOldImage(res.data.products.productImage)
            // setProductSize(res.data.products.productSize)

            // the Size are stored as a comma-separated string
            // console.log(res.data.products, "sasdfg")
            setProductSize(res.data.products.productSize)

            setProductColor(res.data.products.productColor)


            // ----- saved data is not shown when placed here,BUT when moved above it is shown?????????????????
            // setProductDescription(res.data.products.productDescription)
            // setOldImage(res.data.products.productImage)


        }).catch((error) => {
            console.log(error)
        })
    }, []) // box bracket is empty because we only want to run this once . it is dependecy 

    // fill all the info in each fields

    // make a use state
    const [productCategory, setProductCategory] = useState('T-shirt')
    const [productPrice, setProductPrice] = useState('')
    // const [productSize, setProductSize] = useState('')
    const [productSize, setProductSize] = useState([]);

    // const [productColor, setProductColor] = useState('')
    const [productColor, setProductColor] = useState([])

    const [productDescription, setProductDescription] = useState('')

    // state for image
    const [productNewImage, setProductNewImage] = useState(null)
    const [previewNewImage, setPreviewNewImage] = useState(null)
    const [oldImage, setOldImage] = useState('')

    // image upload handler
    const handleImage = (event) => {
        const file = event.target.files[0]
        setProductNewImage(file) // for backend
        setPreviewNewImage(URL.createObjectURL(file))
    }

    // Handle product size changes
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


    // console.log(productSize,"sasas")

    // update product
    const handleUpdate = (e) => {
        e.preventDefault()

        // make a form data
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
        // formData.append('productImage', productNewImage)  // new image

        if (productNewImage) {
            formData.append('productImage', productNewImage)
        }

        // Api call
        updateProduct(id, formData).then((res) => {

            // for SUCCESSFUL API
            if (res.status === 201) {
                toast.success(res.data.message)
                // Redirect to dashboard
                window.location.href = '/admin/dashboard';
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


    return (
        <>
            <div className='container mt-3' style={{ backgroundColor: 'white', padding: '20px', borderRadius: '5px', boxShadow: '0px 0px 10px rgba(0, 0, 0, 0.1)', width: '50%' }}>

                {/* <h2>Update product for <span className='text-danger'>'Flower'</span></h2> */}
                <h2 style={{ fontWeight: 'bold' }}>Update product for <span className='text-danger'>'{productCategory}'</span></h2>

                <div className='d-flex gap-5'>
                    <form action="">
                        <label style={{ fontWeight: 'bold' }} htmlFor="">Product Category</label>
                        {/* <input onChange={(e) => setProductCategory(e.target.value)} className='form-control' type="text" placeholder='Enter your product name' /> */}
                        {/* initial name is fillede by value */}

                        <select value={productCategory} onChange={(e) => setProductCategory(e.target.value)} className='form-control'>

                            <option value='T-shirt'>T-shirt</option>
                            <option value='Tanktop'>Tanktop</option>
                            <option value='Long Sleeve T-shirt'>Long Sleeve T-shirt</option>
                            <option value='Sweat Shirt'>Sweat Shirt</option>
                            <option value='Hoodie'>Hoodie</option>
                        </select>
                        <label className='mt-2' style={{ fontWeight: 'bold' }} htmlFor="">Product Price</label>
                        {/* <input onChange={(e) => setProductPrice(e.target.value)} className='form-control' type="number" placeholder='Enter your product name' /> */}
                        <input value={productPrice} onChange={(e) => setProductPrice(e.target.value)} className='form-control' type="number" placeholder='Enter your product price' />

                        {/* <label className='mt-2'>Choose Size</label>
                        <select value={productSize} onChange={(e) => setProductSize(e.target.value)} className='form-control'>
                            <option value='xs'>XS</option>
                            <option value='s'>S</option>
                            <option value='l'>L</option>
                            <option value='xl'>XL</option>
                            <option value='xxl'>XXL</option>
                        </select> */}

                        <label className='mt-2' style={{ fontWeight: 'bold' }}>Choose Size</label>
                        <div className='form-group'>
                            {['XS', 'S','M', 'L', 'XL', 'XXL'].map((size) => (

                                <div key={size} className='form-check'>
                                    <input
                                        type='checkbox'
                                        className='form-check-input'
                                        id={size}
                                        value={size}
                                        checked={productSize.includes(size)}
                                        onChange={handleSizeChange}
                                    />
                                    <label className='form-check-label' htmlFor={size}>
                                        {size}
                                    </label>
                                </div>
                            ))}
                        </div>


                        <label className='mt-2' style={{ fontWeight: 'bold' }} >Choose Product Color</label>
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
                                        checked={productColor.includes(color)}
                                        onChange={handleColorChange}
                                    />
                                    <label className='form-check-label' htmlFor={color}>
                                        <span style={{ backgroundColor: color, width: '20px', height: '20px', display: 'inline-block', marginRight: '5px', border: '1px solid black' }}></span>
                                        {color}
                                    </label>
                                </div>
                            ))}
                        </div>

                        <label className='mt-2' style={{ fontWeight: 'bold' }}>Enter Description</label>
                        <textarea value={productDescription} onChange={(e) => setProductDescription(e.target.value)} className='form-control'></textarea>

                        <label className='mt-2' style={{ fontWeight: 'bold' }}>Choose product Image</label>
                        <input onChange={handleImage} type="file" className='form-control' />

                        <button onClick={handleUpdate} className='btn btn-danger w-100 mt-2'>
                            <i className="fas fa-sync-alt" style={{ marginRight: '8px' }}></i>Update Product</button>


                    </form>
                    <div className='image section'>

                        <h6 style={{ fontWeight: 'bold' }}>Old Image Preview</h6>
                        {/* <img height={'200px'} width={'300'} className='image-fluid rounded-4 object-fit-cover' src="https://th.bing.com/th/id/OIP.-XyvM-HOa_XZrOEHCYdk6gAAAA?rs=1&pid=ImgDetMain" alt="" /> */}
                        <img height={'200px'} width={'300'} className='image-fluid rounded-4 object-fit-cover' src={`http://localhost:8000/products/${oldImage}`} alt="" />



                        {/* dynamic image preview for new image */}
                        {

                            previewNewImage && <>
                                <h6 style={{ fontWeight: 'bold' }}>New product Image</h6>
                                <img height={'200px'} width={'300px'} className='image-fluid rounded-4 object-fit-cover' src={previewNewImage} alt="" /> </>
                        }

                    </div>
                </div>

            </div>
        </>
    )
}

export default UpdateProduct