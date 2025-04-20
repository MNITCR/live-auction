import React, { useEffect, useState } from "react";
import { PrimaryButton, Title } from "../../../router";
import { NavLink } from "react-router-dom";
import { AiOutlinePlus } from "react-icons/ai";
import { TiEyeOutline } from "react-icons/ti";
import { MdOutlineDeleteOutline } from "react-icons/md";
import { toast } from "react-toastify";
import axios from "axios";
import { CiLight } from "react-icons/ci";

export const ProductList = () => {
  const [formData, setFormData] = useState([]);
  const id = localStorage.getItem("user_id");

  const getProduct = async () => {
    try {
      const { data } = await axios.get(
        `${process.env.REACT_APP_BASE_URL}/api/product_by_user/${id}`
      );
      setFormData(data);
    } catch (error) {
      toast.error(error.response.data.message);
    }
  };

  useEffect(() => {
    getProduct();
  }, []);

  const handleDeleteProduct = async (e, product_id) => {
    e.preventDefault()
    if (window.confirm('Do you want to delete this product?')) {
      try {
        const {data, status} = await axios.delete(`${process.env.REACT_APP_BASE_URL}/api/products/${product_id}`);
        if (status === 200) {
          toast.success(data.message);
          getProduct();
        }
      } catch (error) {
        toast.error(error.response?.data?.error);
      }
    }
  }

  return (
    <>
      <section className="shadow-s1 p-8 rounded-lg">
        <div className="flex justify-between">
          <Title level={5} className=" font-normal">
            Product Lists
          </Title>
          <NavLink to="/add">
            <PrimaryButton className="flex items-center gap-3 px-5 py-2 text-sm rounded-md transition-transform hover:scale-105">
              <AiOutlinePlus size={20} />
              <span>Create Product</span>
            </PrimaryButton>
          </NavLink>
        </div>
        <hr className="my-5" />
        <div className="relative overflow-x-auto rounded-lg">
          <table className="w-full text-sm text-left rtl:text-right text-gray-500">
            <thead className="text-xs text-gray-700 uppercase bg-gray-100">
              <tr>
                <th scope="col" className="px-6 py-5">
                  Title
                </th>
                <th scope="col" className="px-6 py-3">
                 Winner
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
                  Action
                </th>
              </tr>
            </thead>
            <tbody>
              {formData.map((data, index) => (
                <tr key={index} className="bg-white border-b hover:bg-gray-50">
                  <td className="px-6 py-4">{data.title}</td>
                  <td className="px-6 py-4">{data.user_win}</td>
                  <td className="px-6 py-4">{data.max_price_bid}</td>
                  <td className="px-6 py-4">
                    <img
                      className="w-10 h-10 rounded-full"
                      src={data.image}
                      alt={data.title}
                    />
                  </td>
                  <td className="px-6 py-4">
                    <div className="flex items-center">
                      <div className={`h-2.5 w-2.5 rounded-full ${data.isverify ? 'bg-green' : 'bg-red-500'} me-2`}></div>{" "}
                      {data.isverify ? 'Yes' : 'No'}
                    </div>
                  </td>
                  <td className="px-6 py-4 text-center flex items-center gap-3 mt-1">
                    <NavLink
                      to={`admin/view/${data.id}`}
                      type="button"
                      className="font-medium text-indigo-500"
                    >
                      <TiEyeOutline size={25} />
                    </NavLink>
                    {/* <NavLink
                      to={`/view/${data.id}`}
                      type="button"
                      className="font-medium text-green"
                    >
                      <CiEdit size={25} />
                    </NavLink> */}
                    <button className="font-medium text-red-500" onClick={(e) => handleDeleteProduct(e,data.id)}>
                      <MdOutlineDeleteOutline size={25} />
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </section>
    </>
  );
};
