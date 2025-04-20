import { TiEyeOutline } from "react-icons/ti";
import { CiEdit } from "react-icons/ci";
import { MdOutlineDeleteOutline } from "react-icons/md";
import { NavLink } from "react-router-dom";
import axios from "axios";
import { useCallback, useEffect, useState } from "react";
import { toast } from "react-toastify";

export const Table = () => {
  const [formData, setFormData] = useState([]);
  const role = localStorage.getItem("role");

  const getProduct = useCallback(async () => {
    try {
      const { data } = await axios.get(
        `${process.env.REACT_APP_BASE_URL}/api/get_product_list_with_bid`
      );
      const filteredProducts = data.filter(
        (product) => role !== "admin" || product.user !== 7
      );
      setFormData(filteredProducts);
    } catch (error) {
      toast.error(error.response.data.message);
    }
  },[role]);
  useEffect(() => {
    getProduct();
  },[getProduct]);

  const handleDeleteProduct = async (e, product_id) => {
    e.preventDefault();
    if (window.confirm("Do you want to delete this product?")) {
      try {
        const { data, status } = await axios.delete(
          `${process.env.REACT_APP_BASE_URL}/api/products/${product_id}`
        );
        if (status === 200) {
          toast.success(data.message);
          getProduct();
        }
      } catch (error) {
        toast.error(error.response?.data?.error);
      }
    }
  };

  const soldProductWithHeightBid = async (e, product_id) => {
    e.preventDefault();
    if (window.confirm("Do you want to sold out?")) {
      try {
        const { data, status } = await axios.put(
          `${process.env.REACT_APP_BASE_URL}/api/product_sold/${product_id}`
        );
        if (status === 200) {
          toast.success(data.message);
          getProduct();
        }
      } catch (error) {
        toast.error(error.response?.data?.error);
      }
    }
  };

  return (
    <>
      <div className="relative overflow-x-auto rounded-lg">
        <table className="w-full text-sm text-left rtl:text-right text-gray-500">
          <thead className="text-xs text-gray-700 uppercase bg-gray-100">
            <tr>
              <th scope="col" className="px-6 py-5">
                S.N
              </th>
              <th scope="col" className="px-6 py-5">
                Title
              </th>
              <th scope="col" className="px-6 py-3">
                Commission
              </th>
              <th scope="col" className="px-6 py-3">
                Price
              </th>
              <th scope="col" className="px-6 py-3 text-nowrap">
                Bid Amount
              </th>
              <th scope="col" className="px-6 py-3">
                Image
              </th>
              <th scope="col" className="px-6 py-3">
                Verify
              </th>
              <th scope="col" className="px-6 py-3">
                Sold
              </th>
              <th scope="col" className="px-6 py-3">
                Action
              </th>
            </tr>
          </thead>
          <tbody>
            {formData.map((data, index) => (
              <tr
                key={index}
                className={`bg-white border-b hover:bg-gray-50`}
              >
                <td className="px-6 py-4">{index + 1}</td>
                <td className="px-6 py-4">{data.title}</td>
                <td className="px-6 py-4">{data.commission}</td>
                <td className="px-6 py-4">{data.price}</td>
                <td className="px-6 py-4">{data.total_bids}</td>
                <td className="px-6 py-4">
                  <img
                    className="w-10 h-10"
                    src={data.image}
                    alt={data.title}
                  />
                </td>
                <td className="px-6 py-4">
                  <div className="flex items-center">
                    <div
                      className={`h-2.5 w-2.5 rounded-full ${
                        data.isverify ? "bg-green" : "bg-red-500"
                      } me-2`}
                    ></div>{" "}
                    {data.isverify ? "Yes" : "No"}
                  </div>
                </td>
                <td className="px-6 py-4">
                  <button
                    type="submit"
                    disabled={data.is_soldout}
                    onClick={(e) => soldProductWithHeightBid(e, data.id)}
                    className={`text-nowrap text-center py-[1px] px-[10px] text-[11px] text-white rounded-lg ${
                      data.is_soldout ? "bg-red-500" : "bg-green"
                    }`}
                  >
                    {data.is_soldout ? "Sold Out" : "Sell"}
                  </button>
                </td>
                <td className="px-6 py-4 text-center flex items-center gap-3 mt-1">
                  <NavLink
                    to={`./view/${data.id}`}
                    type="button"
                    className="font-medium text-indigo-500"
                  >
                    <TiEyeOutline size={25} />
                  </NavLink>
                  <NavLink
                    to={`./update/${data.id}`}
                    type="button"
                    className="font-medium text-green"
                  >
                    <CiEdit size={25} />
                  </NavLink>
                  <button
                    className="font-medium text-red-500"
                    onClick={(e) => handleDeleteProduct(e, data.id)}
                  >
                    <MdOutlineDeleteOutline size={25} />
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </>
  );
};

/* export const Table = ({ products, handleSellProduct, delProduct, isAdmin, isWon }) => {
  return (
    <>
      <div className="relative overflow-x-auto rounded-lg">
        <table className="w-full text-sm text-left rtl:text-right text-gray-500">
          <thead className="text-xs text-gray-700 uppercase bg-gray-100">
            <tr>
              <th scope="col" className="px-6 py-5">
                S.N
              </th>
              <th scope="col" className="px-6 py-5">
                Title
              </th>
              <th scope="col" className="px-6 py-3">
                Commission
              </th>
              <th scope="col" className="px-6 py-3">
                Price
              </th>
              <th scope="col" className="px-6 py-3">
                Bid Amount(USD)
              </th>
              <th scope="col" className="px-6 py-3">
                Image
              </th>
              {isWon && (
                <th scope="col" className="px-6 py-3">
                  Status
                </th>
              )}
              {!isWon && (
                <>
                  <th scope="col" className="px-6 py-3">
                    Verify
                  </th>
                  {!isAdmin && (
                    <th scope="col" className="px-6 py-3">
                      Sold
                    </th>
                  )}
                  <th scope="col" className="px-6 py-3">
                    Action
                  </th>
                </>
              )}
            </tr>
          </thead>
          <tbody>
            {products.map((product, index) => (
              <tr className="bg-white border-b hover:bg-gray-50" key={index}>
                <td className="px-6 py-4">{index + 1}</td>
                <td className="px-6 py-4">{product?.title?.slice(0, 15)}...</td>
                <td className="px-6 py-4">{product?.commission}%</td>
                <td className="px-6 py-4">{product?.price}</td>
                <td className="px-6 py-4">{product?.biddingPrice}</td>
                <td className="px-6 py-4">
                  <img className="w-10 h-10" src={product?.image?.filePath} alt="Jeseimage" />
                </td>
                {!isWon && (
                  <>
                    <td className="px-6 py-4">
                      {product?.isverify ? (
                        <div className="flex items-center">
                          <div className="h-2.5 w-2.5 rounded-full bg-green me-2"></div> Yes
                        </div>
                      ) : (
                        <div className="flex items-center">
                          <div className="h-2.5 w-2.5 rounded-full bg-red-500 me-2"></div> No
                        </div>
                      )}
                    </td>
                    {!isAdmin && (
                      <td className="py-3 px-6">
                        {product?.isSoldout ? (
                          <button className="bg-red-500 text-white py-1 px-3 rounded-lg" disabled>
                            Sold Out
                          </button>
                        ) : (
                          <button
                            className={`py-1 px-3 rounded-lg ${product?.isverify ? "bg-green text-white" : "bg-gray-400 text-gray-700 cursor-not-allowed"}`}
                            onClick={() => handleSellProduct(product._id)}
                            disabled={!product?.isverify}
                          >
                            Sell
                          </button>
                        )}
                      </td>
                    )}
                    <td className="px-6 py-4 text-center flex items-center gap-3 mt-1">
                      <NavLink to="#" type="button" className="font-medium text-indigo-500">
                        <TiEyeOutline size={25} />
                      </NavLink>
                      {isAdmin ? (
                        <NavLink to={`/product/admin/update/${product._id}`} className="font-medium text-green">
                          <CiEdit size={25} />
                        </NavLink>
                      ) : (
                        <NavLink to={`/product/update/${product._id}`} className="font-medium text-green">
                          <CiEdit size={25} />
                        </NavLink>
                      )}
                      {!isAdmin && (
                        <button onClick={() => delProduct(product._id)} className="font-medium text-red-500">
                          <MdOutlineDeleteOutline size={25} />
                        </button>
                      )}
                    </td>
                  </>
                )}
                {isWon && (
                  <td className="py-3 px-6">
                    <button className="bg-green text-white py-1 px-3 rounded-lg" disabled>
                      Victory
                    </button>
                  </td>
                )}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </>
  );
}; */
