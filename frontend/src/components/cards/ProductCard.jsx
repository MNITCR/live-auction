import PropTypes from "prop-types";
import { RiAuctionFill } from "react-icons/ri";
import { GiTakeMyMoney } from "react-icons/gi";
import { MdOutlineFavorite } from "react-icons/md";
import {
  Caption,
  commonClassNameOfInput,
  PrimaryButton,
  ProfileCard,
  Title,
} from "../common/Design";
import { NavLink } from "react-router-dom";
import { useEffect, useState } from "react";
import axios from "axios";
import { toast } from "react-toastify";
import { AiOutlinePlus } from "react-icons/ai";

export const ProductCard = ({ item }) => {
  const [productData, setProductData] = useState(item);
  const id = productData.id;
  const user_id = localStorage.getItem("user_id");
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [addBid, setAddBid] = useState({
    user_id: Number(user_id),
    product_id: Number(id),
    price: 0,
  });

  const handleSubmitBid = async (e) => {
    e.preventDefault();
    if (addBid.price < 0) {
      toast.error("Please Enter Price for bid");
      return;
    }

    if (
      Number(addBid.price) == productData?.price ||
      Number(addBid.price) < productData?.price ||
      Number(addBid.price) < productData?.max_price_bid ||
      Number(addBid.price) == productData?.max_price_bid
    ) {
      toast.error(
        "Price bidding must be larger than product price or current bid"
      );
      return;
    }
    try {
      const { data } = await axios.post(
        `${process.env.REACT_APP_BASE_URL}/api/bidding-products`,
        addBid
      );
      toast.success(data.message);

      setProductData((prev) => ({
        ...prev,
        max_price_bid: Number(addBid.price),
      }));
      setIsModalOpen(false);
      // itemBid();
    } catch (error) {
      toast.error(error.response.data.message || "Error Add bid");
    }
  };

  const handleChangePriceBid = () => {
    if (!productData || !productData?.price) return;

    const increment =
      Number(productData?.max_price_bid ? productData?.max_price_bid : productData?.price) * 0.5;

    setAddBid((prev) => ({
      ...prev,
      price: Number(prev?.price || 0) + increment,
    }));
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setAddBid((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  useEffect(()=>{
    addBid.price = addBid?.price ? addBid?.price : productData.max_price_bid
  },[]);

  return (
    <>
      <div className="bg-white shadow-s1 rounded-xl p-3">
        <div className="h-56 relative overflow-hidden">
          <NavLink to={`/details/${productData?.id}`}>
            <img
              src={productData?.image}
              alt={productData?.image}
              className="w-full h-full object-cover rounded-xl hover:scale-105 hover:cursor-pointer transition-transform duration-300 ease-in-out"
            />
          </NavLink>
          <ProfileCard className="shadow-s1 absolute right-3 bottom-3">
            <RiAuctionFill size={22} className="text-green" />
          </ProfileCard>

          <div className="absolute top-0 left-0 p-2 w-full">
            <div className="flex items-center justify-between">
              {productData?.is_soldout ? (
                <Caption className="text-red-500 bg-white px-3 py-1 text-sm rounded-full">
                  Sold Out
                </Caption>
              ) : (
                <Caption className="text-green bg-green_100 px-3 py-1 text-sm rounded-full">
                  On Stock
                </Caption>
              )}
              <Caption className={`${new Date(productData?.end_date) < new Date().getTime() || productData?.is_soldout ? 'text-red-500' : 'text-green'} bg-green_100 px-3 py-1 text-sm rounded-full`}>
                {new Date(productData?.end_date) < new Date().getTime() || productData?.is_soldout ? 'No Bid' : 'Bids'}
              </Caption>
            </div>
          </div>
        </div>
        <div className="details mt-4">
          <Title className="uppercase">{productData.title}</Title>
          <hr className="mt-3" />
          <div className="flex items-center justify-between py-4">
            <div className="flex items-center justify-between gap-5">
              <div>
                <RiAuctionFill size={40} className="text-green" />
              </div>
              <div>
                <Caption className="text-green">Current Bid</Caption>
                <Title>${productData?.max_price_bid}</Title>
              </div>
            </div>
            <div className="w-[1px] h-10 bg-gray-300"> </div>
            <div className="flex items-center justify-between gap-5">
              <div>
                <GiTakeMyMoney size={40} className="text-red-500" />
              </div>
              <div>
                <Caption className="text-red-500">Buy Now</Caption>
                <Title>${productData?.price}</Title>
              </div>
            </div>
          </div>
          <hr className="mb-3" />

          <div
            className="flex items-center  justify-between mt-3"
          >
            <div onClick={() => setIsModalOpen(true)}>
              <PrimaryButton className="rounded-lg text-sm">
                Place Bid
              </PrimaryButton>
            </div>
            <PrimaryButton className="rounded-lg px-4 py-3">
              <MdOutlineFavorite size={20} />
            </PrimaryButton>
          </div>
        </div>
      </div>

      {/* Modal */}
      {isModalOpen && (
        <div className="fixed inset-0 bg-black bg-opacity-40 z-50 flex justify-center items-center">
          <div className="bg-white rounded-lg shadow-lg w-full max-w-md p-6 relative">
            <div className="flex gap-4 justify-between">
              <h3 className="text-xl font-semibold text-gray-900 mb-4">
                Current Bid : {productData.max_price_bid || "0.00"}
              </h3>
              <button
                className="text-gray-500 hover:text-red-500 text-3xl inline-block relative bottom-3"
                onClick={() => setIsModalOpen(false)}
              >
                &times;
              </button>
            </div>

            <div
              className={`${
                localStorage.getItem("user_id") == productData?.user ||
                localStorage.getItem("role") == "admin"
                  ? "hidden"
                  : ""
              }`}
            >
              <form
                className="space-y-4"
                method="POST"
                onSubmit={handleSubmitBid}
              >
                <div className="flex gap-4">
                  <input
                    className={commonClassNameOfInput}
                    type="number"
                    name="price"
                    onChange={handleChange}
                    value={addBid?.price}
                    disabled={productData?.isverify == 0 || productData?.is_soldout || new Date(productData?.end_date) < new Date().getTime()}
                  />
                  <button
                    type="button"
                    onClick={handleChangePriceBid}
                    className="bg-gray-100 rounded-md px-5 py-3"
                    disabled={productData?.isverify == 0 || productData?.is_soldout || new Date(productData?.end_date) < new Date().getTime()}
                  >
                    <AiOutlinePlus />
                  </button>
                </div>

                <button
                  type="submit"
                  disabled={productData?.isverify == 0 || productData?.is_soldout || new Date(productData?.end_date) < new Date().getTime()}
                  className={`py-3 px-8 rounded-lg ${
                    productData?.isverify == 0 || productData?.is_soldout || new Date(productData?.end_date) < new Date().getTime()
                      ? "bg-gray-400 text-gray-700 cursor-not-allowed"
                      : "bg-green text-white"
                  }`}
                >
                  Submit
                </button>
              </form>
            </div>
          </div>
        </div>
      )}
    </>
  );
};

ProductCard.propTypes = {
  item: PropTypes.any,
};
