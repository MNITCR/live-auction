import { toast } from "react-toastify";
import { Container, Heading } from "../../router";
import { ProductCard } from "../cards/ProductCard";
import axios from "axios";
import { useEffect, useState } from "react";

export const ProductList = () => {
  const [productLists, setProductLists] = useState([]);

  useEffect(() => {
    // Create WebSocket connection
    const socket = new WebSocket("ws://localhost:8000/ws/products/");

    // Handle WebSocket connection open
    socket.onopen = () => {
      console.log("WebSocket connected ✅");
    };

    // Handle WebSocket incoming message
    socket.onmessage = (event) => {
      const update = JSON.parse(event.data);
      console.log("Message from server:", update);

      // Update the product list with the received data
      setProductLists((prev) =>
        prev
          .map((item) =>
            item.id === update.product_id
              ? { ...item, price: update.price, total_bids: update.total_bids }
              : item
          )
          .filter((item) => !update.is_deleted || item.id !== update.product_id)
      );
    };

    // Handle WebSocket closure
    socket.onclose = (e) => {
      console.log("WebSocket closed ❌", e);
    };

    // Handle WebSocket errors
    socket.onerror = (e) => {
      console.error("WebSocket error 🚨", e);
    };

    // Fetch product list from the backend
    const getProducts = async () => {
      try {
        const { data } = await axios.get(
          `${process.env.REACT_APP_BASE_URL}/api/get_product_list_with_bid`
        );
        setProductLists(data);
      } catch (error) {
        toast.error(error.response?.data?.error);
      }
    };

    getProducts();

    // Cleanup WebSocket connection when component unmounts
    return () => {
      socket.close();
    };
  }, []); // Empty dependency array ensures this effect runs only once on mount

  return (
    <>
      <section className="product-home">
        <Container>
          <Heading
            title="Live Auction"
            subtitle="Explore on the world's best & largest Bidding marketplace with our beautiful Bidding products. We want to be a part of your smile, success and future growth."
          />

          <div className="grid grid-cols-1 md:grid-cols-4 gap-8 my-8">
            {productLists?.map((item, index) => (
              <ProductCard item={item} key={index + 1} />
            ))}
          </div>
        </Container>
      </section>
    </>
  );
};
