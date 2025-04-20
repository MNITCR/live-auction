import { CategoryDropDown, Caption, PrimaryButton, Title } from "../../router";
import { commonClassNameOfInput } from "../../components/common/Design";
import { useState } from "react";
import axios from "axios";
import { toast } from "react-toastify";
import { useNavigate } from "react-router-dom";

// Initial state of the form
const initialState = {
  user_id: "",
  title: "",
  description: "",
  price: 0,
  height: 0,
  lengthpic: 0,
  width: 0,
  mediumused: "",
  weight: 0,
  category: null,
  image: null,
};

export const AddProduct = () => {
  const [formData, setFormData] = useState(initialState);
  const navigator = useNavigate();
  const handleChange = (e) => {
    const { name, value, type } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: type === "file" ? e.target.files[0] : value,
    }));
  };

  const handleCategoryChange = (selectedOption) => {
    setFormData((prevData) => ({
      ...prevData,
      category: selectedOption,
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      let imageUrl = formData.image;
      const form_image = new FormData();
      form_image.append("photo", formData.image);
      if (formData.image && formData.image instanceof File) {
        const { data } = await axios.post(
          `${process.env.REACT_APP_BASE_URL}/api/users/upload`,
          form_image,
          {
            headers: {
              "Content-Type": "multipart/form-data",
            },
          }
        );
        imageUrl = data.url;
      }

      const submitData = {
        ...formData,
        image: imageUrl,
        user_id: localStorage.getItem("user_id"),
        category: formData.category ? formData.category.value : null,
      };

      await axios.post(`${process.env.REACT_APP_BASE_URL}/api/products`, submitData);
      toast.success("Product created successfully!");
      setFormData(initialState);
      navigator(-1);
    } catch (error) {
      toast.error(error.response?.data?.message || 'Error Create Product');
    }
  };

  return (
    <section className="bg-white shadow-s1 p-8 rounded-xl">
      <Title level={5} className="font-normal mb-5">
        Create Product
      </Title>
      <hr className="my-5" />
      <form onSubmit={handleSubmit}>
        <div className="w-full">
          <Caption className="mb-2">Title *</Caption>
          <input
            type="text"
            name="title"
            className={`${commonClassNameOfInput}`}
            placeholder="Title"
            value={formData.title}
            onChange={handleChange}
            required
          />
        </div>

        <div className="py-5">
          <Caption className="mb-2">Category *</Caption>
          <CategoryDropDown
            className={`${commonClassNameOfInput}`}
            selectedCategory={formData.category}
            onCategoryChange={handleCategoryChange}
          />
        </div>

        <div className="flex items-center gap-5 my-4">
          <div className="w-1/2">
            <Caption className="mb-2">Height (cm)</Caption>
            <input
              type="number"
              name="height"
              placeholder="height"
              className={`${commonClassNameOfInput}`}
              value={formData.height}
              onChange={handleChange}
            />
          </div>
          <div className="w-1/2">
            <Caption className="mb-2">Length (cm)</Caption>
            <input
              type="number"
              name="lengthpic"
              placeholder="Length"
              className={`${commonClassNameOfInput}`}
              value={formData.lengthpic}
              onChange={handleChange}
            />
          </div>
        </div>

        <div className="flex items-center gap-5 my-4">
          <div className="w-1/2">
            <Caption className="mb-2">Width (cm)</Caption>
            <input
              type="number"
              name="width"
              placeholder="width"
              className={`${commonClassNameOfInput}`}
              value={formData.width}
              onChange={handleChange}
            />
          </div>
          <div className="w-1/2">
            <Caption className="mb-2">
              Medium used{" "}
              <span className="text-purple-400 italic">
                (Typically, pencil, ink, charcoal or other)
              </span>
            </Caption>
            <input
              type="text"
              name="mediumused"
              placeholder="Medium used"
              className={commonClassNameOfInput}
              value={formData.mediumused}
              onChange={handleChange}
            />
          </div>
        </div>

        <div className="flex items-center gap-5 mt-4">
          <div className="w-1/2">
            <Caption className="mb-2">
              Weight of piece{" "}
              <span className="text-purple-400 italic">(kg)</span>
            </Caption>
            <input
              type="number"
              name="weight"
              placeholder="weight"
              className={`${commonClassNameOfInput}`}
              value={formData.weight}
              onChange={handleChange}
            />
          </div>
          <div className="w-1/2">
            <Caption className="mb-2">Price Range*</Caption>
            <input
              type="number"
              name="price"
              className={`${commonClassNameOfInput}`}
              placeholder="Price"
              value={formData.price}
              onChange={handleChange}
              required
            />
          </div>
        </div>

        <div>
          <Caption className="mb-2">Description *</Caption>
          <textarea
            name="description"
            className={`${commonClassNameOfInput}`}
            cols="30"
            rows="5"
            value={formData.description}
            onChange={handleChange}
          ></textarea>
        </div>

        <div>
          <Caption className="mb-2">Image</Caption>
          <input
            type="file"
            className={`${commonClassNameOfInput}`}
            name="image"
            onChange={handleChange}
          />
        </div>

        <PrimaryButton type="submit" className="rounded-none my-5">
          CREATE
        </PrimaryButton>
      </form>
    </section>
  );
};
