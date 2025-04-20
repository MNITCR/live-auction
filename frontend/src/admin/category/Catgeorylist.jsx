import { AiOutlinePlus } from "react-icons/ai";
import { NavLink } from "react-router-dom";
import { Title, PrimaryButton } from "../../router";
import { CiEdit } from "react-icons/ci";
import { MdOutlineDeleteOutline } from "react-icons/md";
import { toast } from "react-toastify";
import axios from "axios";
import { useEffect, useState } from "react";

export const CategoryList = () => {
  const [formData, setFormData] = useState([]);
  const getCategory = async () => {
    try {
      const { data } = await axios.get("http://localhost:8000/api/categories");
      setFormData(data);
    } catch (error) {
      toast.error(error.response.data.error);
    }
  };
  useEffect(() => {
    getCategory();
  }, []);

  const handleDeleteCategory = async (e, category_id) => {
    e.preventDefault();
    if (window.confirm("Do you want to delete this category?")) {
      try {
        const { data, status } = await axios.delete(
          `${process.env.REACT_APP_BASE_URL}/api/categories/${category_id}`
        );
        if (status === 204) {
          toast.success(data.message);
          getCategory();
        }
      } catch (error) {
        toast.error(error.response?.data?.error);
      }
    }
  };

  return (
    <>
      <section className="shadow-s1 p-8 rounded-lg">
        <div className="flex justify-between">
          <Title level={5} className=" font-normal">
            Category Lists
          </Title>
          <NavLink to="/category/create">
            <PrimaryButton className="flex items-center gap-3 px-5 py-2 text-sm rounded-md transition-transform hover:scale-105">
              <AiOutlinePlus size={20} />
              <span>Create Category</span>
            </PrimaryButton>
          </NavLink>
        </div>
        <hr className="my-5" />
        <div className="relative overflow-x-auto rounded-lg">
          <table className="w-full text-sm text-left rtl:text-right text-gray-500">
            <thead className="text-xs text-gray-700 uppercase bg-gray-100">
              <tr>
                <th scope="col" className="px-6 py-5">
                  S.N
                </th>
                {/* <th scope="col" className="px-6 py-5">
                  User
                </th> */}
                <th scope="col" className="px-6 py-5">
                  Title
                </th>
                <th scope="col" className="px-6 py-5">
                  Date
                </th>
                <th scope="col" className="px-6 py-5">
                  Action
                </th>
              </tr>
            </thead>
            <tbody>
              {formData.map((data, index) => (
                <tr
                  key={index + 1}
                  className="bg-white border-b hover:bg-gray-50"
                >
                  <td className="px-6 py-3">{index + 1}</td>
                  {/* <td className="px-6 py-4">
                    <div className="flex items-center px-6 text-gray-900 whitespace-nowrap">
                      <div>
                        <ProfileCard>
                          <img className="rounded-full" src={data.photo} alt="" />
                        </ProfileCard>
                      </div>
                      <div className="pl-3">
                        <div className="text-base font-semibold capitalize">
                          {" "}
                          {data.email}
                        </div>
                        <div className="font-normal text-gray-500">
                          {" "}
                          {data.user_name}
                        </div>
                      </div>
                    </div>
                  </td> */}
                  <td className="px-6 py-4">{data.category_title}</td>
                  <td className="px-6 py-4">{data.date}</td>

                  <td className="px-6 py-4 text-end flex items-center gap-3 mt-1">
                    {/* <NavLink
                      to="#"
                      type="button"
                      className="font-medium text-indigo-500"
                    >
                      <TiEyeOutline size={25} />
                    </NavLink> */}
                    <NavLink
                      to={`/category/update/${data.id}`}
                      className="font-medium text-green"
                    >
                      <CiEdit size={25} />
                    </NavLink>
                    <button
                      className="font-medium text-red-500"
                      onClick={(e) => handleDeleteCategory(e, data.id)}
                    >
                      <MdOutlineDeleteOutline size={25} />
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </section>
    </>
  );
};
