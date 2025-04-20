import React, { useEffect, useState } from "react";
import { Title } from "../../router";
import { toast } from "react-toastify";
import axios from "axios";

export const WinningBidList = () => {
  const [biddingList, setBiddingList] = useState([]);
  const role = localStorage.getItem("role");
  const user_id = localStorage.getItem("user_id");
  const getBiddingProducts = async () => {
    try {
      const url = role == "admin" ? "http://localhost:8000/api/bidding_products" : `http://localhost:8000/api/bidding_by_user/${user_id}`
      const { data } = await axios.get(url);
      setBiddingList(data);
    } catch (error) {
      toast.error(error.response.data.error);
    }
  };
  useEffect(() => {
    getBiddingProducts();
  }, []);


  return (
    <>
      <section className="shadow-s1 p-8 rounded-lg">
        <div className="flex justify-between">
          <Title level={5} className=" font-normal">
            Winning Product Lists
          </Title>
        </div>
        <br />

        <div className="text-center py-2">
          <table className="w-full text-sm text-left text-gray-500">
            <thead className="text-xs text-gray-700 uppercase bg-gray-100">
              <tr>
                <th scope="col" className="px-6 py-5">
                  S.N
                </th>
                <th scope="col" className="px-6 py-5">
                  Product
                </th>
                <th scope="col" className="px-6 py-5">
                  Bid Winner
                </th>
                <th scope="col" className="px-6 py-5">
                  Winning Price
                </th>
                <th scope="col" className="px-6 py-5">
                  Date
                </th>
                {/* <th scope="col" className="px-6 py-5">
                  Action
                </th> */}
              </tr>
            </thead>
            <tbody>
              {biddingList.map((data, index) => (
                <tr key={index} className="bg-white border-b hover:bg-gray-50">
                  <td className="px-6 py-3">{index+1}</td>
                  <td className="px-6 py-3">{data.product_name}</td>
                  <td className="px-6 py-3">{data.user_name}</td>
                  <td className="px-6 py-3">{data.bid_price}</td>
                  <td className="px-6 py-3">{data.bid_date}</td>
                </tr>
              ))
              }
            </tbody>
          </table>
          </div>
      </section>
    </>
  );
};
