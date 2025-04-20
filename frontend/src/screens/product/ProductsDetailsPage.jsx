import { Body, Caption, Container, Title } from "../../router";
import { IoIosStar, IoIosStarHalf, IoIosStarOutline } from "react-icons/io";
import { commonClassNameOfInput } from "../../components/common/Design";
import { AiOutlinePlus } from "react-icons/ai";
import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { toast } from "react-toastify";
import axios from "axios";
import useProductBids from "./productlist/useProductBids";

export const ProductsDetailsPage = () => {
  const [activeTab, setActiveTab] = useState("description");
  const { id } = useParams();
  const { getProductBid } = useProductBids(id);
  const user_id = localStorage.getItem("user_id");
  const [addBid, setAddBid] = useState({
    user_id: Number(user_id),
    product_id: Number(id),
    price: 0,
  });
  const [getProduct, setProduct] = useState();
  const [timeLeft, setTimeLeft] = useState({
    timezone: "UTC 0",
    days: "00",
    hours: "00",
    minutes: "00",
    seconds: "00",
  });

  useEffect(() => {
    const fetchProduct = async () => {
      try {
        const { data } = await axios.get(
          `${process.env.REACT_APP_BASE_URL}/api/get_product_by_id/${id}`
        );
        setProduct(data);
        setAddBid((prev) => ({
          ...prev,
          price: data?.max_price_bid ? data?.max_price_bid : data?.price,
        }));
      } catch (error) {
        toast.error(error.response.data?.error || "Error get product");
      }
    };
    fetchProduct();
  }, []);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setAddBid((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  const handleSubmitBid = async (e) => {
    e.preventDefault();
    if (addBid.price < 0) {
      toast.error("Please Enter Price for bid");
      return;
    }

    if (addBid.price == getProduct.price || addBid.price < getProduct.price || addBid.price < getProduct?.max_price_bid || addBid.price == getProduct?.max_price_bid) {
      toast.error("Price bidding must be larger than product price or current bid");
      return;
    }
    try {
      const { data } = await axios.post(
        `${process.env.REACT_APP_BASE_URL}/api/bidding-products`,
        addBid
      );
      toast.success(data.message);
      getProductBid();
    } catch (error) {
      toast.error(error.response.data.message || "Error Add bid");
    }
  };

  const handleTabClick = (tab) => {
    setActiveTab(tab);
  };

  const handleChangePriceBid = () => {
    if (!getProduct || !getProduct?.price) return;

    const increment = Number(getProduct?.max_price_bid ? getProduct?.max_price_bid : getProduct?.price) * 0.5;

    setAddBid((prev) => ({
      ...prev,
      price: Number(prev?.price || 0) + increment,
    }));
  };

  const AutoSoldProductWithHeightBid = async () => {
    try {
      const { data, status } = await axios.put(
        `${process.env.REACT_APP_BASE_URL}/api/product_auto_sold/${id}`
      );
      if (status === 200) {
        toast.success(data.message);
        // getProduct();
      }
    } catch (error) {
      toast.error(error.response?.data?.error);
    }
  };

  useEffect(() => {
    if (!getProduct?.end_date || getProduct?.is_soldout || new Date(getProduct?.end_date) < new Date().getTime()) return;
    const interval = setInterval(() => {
      const endTime = new Date(getProduct?.end_date);
      // const endTime = new Date("April 19, 2025 08:45 PM");
      const currentTime = new Date().getTime();
      const timeDiff = endTime - currentTime;

      if (timeDiff <= 0) {
        clearInterval(interval);
        setTimeLeft({ days: "00", hours: "00", minutes: "00", seconds: "00" });
        AutoSoldProductWithHeightBid();
        return;
      }

      const days = Math.floor(timeDiff / (1000 * 60 * 60 * 24));
      const hours = Math.floor((timeDiff / (1000 * 60 * 60)) % 24);
      const minutes = Math.floor((timeDiff / (1000 * 60)) % 60);
      const seconds = Math.floor((timeDiff / 1000) % 60);

      setTimeLeft({
        timezone: endTime.toString().match(/GMT([+-]\d{4})/)[0],
        days: String(days).padStart(2, "0"),
        hours: String(hours).padStart(2, "0"),
        minutes: String(minutes).padStart(2, "0"),
        seconds: String(seconds).padStart(2, "0"),
      });
    }, 1000);

    return () => clearInterval(interval);
  }, [getProduct?.end_date]);

  return (
    <>
      <section className="pt-24 px-8">
        <Container>
          <div className="flex justify-between gap-8">
            <div className="w-1/2">
              <div className="h-[70vh]">
                <img
                  src={getProduct?.image}
                  alt={getProduct?.title}
                  className="w-full h-full object-cover rounded-xl"
                />
              </div>
            </div>
            <div className="w-1/2">
              <Title level={2} className="capitalize">
                {getProduct?.title}
              </Title>
              <div className="flex gap-5">
                <div className="flex text-green ">
                  <IoIosStar size={20} />
                  <IoIosStar size={20} />
                  <IoIosStar size={20} />
                  <IoIosStarHalf size={20} />
                  <IoIosStarOutline size={20} />
                </div>
                <Caption>(2 customer reviews)</Caption>
              </div>
              <br />
              <Body>{getProduct?.description}</Body>
              <br />
              <Caption>Item condition: New</Caption>
              <br />
              <Caption>
                Item Verifed: {getProduct?.isverify ? "Yes" : "No"}
              </Caption>
              <br />
              <Caption>Time left:</Caption>
              <br />
              <div className="flex gap-8 text-center">
                <div className="p-5 px-10 shadow-s1">
                  <Title level={4}>{timeLeft.days}</Title>
                  <Caption>Days</Caption>
                </div>
                <div className="p-5 px-10 shadow-s1">
                  <Title level={4}>{timeLeft.hours}</Title>
                  <Caption>Hours</Caption>
                </div>
                <div className="p-5 px-10 shadow-s1">
                  <Title level={4}>{timeLeft.minutes}</Title>
                  <Caption>Minutes</Caption>
                </div>
                <div className="p-5 px-10 shadow-s1">
                  <Title level={4}>{timeLeft.seconds}</Title>
                  <Caption>Seconds</Caption>
                </div>
              </div>
              <br />
              <Title className="flex items-center gap-2">
                Auction ends:
                <Caption>{getProduct?.end_date}</Caption>
              </Title>
              <Title className="flex items-center gap-2 my-5">
                Timezone: <Caption>{timeLeft.timezone}</Caption>
              </Title>
              <Title className="flex items-center gap-2 my-5">
                Price:<Caption>{getProduct?.price} $</Caption>
              </Title>
              <Title className="flex items-center gap-2">
                Current bid:
                <Caption className="text-3xl">
                  {getProduct?.max_price_bid ? getProduct?.max_price_bid : "0.00"} $
                </Caption>
              </Title>
              <div
                className={`p-5 px-10 shadow-s3 py-8 ${
                  localStorage.getItem("user_id") == getProduct?.user ||
                  localStorage.getItem("role") == "admin"
                    ? "hidden"
                    : ""
                }`}
              >
                <form
                  className="flex gap-3 justify-between"
                  method="POST"
                  onSubmit={handleSubmitBid}
                >
                  <input
                    className={commonClassNameOfInput}
                    type="number"
                    name="price"
                    onChange={handleChange}
                    value={addBid?.price}
                    disabled={
                      getProduct?.isverify == 0 || getProduct?.is_soldout || new Date(getProduct?.end_date) < new Date().getTime()
                    }
                  />
                  <button
                    type="button"
                    onClick={handleChangePriceBid}
                    className="bg-gray-100 rounded-md px-5 py-3"
                    disabled={
                      getProduct?.isverify == 0 || getProduct?.is_soldout || new Date(getProduct?.end_date) < new Date().getTime()
                    }
                  >
                    <AiOutlinePlus />
                  </button>
                  <button
                    type="submit"
                    disabled={
                      getProduct?.isverify == 0 || getProduct?.is_soldout || new Date(getProduct?.end_date) < new Date().getTime()
                    }
                    className={`py-3 px-8 rounded-lg ${
                      getProduct?.isverify == 0 || getProduct?.is_soldout || new Date(getProduct?.end_date) < new Date().getTime()
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
          <div className="details mt-8">
            <div className="flex items-center gap-5">
              <button
                className={`rounded-md px-10 py-4 text-black shadow-s3 ${
                  activeTab === "description"
                    ? "bg-green text-white"
                    : "bg-white"
                }`}
                onClick={() => handleTabClick("description")}
              >
                Description
              </button>
              <button
                className={`rounded-md px-10 py-4 text-black shadow-s3 ${
                  activeTab === "auctionHistory"
                    ? "bg-green text-white"
                    : "bg-white"
                }`}
                onClick={() => handleTabClick("auctionHistory")}
              >
                Auction History
              </button>
              <button
                className={`rounded-md px-10 py-4 text-black shadow-s3 ${
                  activeTab === "reviews" ? "bg-green text-white" : "bg-white"
                }`}
                onClick={() => handleTabClick("reviews")}
              >
                Reviews(2)
              </button>
              <button
                className={`rounded-md px-10 py-4 text-black shadow-s3 ${
                  activeTab === "moreProducts"
                    ? "bg-green text-white"
                    : "bg-white"
                }`}
                onClick={() => handleTabClick("moreProducts")}
              >
                More Products
              </button>
            </div>

            <div className="tab-content mt-8">
              {activeTab === "description" && (
                <div className="description-tab shadow-s3 p-8 rounded-md">
                  <Title level={4}>Description</Title>
                  <br />
                  <Caption className="leading-7">
                    If you’ve been following the crypto space, you’ve likely
                    heard of Non-Fungible Tokens (Biddings), more popularly
                    referred to as ‘Crypto Collectibles.’ The world of Biddings
                    is growing rapidly. It seems there is no slowing down of
                    these assets as they continue to go up in price. This growth
                    comes with the opportunity for people to start new
                    businesses to create and capture value. The market is open
                    for players in every kind of field. Are you a collector.
                  </Caption>
                  <Caption className="leading-7">
                    If you’ve been following the crypto space, you’ve likely
                    heard of Non-Fungible Tokens (Biddings), more popularly
                    referred to as ‘Crypto Collectibles.’ The world of Biddings
                    is growing rapidly. It seems there is no slowing down of
                    these assets as they continue to go up in price. This growth
                    comes with the opportunity for people to start new
                    businesses to create and capture value. The market is open
                    for players in every kind of field. Are you a collector.
                  </Caption>
                  <br />
                  <Title level={4}>Product Overview</Title>
                  <div className="flex justify-between gap-5">
                    <div className="mt-4 capitalize w-1/2">
                      <div className="flex justify-between border-b py-3">
                        <Title>category</Title>
                        <Caption>{getProduct?.category}</Caption>
                      </div>
                      <div
                        className={`flex justify-between border-b py-3 ${
                          Number(getProduct?.height) !== 0 ? "" : "hidden"
                        }`}
                      >
                        <Title>height</Title>
                        <Caption>{getProduct?.height} (cm)</Caption>
                      </div>
                      <div
                        className={`flex justify-between border-b py-3 ${
                          getProduct?.length ? "" : "hidden"
                        }`}
                      >
                        <Title>length</Title>
                        <Caption> {getProduct?.length} (cm)</Caption>
                      </div>
                      <div
                        className={`flex justify-between border-b py-3 ${
                          Number(getProduct?.width) !== 0 ? "" : "hidden"
                        }`}
                      >
                        <Title>width</Title>
                        <Caption> {getProduct?.width} (cm)</Caption>
                      </div>
                      <div
                        className={`flex justify-between border-b py-3 ${
                          getProduct?.weigth ? "" : "hidden"
                        }`}
                      >
                        <Title>weigth</Title>
                        <Caption> {getProduct?.weigth} (kg)</Caption>
                      </div>
                      <div
                        className={`flex justify-between py-3 border-b ${
                          getProduct?.medium ? "" : "hidden"
                        }`}
                      >
                        <Title>medium used</Title>
                        <Caption> {getProduct?.medium} </Caption>
                      </div>
                      <div className="flex justify-between py-3 border-b">
                        <Title>Price</Title>
                        <Caption> {getProduct?.price} $</Caption>
                      </div>
                      <div className="flex justify-between py-3 border-b">
                        <Title>Sold out</Title>
                        {getProduct?.is_soldout ? "Yes" : "No"}
                      </div>
                      <div className="flex justify-between py-3 border-b">
                        <Title>verify</Title>
                        {getProduct?.isverify ? "Yes" : "No"}
                      </div>
                      <div className="flex justify-between py-3 border-b">
                        <Title>Create At</Title>
                        <Caption>{getProduct?.created_at}</Caption>
                      </div>
                      <div className="flex justify-between py-3">
                        <Title>Update At</Title>
                        <Caption>{getProduct?.updated_at}</Caption>
                      </div>
                    </div>
                    <div className="w-1/2">
                      <div className="h-[60vh] p-2 bg-green rounded-xl">
                        <img
                          src={getProduct?.image}
                          alt={getProduct?.title}
                          className="w-full h-full object-cover rounded-xl"
                        />
                      </div>
                    </div>
                  </div>
                </div>
              )}
              {activeTab === "auctionHistory" && <AuctionHistory />}
              {activeTab === "reviews" && (
                <div className="reviews-tab shadow-s3 p-8 rounded-md">
                  <Title level={5} className=" font-normal">
                    Reviews
                  </Title>
                  <hr className="my-5" />
                  <Title level={5} className=" font-normal text-red-500">
                    Cooming Soon!
                  </Title>
                </div>
              )}
              {activeTab === "moreProducts" && (
                <div className="more-products-tab shadow-s3 p-8 rounded-md">
                  <h1>More Products</h1>
                </div>
              )}
            </div>
          </div>
        </Container>
      </section>
    </>
  );
};
export const AuctionHistory = () => {
  const { id } = useParams();
  const { productBids, error, getProductBid } = useProductBids(id);
  useEffect(() => {
    getProductBid();
  }, []);

  return (
    <>
      <div className="shadow-s1 p-8 rounded-lg">
        <Title level={5} className=" font-normal">
          Auction History
        </Title>
        <hr className="my-5" />

        <div className="relative overflow-x-auto rounded-lg">
          <table className="w-full text-sm text-left rtl:text-right text-gray-500">
            <thead className="text-xs text-gray-700 uppercase bg-gray-100">
              <tr>
                <th scope="col" className="px-6 py-5">
                  Date
                </th>
                <th scope="col" className="px-6 py-3">
                  Bid Amount(USD)
                </th>
                <th scope="col" className="px-6 py-3">
                  User
                </th>
                <th scope="col" className="px-6 py-3">
                  Auto
                </th>
              </tr>
            </thead>
            <tbody>
              {productBids && productBids.length > 0 ? (
                productBids.map((bid, index) => (
                  <tr
                    key={index}
                    className={`${bid.is_win ? 'bg-green_100' : 'bg-white'} border-b hover:bg-gray-50`}
                  >
                    <td className="px-6 py-4">{bid.bid_date}</td>
                    <td className="px-6 py-4">{bid.bid_price} $</td>
                    <td className="px-6 py-4">{bid.user_name}</td>
                    <td className="px-6 py-4">{bid.is_auto_bid ? <p className="text-green">Yes</p> : ''}</td>
                  </tr>
                ))
              ) : (
                <tr className="bg-white border-b hover:bg-gray-50">
                  <td colSpan="4" className="text-center px-6 py-4">
                    {error}
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </div>
    </>
  );
};
