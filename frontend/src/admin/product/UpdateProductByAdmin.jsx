import { Caption, Title } from "../../router";
import {
  commonClassNameOfInput,
  PrimaryButton,
} from "../../components/common/Design";
import { useState } from "react";
import { toast } from "react-toastify";
import axios from "axios";
import { useNavigate, useParams } from "react-router-dom";

export const UpdateProductByAdmin = () => {
  const navigate = useNavigate();
  const { id } = useParams();
  const [formData, setFormData] = useState({
    commission: 0,
    start_date: "",
    end_date: "",
  });
  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };
  const handleUpdateProduct = async (e) => {
    e.preventDefault();
    try {
      const { data } = await axios.put(
        `${process.env.REACT_APP_BASE_URL}/api/product_update_by_admin/${id}`,
        { commission: formData.commission,
          start_date: formData.start_date,
          end_date: formData.end_date
        }
      );
      toast.success(data.message);
      navigate(-1);
    } catch (error) {
      toast.error(error.response.data.error || "Error update product");
    }
  };
  return (
    <>
      <section className="bg-white shadow-s1 p-8 rounded-xl">
        <Title level={5} className=" font-normal mb-5">
          Update Product
        </Title>
        <hr className="my-5" />
        <div className="create-product">
          <form method="POST" onSubmit={handleUpdateProduct}>
            <div className="w-full">
              <Caption className="mb-2">Commission with out % *</Caption>
              <input
                type="number"
                name="commission"
                className={`${commonClassNameOfInput}`}
                value={formData.commission}
                onChange={handleChange}
              />
              <Caption className="mb-2 mt-2">Start Date Bid *</Caption>
              <input
                type="datetime-local"
                name="start_date"
                className={`${commonClassNameOfInput}`}
                value={formData.start_date}
                onChange={handleChange}
              />
              <Caption className="mb-2 mt-2">End Date Bid *</Caption>
              <input
                type="datetime-local"
                name="end_date"
                className={`${commonClassNameOfInput}`}
                value={formData.end_date}
                onChange={handleChange}
              />
            </div>
            <PrimaryButton type="submit" className="rounded-none my-5">
              Update
            </PrimaryButton>
          </form>
        </div>
      </section>
    </>
  );
};
