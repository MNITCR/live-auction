import { useState } from "react";
import axios from "axios";

const useProductBids = (productId) => {
  const [productBids, setProductBids] = useState([]);
  const [error, setError] = useState(null);

  const getProductBid = async () => {
    try {
      const { data } = await axios.get(
        `${process.env.REACT_APP_BASE_URL}/api/bidding_by_product_id/${productId}`
      );
      setProductBids(data);
    } catch (error) {
      setError(error.response?.data?.error || "Error Fetching Bids");
    }
  };

  return {
    productBids,
    error,
    getProductBid,
  };
};

export default useProductBids;
