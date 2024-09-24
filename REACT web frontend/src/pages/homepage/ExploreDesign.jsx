import React, { useEffect, useState } from "react";
import { getAllDesigns, searchDesigns } from "../../apis/api";
import DesignCard from "../../components/DesignCard";
import {  AppstoreOutlined,  BarsOutlined,   SearchOutlined,} from "@ant-design/icons";
import { Radio,  Select, Input} from "antd";

const { Search } = Input;
const { Option } = Select;

const ExploreDesign = () => {
  // Use state for all fetched designs from backend
  const [designs, setDesigns] = useState([]); // array[]

  const [favorites, setFavorites] = useState([]);
  // const [favoriteChange, setFavoriteChange] = useState(false);
  const [filteredDesigns, setFilteredDesigns] = useState([]);
  const [page, setPage] = useState(1);
  const [totalItems, setTotalItems] = useState(0);
  const [searchQuery, setSearchQuery] = useState("");
  const [viewMode, setViewMode] = useState("grid");
  const [sortBy, setSortBy] = useState("name_asc");


  // Call API initially (Page load) - Set all fetched designs to state
  useEffect(() => {
    getAllDesigns()
      .then((res) => {
        // response: res.data.designs (All designs)
        setDesigns(res.data.designs);
      })
      .catch((error) => {
        console.log(error);
      });
  }, []);
  // [] is dependencies of useEffect i.e., useEffect works only when [] is supplied

  // pagination
  const [currentPage, setCurrentPage] = useState(1);
  const designsPerPage = 12;
  const indexOfLastDesign = currentPage * designsPerPage;
  const indexOfFirstDesign = indexOfLastDesign - designsPerPage;
  const currentDesigns = designs.slice(indexOfFirstDesign, indexOfLastDesign);

  // Change page
  const paginate = (pageNumber) => {
    setCurrentPage(pageNumber);
    window.scrollTo(0, 0); // Scroll to top
  };



  // Previous page
  const handlePrevPage = () => {
    if (currentPage > 1) {
      setCurrentPage(currentPage - 1);
      window.scrollTo(0, 0); // Scroll to top
    }
  };

  // Next page
  const handleNextPage = () => {
    if (currentPage < pageNumbers.length) {
      setCurrentPage(currentPage + 1);
      window.scrollTo(0, 0); // Scroll to top
    }
  };

  const pageNumbers = [];
  for (let i = 1; i <= Math.ceil(designs.length / designsPerPage); i++) {
    pageNumbers.push(i);
  }


  const handleSearch = (value) => {
    setSearchQuery(value);
    applySearchAndSort(designs, value, sortBy);
  };

  const handleSort = (value) => {
    setSortBy(value);
    applySearchAndSort(designs, searchQuery, value);
  };

  const applySearchAndSort = (products, search, sort) => {
    let filtered = products.filter((design) =>
      design.productName?.toLowerCase().includes(search.toLowerCase())
    );

    const [field, order] = sort.split("_");
    filtered.sort((a, b) => {
      if (field === "name") {
        return order === "asc"
          ? a.productName.localeCompare(b.productName)
          : b.productName.localeCompare(a.productName);
      } else if (field === "price") {
        return order === "asc"
          ? a.productPrice - b.productPrice
          : b.productPrice - a.productPrice;
      }
      return 0;
    });

    setFilteredDesigns(filtered);
  };



  return (
    <div className="background">
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
            <b>EXPLORE DESIGN</b>
          </h1>
        </div>
        <div>
          <img
            src="./assets/images/explore.png"
            alt="About Hero"
            style={{
              display: "block",
              margin: "20px auto",
              maxWidth: "100%",
              height: "auto",
            }}
          />
        </div>

        <div className="search-container">
          <Search
            placeholder="Search for designs"
            allowClear
            enterButton={<SearchOutlined />}
            size="large"
            onSearch={handleSearch}
            onChange={(e) => handleSearch(e.target.value)}
          />
        </div>

        <div className="controls-container">
          <div className="view-controls">
            <Radio.Group
              value={viewMode}
              onChange={(e) => setViewMode(e.target.value)}
            >
              <Radio.Button value="grid">
                <AppstoreOutlined />
              </Radio.Button>
              <Radio.Button value="list">
                <BarsOutlined />
              </Radio.Button>
            </Radio.Group>
          </div>
          <Select
            className="sort-control"
            defaultValue="name_asc"
            onChange={handleSort}
          >
            <Option value="name_asc">Sort by Name (A-Z)</Option>
            <Option value="name_desc">Sort by Name (Z-A)</Option>
            <Option value="price_asc">Sort by Price (Low to High)</Option>
            <Option value="price_desc">Sort by Price (High to Low)</Option>
          </Select>

        <h2 className="mt-2" style={{ fontWeight: 'bold' }}>Available Designs</h2>
        <div className="row row-cols-1 row-cols-md-4 g-4">
          {currentDesigns.map((singleDesign) => (
            <div className="col" key={singleDesign.id}>
              <DesignCard designInformation={singleDesign} color={"red"} />
              {/* // sending design information */}
            </div>
          ))}
        </div>
        <nav>
          <ul className="pagination justify-content-center mt-4">
            <li className={`page-item ${currentPage === 1 ? 'disabled' : ''}`}>
              <button onClick={handlePrevPage} className="page-link">
                &laquo;
              </button>
            </li>
            {pageNumbers.map(number => (
              <li key={number} className={`page-item ${currentPage === number ? 'active' : ''}`}>
                <button onClick={() => paginate(number)} className="page-link">
                  {number}
                </button>
              </li>
            ))}
            <li className={`page-item ${currentPage === pageNumbers.length ? 'disabled' : ''}`}>
              <button onClick={handleNextPage} className="page-link">
                &raquo;
              </button>
            </li>
          </ul>
        </nav>
      </div>
    </div>
  </div>
  );
};

export default ExploreDesign;
