import { PrimaryButton } from "../../router";
import {
  Caption,
  commonClassNameOfInput,
  Title,
} from "../../components/common/Design";
import { useEffect, useState } from "react";
import axios from "axios";
import { toast } from "react-toastify";
import { useNavigate, useParams } from "react-router-dom";

export const UpdateCategory = () => {
  const navigate = useNavigate();
  const { id } = useParams();
  const [formData, setFormData] = useState({
    title: "",
  });
  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  useEffect(() => {
    const getCategory = async () => {
      try {
        const { data } = await axios.get(
          `${process.env.REACT_APP_BASE_URL}/api/categories/${id}`
        );
        setFormData(data);
      } catch (error) {
        toast.error(error.response.data.error);
      }
    };
    getCategory();
  }, []);

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      const { data } = await axios.put(
        `${process.env.REACT_APP_BASE_URL}/api/categories/${id}`,
        formData
      );
      toast.success(data.message);
      navigate("/category");
    } catch (error) {
      toast.error(error.response.data.error);
    }
  };

  return (
    <>
      <section className="bg-white shadow-s1 p-8 rounded-xl">
        <Title level={5} className=" font-normal mb-5">
          Update Category
        </Title>

        <form onSubmit={handleSubmit} method="POST">
          <div className="w-full my-8">
            <Caption className="mb-2">Title *</Caption>
            <input
              type="text"
              name="title"
              value={formData.title}
              onChange={handleChange}
              className={`${commonClassNameOfInput}`}
            />
          </div>

          <PrimaryButton type="submit" className="rounded-none my-5">
            Update
          </PrimaryButton>
        </form>
      </section>
    </>
  );
};
