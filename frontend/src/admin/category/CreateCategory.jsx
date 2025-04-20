import { Caption, PrimaryButton, Title } from "../../router";
import { commonClassNameOfInput } from "../../components/common/Design";
import { toast } from "react-toastify";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import { useState } from "react";

export const CreateCategory = () => {
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    title: "",
    user_id: localStorage.getItem("user_id"),
  });
  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  const handleSubmit = async (e) =>{
    e.preventDefault();

    try {
      const {data} = await axios.post("http://localhost:8000/api/categories",
        formData
      );

      toast.success(data.message);
      navigate(-1)
    } catch (error) {
      toast.error(error.response.data.error);
    }
  }
  return (
    <>
      <section className="bg-white shadow-s1 p-8 rounded-xl">
        <Title level={5} className=" font-normal mb-5">
          Create Category
        </Title>
        <form method="POST" onSubmit={handleSubmit}>
          <div className="w-full my-8">
            <Caption className="mb-2">Title *</Caption>
            <input
              type="text"
              className={`${commonClassNameOfInput}`}
              placeholder="Title"
              onChange={handleChange}
              name="title"
              value={formData.title || ""}
              required
            />
          </div>

          <PrimaryButton type="submit" className="rounded-none my-5">
            CREATE
          </PrimaryButton>
        </form>
      </section>
    </>
  );
};
