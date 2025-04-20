import { NavLink } from "react-router-dom";
import { Title, ProfileCard } from "../router";
import { TiEyeOutline } from "react-icons/ti";
import { User2 } from "../components/hero/Hero";
import { useEffect, useState } from "react";
import { toast } from "react-toastify";
import axios from "axios";

export const UserList = () => {
  const [formData, setFormData] = useState([]);
  const id = localStorage.getItem("user_id");
  useEffect(() => {
    const getUserInfo = async () => {
      try {
        const { data } = await axios.get(`${process.env.REACT_APP_BASE_URL}/api/users`);
        setFormData(data);
      } catch (error) {
        toast.error(error.response.data.error);
      }
    };
    getUserInfo();
  }, []);

  return (
    <section className="shadow-s1 p-8 rounded-lg">
      <div className="flex justify-between">
        <Title level={5} className=" font-normal">
          User Lists
        </Title>
      </div>
      <hr className="my-5" />
      <div className="relative overflow-x-auto rounded-lg">
        <table className="w-full text-sm text-left rtl:text-right text-gray-500">
          <thead className="text-xs text-gray-700 uppercase bg-gray-100">
            <tr>
              <th scope="col" className="px-6 py-5">
                S.N
              </th>
              <th scope="col" className="px-6 py-5">
                Username
              </th>
              <th scope="col" className="px-6 py-5">
                Email
              </th>
              <th scope="col" className="px-6 py-5">
                Role
              </th>
              <th scope="col" className="px-6 py-5">
                Photo
              </th>
              <th scope="col" className="px-6 py-3">
                Date
              </th>
              <th scope="col" className="px-6 py-3 flex justify-end">
                Action
              </th>
            </tr>
          </thead>
          <tbody>
            {formData.map((data, index) => (
              <tr key={index} className={`bg-white border-b hover:bg-gray-50 ${id == data.id ? 'hidden' : ''}`}>
                <td className="px-6 py-4">{index + 1}</td>
                <td className="px-6 py-4">{data.name}</td>
                <td className="px-6 py-4">{data.email}</td>
                <td className="px-6 py-4">{data.role}</td>
                <td className="px-6 py-4">
                  <ProfileCard>
                    <img className="rounded-full" src={data.photo} alt={User2} />
                  </ProfileCard>
                </td>
                <td className="px-6 py-4">{data.created_at}</td>
                <td className="py-4 flex justify-end px-8">
                  <NavLink
                    to={`../profile/${data.id}`}
                    type="button"
                    className="font-medium text-indigo-500"
                  >
                    <TiEyeOutline size={25} />
                  </NavLink>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </section>
  );
};
