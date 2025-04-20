import React, { useEffect, useState } from "react";
import { Caption, Title } from "../../router";
import {
  commonClassNameOfInput,
  PrimaryButton,
} from "../../components/common/Design";
import axios from "axios";
import { toast } from "react-toastify";
import { useParams } from "react-router-dom";

export const UserProfile = () => {
  const { id } = useParams();
  const user_id = id ? id : localStorage.getItem("user_id");
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    contact_number: "",
    role: "",
    profile_picture: "",
    agreeToTerms: false,
  });

  const handleChange = (e) => {
    const { name, value, type } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: type === "file" ? e.target.files[0] : value,
    }));
  };

  useEffect(() => {
    if (user_id) {
      const fetchUserData = async () => {
        try {
          const { data } = await axios.get(
            `${process.env.REACT_APP_BASE_URL}/api/users/${user_id}`
          );
          setFormData({
            name: data.name || "",
            email: data.email || "",
            contact_number: data.contact_number || "",
            role: data.role || "",
            profile_picture: data.photo || "",
            agreeToTerms: data.agreeToTerms || false,
          });
        } catch (error) {
          toast.error(
            error.response?.data?.error || "Error fetching user data"
          );
        }
      };
      fetchUserData();
    }
  }, [user_id]);

  const updateProfileHandler = async (e) => {
    e.preventDefault();
    const form_image = new FormData();
    form_image.append("photo", formData.profile_picture);
    try {
      const { data } = await axios.post(
        `${process.env.REACT_APP_BASE_URL}/api/users/upload`,
        form_image,
        {
          headers: {
            "Content-Type": "multipart/form-data",
          },
        }
      );
      const response = await axios.put(
        `${process.env.REACT_APP_BASE_URL}/api/users/${user_id}`,
        {
          name: formData.name,
          email: formData.email,
          contact_number: formData.contact_number,
          photo: data.url,
        },
        {
          headers: {
            "Content-Type": "application/json",
          },
        }
      );
      toast.success(response.data.message);
      setTimeout(() => {
        window.location.reload();
      }, 1000);
    } catch (error) {
      toast.error(error.response?.data?.error || "Error updating profile");
    }
  };
  return (
    <>
      <section className="shadow-s1 p-8 rounded-lg">
        <div className="profile flex items-center gap-8">
          <img
            src={formData.profile_picture || ""}
            alt="User Profile"
            className="w-24 h-24 rounded-full object-cover"
          />
          <div>
            <Title level={5} className="capitalize">
              {formData.name || ""}
            </Title>
            <Caption>{formData.email || ""}</Caption>
          </div>
        </div>
        <form method="POST" onSubmit={updateProfileHandler}>
          <div className="flex items-center gap-5 mt-10">
            <div className="w-full">
              <Caption className="mb-2">Full Name</Caption>
              <input
                type="text"
                className={`capitalize ${commonClassNameOfInput}`}
                placeholder="Sunil"
                name="name"
                onChange={handleChange}
                value={formData.name || ""}
              />
            </div>
          </div>
          <div className="flex items-center gap-5 mt-10">
            <div className="w-1/2">
              <Caption className="mb-2">Contact Number</Caption>
              <input
                type="text"
                className={commonClassNameOfInput}
                placeholder="Contact Number"
                name="contact_number"
                onChange={handleChange}
                value={formData.contact_number || ""}
              />
            </div>
            <div className="w-1/2">
              <Caption className="mb-2">Email</Caption>
              <input
                type="email"
                className={commonClassNameOfInput}
                placeholder="example@gmail.com"
                name="email"
                onChange={handleChange}
                value={formData.email || ""}
              />
            </div>
          </div>
          <div className="my-8">
            <Caption className="mb-2">Role</Caption>
            <input
              type="text"
              className={commonClassNameOfInput}
              placeholder="admin"
              name="role"
              onChange={handleChange}
              value={formData.role || ""}
              disabled
            />
          </div>
          <div className="my-8">
            <Caption className="mb-2">Profile Picture</Caption>
            <input
              type="file"
              className={commonClassNameOfInput}
              placeholder="Profile Picture"
              name="profile_picture"
              onChange={handleChange}
            />
          </div>
          <PrimaryButton>Update Profile</PrimaryButton>
        </form>
      </section>
    </>
  );
};
