import axios from "axios";
import { useEffect, useState } from "react";
import Select from "react-select";
import { toast } from "react-toastify";

export const CategoryDropDown = ({ selectedCategory, onCategoryChange }) => {
  const [categories, setCategories] = useState([]);
  useEffect(() => {
    const getCategory = async () => {
      axios
        .get(`${process.env.REACT_APP_BASE_URL}/api/categories`)
        .then((res) => {
          const options = res.data.map((category) => ({
            label: category.category_title,
            value: category.id,
          }));
          setCategories(options);
        })
        .catch((error) => {
          toast.error(error);
        });
    };

    getCategory();
  }, []);

  useEffect(() => {
    if (selectedCategory) {
      const selectedCategoryObj = categories.find(
        (category) => category.label === selectedCategory
      );
      if (selectedCategoryObj) {
        onCategoryChange(selectedCategoryObj);
      }
    }
  }, [selectedCategory, categories, onCategoryChange]);

  return (
    <>
      <Select
        options={categories}
        value={selectedCategory}
        onChange={onCategoryChange}
        id="category"
      />
    </>
  );
};
