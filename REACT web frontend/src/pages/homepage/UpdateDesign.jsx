import React, { useEffect, useState } from 'react'
import { useParams } from 'react-router-dom'
import { toast } from 'react-toastify'
import { getSingleDesign, updateDesign } from '../../apis/api'

const UpdateDesign = () => {
    // get id from url
    const { id } = useParams()

    // get Design information (Backend)
    useEffect(() => {
        getSingleDesign(id).then((res) => {
            console.log(res.data)

            // res has -> data (message, success, design) has -> (pn,pp,pc)
            // res.data.design.designName
            setDesignName(res.data.designs.designName)
            setDesignPrice(res.data.designs.designPrice)
            setDesignCategory(res.data.designs.designCategory)
            setDesignDescription(res.data.designs.designDescription)
            setOldImage(res.data.designs.designImage)


        }).catch((error) => {
            console.log(error)
        })
    }, []) // box bracket is empty because we only want to run this once . it is dependecy 

    // fill all the info in each fields

    // make a use state
    const [designName, setDesignName] = useState('')
    const [designPrice, setDesignPrice] = useState('')
    const [designCategory, setDesignCategory] = useState('plants')
    const [designDescription, setDesignDescription] = useState('')

    // state for image
    const [designNewImage, setDesignNewImage] = useState(null)
    const [previewNewImage, setPreviewNewImage] = useState(null)
    const [oldImage, setOldImage] = useState('')

    // image upload handler
    const handleImage = (event) => {
        const file = event.target.files[0]
        setDesignNewImage(file) // for backend
        setPreviewNewImage(URL.createObjectURL(file))
    }

    // update Design
    const handleUpdate = (e) => {
        e.preventDefault()

        // make a form data
        // make a from-data (txt, file)
        const formData = new FormData()
        formData.append('designName', designName)
        formData.append('designPrice', designPrice)
        formData.append('designCategory', designCategory)
        formData.append('designDescription', designDescription)
        // formData.append('designImage', designNewImage)  // new image

        if (designNewImage) {
            formData.append('designImage', designNewImage)
        }

        // Api call
        updateDesign(id, formData).then((res) => {
            if (res.status === 201) {
                toast.success(res.data.message)
                window.location.href = '/sell-design';
            }

        }).catch((error) => {
            if (error.response.status === 500) {
                toast.error(error.response.data.message)                
            }
        })
    }


    return (
        <>
            <div className='container mt-3' style={{ backgroundColor: 'white', padding: '20px', borderRadius: '5px', boxShadow: '0px 0px 10px rgba(0, 0, 0, 0.1)', width: '50%' }}>

                {/* <h2>Update design for <span className='text-danger'>'Flower'</span></h2> */}
                <h2 style={{ fontWeight: 'bold' }}>Update design for <span className='text-danger'>'{designName}'</span></h2>

                <div className='d-flex gap-3'>
                    <form action="">
                        <label style={{ fontWeight: 'bold' }} htmlFor="" >Design Name</label>
                        {/* <input onChange={(e) => setDesignName(e.target.value)} className='form-control' type="text" placeholder='Enter your Design name' /> */}
                        {/* initial name is fillede by value */}
                        <input value={designName} onChange={(e) => setDesignName(e.target.value)} className='form-control' type="text" placeholder='Enter your Design name' />

                        <label className='mt-2' style={{ fontWeight: 'bold' }} htmlFor="">Design Price</label>
                        {/* <input onChange={(e) => setDesignPrice(e.target.value)} className='form-control' type="number" placeholder='Enter your Design name' /> */}
                        <input value={designPrice} onChange={(e) => setDesignPrice(e.target.value)} className='form-control' type="number" placeholder='Enter your Design name' />

                        <label className='mt-2' style={{ fontWeight: 'bold' }}>Choose category</label>
                        <select value={designCategory} onChange={(e) => setDesignCategory(e.target.value)} className='form-control'>
                            <option value="plants">Plants</option>
                            <option value="electronics">Electronics</option>
                            <option value="gadgets">Gadgets</option>
                            <option value="furniture">Furniture</option>
                        </select>

                        <label className='mt-2' style={{ fontWeight: 'bold' }}>Enter description</label>
                        <textarea value={designDescription} onChange={(e) => setDesignDescription(e.target.value)} className='form-control'></textarea>

                        <label className='mt-2' style={{ fontWeight: 'bold' }}>Choose Design Image</label>
                        <input onChange={handleImage} type="file" className='form-control' />

                        <button onClick={handleUpdate} className='btn btn-danger w-100 mt-2'>Update Design</button>


                    </form>
                    <div className='image section'>

                        <h6 style={{ fontWeight: 'bold' }}>Old Image Preview</h6>
                        {/* <img height={'200px'} width={'300'} className='image-fluid rounded-4 object-fit-cover' src="https://th.bing.com/th/id/OIP.-XyvM-HOa_XZrOEHCYdk6gAAAA?rs=1&pid=ImgDetMain" alt="" /> */}
                        <img height={'200px'} width={'300'} className='image-fluid rounded-4 object-fit-cover' src={`http://localhost:8000/Designs/${oldImage}`} alt="" />



                        {/* dynamic image preview for new image */}
                        {

                            previewNewImage && <>
                                <h6 style={{ fontWeight: 'bold' }}>New Design Image</h6>
                                <img height={'200px'} width={'300px'} className='image-fluid rounded-4 object-fit-cover' src={previewNewImage} alt="" /> </>
                        }

                    </div>
                </div>

            </div>
        </>
    )
}

export default UpdateDesign