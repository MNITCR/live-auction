import { CategoryDropDown, Caption, Title } from "../../router";
import {
  commonClassNameOfInput,
  PrimaryButton,
} from "../../components/common/Design";
import { useEffect, useState } from "react";
import { toast } from "react-toastify";
import axios from "axios";
import { useNavigate, useParams } from "react-router-dom";

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

export const ViewProductByAdmin = () => {
  const navigate = useNavigate();
  const { id } = useParams();
  const [formData, setFormData] = useState(initialState);

  useEffect(() => {
    const getProduct = async () => {
      try {
        const { data } = await axios.get(
          `${process.env.REACT_APP_BASE_URL}/api/products/${id}`
        );
        setFormData(data);
      } catch (error) {
        toast.error(error.response.data.error || "Error get product");
      }
    };
    getProduct();
  }, [id]);

  const handleCategoryChange = (selectedOption) => {
    setFormData((prevData) => ({
      ...prevData,
      category: selectedOption,
    }));
  };


  const handleChange = (e) => {
    const { name, value, type } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: type === "file" ? e.target.files[0] : value,
    }));
  };

  const handleUpdateProduct = async (e) => {
    e.preventDefault();
    try {
      let imageUrl = formData.image;
      if (formData.image && formData.image instanceof File) {
        const form_image = new FormData();
        form_image.append("photo", formData.image);
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
        image: imageUrl ? imageUrl : formData.image,
        user_id: localStorage.getItem("user_id"),
        category: formData.category ? formData.category.label : null,
      };

      const { data: product } = await axios.put(
        `${process.env.REACT_APP_BASE_URL}/api/products/${id}`,
        submitData
      );

      toast.success(product.message);
      navigate(-1);
    } catch (error) {
      toast.error(error.response?.data?.error || "Error updating product");
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
          <form onSubmit={handleUpdateProduct} method="POST">
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
              <div>
                <img src={formData.image} alt={formData.title} width='200px'/>
              </div>
            </div>

            <PrimaryButton type="submit" className="rounded-none my-5">
              UPDATE
            </PrimaryButton>
          </form>
        </div>
      </section>
    </>
  );
};
