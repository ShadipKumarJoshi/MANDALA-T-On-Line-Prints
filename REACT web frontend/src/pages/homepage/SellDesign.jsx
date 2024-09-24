import React, { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { toast } from 'react-toastify'
import { createDesignApi, deleteDesign, getUserDesigns } from '../../apis/api'

// 1. UI 
const SellDesign = () => {

  // X.1. Use state for all fetched designs from backend
  const [designs, setDesigns] = useState([]) // array[]

  // X.2. Call API initially (Page load) - Set all fetch designs to state (X.1.)
  useEffect(() => {

    getUserDesigns().then((res) => {

      // response : res.data.designs (All Designs)
      setDesigns(res.data.designs)


    }).catch((error) => {
      console.log(error)

    })
  }, []) // [] is dependencies of useEffect ie . useEffect works only when [] is supplied, mpty dependency array ensures useEffect runs only on initial load
  console.log(designs)


  //  2. use State define
  const [designName, setDesignName] = useState('')
  const [designPrice, setDesignPrice] = useState('')
  const [designCategory, setDesigncategory] = useState('plants')
  const [designDescription, setProducDescription] = useState('')
  // 2.1. useState for image
  const [designImage, setDesignImage] = useState('')
  const [previewImage, setPreviewImage] = useState('')

  // 3. image upload handler // can use e/event below
  const handleImage = (event) => { // can use e also instead of event
    const file = event.target.files[0]
    setDesignImage(file) //for backend
    setPreviewImage(URL.createObjectURL(file)) // for temporary preview


  }

  // handle submit
  const handleSubmit = (e) => {
    e.preventDefault()
    // console.log(
    //   designName,
    //   designPrice,
    //   designCategory,
    //   designDescription,
    //   designImage
    // )

    // make a from-data (txt, file)
    const formData = new FormData()
    formData.append('designName', designName)
    formData.append('designPrice', designPrice)
    formData.append('designCategory', designCategory)
    formData.append('designDescription', designDescription)
    formData.append('designImage', designImage)

    // Make a api call
    createDesignApi(formData).then((res) => {
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
        console.log(error)
        toast.error("Something went wrong!")
      }

    });

  };

  // handle delete design



  const handleDelete = (id) => {
    const confirmDialog = window.confirm("Are you sure you want to delete?");
    if (confirmDialog) {
      // calling API
      deleteDesign(id).then((res) => {
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
      <div className='container'>
        <div className="text-align-left align-self-center">
          <h1 className="h1 text-success" style={{ textAlign: 'center', fontSize: '50px', WebkitTextStroke: '1px black', textShadow: '2px 2px 4px rgba(0, 0, 0, 1)' }}>
            <b>SELL DESIGN</b>
          </h1> </div>
        <div >
          <img src="./assets/images/sell.jpg" alt="About Hero" style={{ display: 'block', margin: '20px auto', maxWidth: '100%', height: 'auto' }}></img>

        </div>
        <div className='d-flex justify-content-between'>
          <h3 style={{ fontWeight: 'bold' }}>Sell Design</h3>
          {/* <button className='btn btn-danger'>Add design</button> */}

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
            Add Design
          </button>

          {/* <!-- Modal --> */}
          <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <h1 class="modal-title fs-5" id="exampleModalLabel" style={{ fontWeight: 'bold' }}>Add a new design</h1>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  {/* ... */}
                  {/* Form for design */}
                  <form action="">
                    <label className='mt-2' style={{ fontWeight: 'bold' }}>Design Name</label>
                    <input onChange={(e) => setDesignName(e.target.value)} type='text' className='form-control' placeholder='Enter design name'></input>

                    <label className='mt-2' style={{ fontWeight: 'bold' }}>Design Price</label>
                    <input onChange={(e) => setDesignPrice(e.target.value)} type='number' className='form-control' placeholder='Enter design price'></input>

                    <label className='mt-2' style={{ fontWeight: 'bold' }}>Choose Design Category</label>
                    <select onChange={(e) => setDesigncategory(e.target.value)} className='form-control'>
                      <option value='plants'>Plants</option>
                      <option value='electronics'>Electronics</option>
                      <option value='toys'>Toys</option>
                      <option value='food'>Food</option>
                      <option value='furniture'>Furniture</option>
                    </select>


                    <label className='mt-2' style={{ fontWeight: 'bold' }}>Design Description</label>
                    <textarea onChange={(e) => setProducDescription(e.target.value)} className='form-control' ></textarea>

                    <label className='mt-2' style={{ fontWeight: 'bold' }}>Design Image</label>
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
              <th>Design Image</th>
              <th>Design Name</th>
              <th>Design Price</th>
              <th>Design Category</th>
              <th>Design Description</th>
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
              designs.map((singleDesign) => (
                <tr>
                  <td><img width={'100px'} height={'100px'} src={`http://localhost:8000/designs/${singleDesign.designImage}`} alt="" /></td>
                  <td>{singleDesign.designName}</td>
                  <td>{singleDesign.designPrice}</td>
                  <td>{singleDesign.designCategory}</td>
                  <td>{singleDesign.designDescription}</td>
                  <td>
                    {/* <button className='btn btn-primary'>Edit</button> */}

                    {/* LINK BUTTON TO RESPECTIVE EDIT DESIGN */}
                    {/* <Link to={`/update-design/${singleDesign._id}`} className='btn btn-primary'>Edit</Link>
                    {/* <button className='btn btn-danger ms-2' >Delete</button> */}
                    {/* <button onClick={() => handleDelete(singleDesign._id)} className='btn btn-danger ms-2' >Delete</button> */}

                    <div style={{ display: 'flex', flexDirection: 'column' }}>
                      <Link to={`/update-design/${singleDesign._id}`} className='btn btn-primary mb-2'>
                        <i className="fas fa-edit" style={{ marginRight: '8px' }}></i>
                        Edit
                      </Link>
                      <button
                        onClick={() => handleDelete(singleDesign._id)}
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

export default SellDesign


// EDIT DESIGN -------------------------------------------------
//  design is in  Dashboard (Table)
// Fill all the related information of the chose design only.
// It must be editable( both text , file)
// make a backend to update design.

