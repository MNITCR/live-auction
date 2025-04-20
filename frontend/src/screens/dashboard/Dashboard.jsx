import React, { useEffect, useState } from "react";
import { Title } from "../../router";
import { CiMedal } from "react-icons/ci";
import { GiBarbedStar } from "react-icons/gi";
import { BsCashCoin } from "react-icons/bs";
import { MdDashboard, MdOutlineCategory } from "react-icons/md";
import { NavLink } from "react-router-dom";
import { HiOutlineUsers } from "react-icons/hi2";
import { toast } from "react-toastify";
import axios from "axios";

export const Dashboard = () => {
  const [biddingList, setBiddingList] = useState(0);
  const [productByUser, setProductByUser] = useState(0);
  const [products, setProducts] = useState(0);
  const[users, setUsers] = useState(0);
  const [amounts, setAmounts] = useState(0);
  var id = localStorage.getItem("user_id");
  const role = localStorage.getItem("role");
  const url = role !== 'admin' ? `${process.env.REACT_APP_BASE_URL}/api/sum_amount_by_user/${id}` : `${process.env.REACT_APP_BASE_URL}/api/sum_amount_by_admin`;
  const url_bidding = role == "admin" ? `${process.env.REACT_APP_BASE_URL}/api/bidding_products` : `${process.env.REACT_APP_BASE_URL}/api/bidding_by_user/${id}`

  useEffect(() => {
    const getProductByUser = async () => {
      try {
        const { data:amount } = await axios.get(url);
        setAmounts(amount.amounts);
        const { data:user } = await axios.get(
          `${process.env.REACT_APP_BASE_URL}/api/user_count`
        );
        setUsers(user.user_count);
        const { data } = await axios.get(
          `${process.env.REACT_APP_BASE_URL}/api/product_count_by_user/${id}`
        );
        setProductByUser(data.product_count);
        const { data: prd } = await axios.get(
          `${process.env.REACT_APP_BASE_URL}/api/product_counts`
        );
        setProducts(prd.product_counts);

        const { data: bid } = await axios.get(url_bidding);
        setBiddingList(bid.length);
      } catch (error) {
        toast.error(error.response.data.error);
      }
    };
    getProductByUser();
  }, []);

  return (
    <>
      <section>
        <div className="shadow-s1 p-8 rounded-lg  mb-12">
          <Title level={5} className=" font-normal">
            My Activity
          </Title>
          <hr className="my-5" />

          <div className="grid grid-cols-3 gap-8 mt-8">
            <div className="shadow-s3 border border-green bg-green_100 p-8 flex items-center text-center justify-center gap-5 flex-col rounded-xl">
              <BsCashCoin size={80} className="text-green" />
              <div>
                <Title level={1}>{amounts} </Title>
                <Title>Balance</Title>
              </div>
            </div>
            <div className="shadow-s3 border border-green bg-green_100 p-8 flex items-center text-center justify-center gap-5 flex-col rounded-xl">
              <CiMedal size={80} className="text-green" />
              <div>
                <Title level={1}>{biddingList}</Title>
                <Title>Items Won</Title>
              </div>
            </div>
            <div className="shadow-s3 border border-green bg-green_100 p-8 flex items-center text-center justify-center gap-5 flex-col rounded-xl">
              <GiBarbedStar size={80} className="text-green" />
              <div>
                <Title level={1}>{productByUser}</Title>
                <Title>Your Products </Title>
              </div>
            </div>
            {role === "admin" && (
              <>
                <div className="shadow-s3 border border-green bg-green_100 p-8 flex items-center text-center justify-center gap-5 flex-col rounded-xl">
                  <MdOutlineCategory size={80} className="text-green" />
                  <div>
                    <Title level={1}>{products}</Title>
                    <Title>All Products </Title>
                  </div>
                </div>
                <div className="shadow-s3 border border-green bg-green_100 p-8 flex items-center text-center justify-center gap-5 flex-col rounded-xl">
                  <HiOutlineUsers size={80} className="text-green" />
                  <div>
                    <Title level={1}>{users}</Title>
                    <Title>All Users </Title>
                  </div>
                </div>
              </>
            )}
          </div>
        </div>
      </section>
    </>
  );
};

export const UserProduct = () => {
  return (
    <>
      <div className="shadow-s1 p-8 rounded-lg">
        <Title level={5} className=" font-normal">
          Purchasing
        </Title>
        <hr className="my-5" />
        <div className="relative overflow-x-auto rounded-lg">
          <table className="w-full text-sm text-left rtl:text-right text-gray-500">
            <thead className="text-xs text-gray-700 uppercase bg-gray-100">
              <tr>
                <th scope="col" className="px-6 py-5">
                  Title
                </th>
                <th scope="col" className="px-6 py-3">
                  Bidding ID
                </th>
                <th scope="col" className="px-6 py-3">
                  Bid Amount(USD)
                </th>
                <th scope="col" className="px-6 py-3">
                  Image
                </th>
                <th scope="col" className="px-6 py-3">
                  Status
                </th>
                <th scope="col" className="px-6 py-3">
                  Action
                </th>
              </tr>
            </thead>
            <tbody>
              <tr className="bg-white border-b hover:bg-gray-50">
                <td className="px-6 py-4">Auction Title 01</td>
                <td className="px-6 py-4">Bidding_HvO253gT</td>
                <td className="px-6 py-4">1222.8955</td>
                <td className="px-6 py-4">
                  <img
                    className="w-10 h-10"
                    src="https://bidout-react.vercel.app/images/bg/order1.png"
                    alt="Jeseimage"
                  />
                </td>
                <td className="px-6 py-4">
                  <div className="flex items-center">
                    <div className="h-2.5 w-2.5 rounded-full bg-green me-2"></div>{" "}
                    Success
                  </div>
                </td>
                <td className="px-6 py-4 text-center">
                  <NavLink
                    to="#"
                    type="button"
                    className="font-medium text-green"
                  >
                    <MdDashboard size={25} />
                  </NavLink>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </>
  );
};
