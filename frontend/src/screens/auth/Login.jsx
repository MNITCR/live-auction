import { FaFacebook, FaGoogle } from "react-icons/fa";
import {
  Caption,
  Container,
  CustomNavLink,
  PrimaryButton,
  Title,
} from "../../router";
import { commonClassNameOfInput } from "../../components/common/Design";
import { useNavigate } from "react-router-dom";
import { toast } from "react-toastify";
import { useState } from "react";
import axios from "axios";

export const Login = () => {
  const [formData, setFormData] = useState({
    email: "",
    password: "",
    agreeToTerms: false,
  });
  const navigate = useNavigate();
  const handleChange = (e) => {
    const { name, value, type, checked } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: type === "checkbox" ? checked : value,
    }));
  };

  const registerLogin = async (e) => {
    e.preventDefault();

    if (!formData.agreeToTerms) {
      toast.error("You must agree to the terms and policy");
      return;
    }

    try {
      const { data } = await axios.post("http://localhost:8000/api/login", {
        email: formData.email,
        password: formData.password,
      });
      localStorage.setItem("role", data.user.role);
      localStorage.setItem("user_id", data.user.id);
      toast.success(data.message);
      navigate("/");
    } catch (error) {
      toast.error(error.response.data.error);
    }
  };
  return (
    <>
      <section className="regsiter pt-16 relative">
        <div className="bg-green w-96 h-96 rounded-full opacity-20 blur-3xl absolute top-2/3"></div>
        <div className="bg-[#241C37] pt-8 h-[40vh] relative content">
          <Container>
            <div>
              <Title level={3} className="text-white">
                Log In
              </Title>
              <div className="flex items-center gap-3">
                <Title level={5} className="text-green font-normal text-xl">
                  Home
                </Title>
                <Title level={5} className="text-white font-normal text-xl">
                  /
                </Title>
                <Title level={5} className="text-white font-normal text-xl">
                  Log In
                </Title>
              </div>
            </div>
          </Container>
        </div>
        <form
          method="POST"
          className="bg-white shadow-s3 w-1/3 m-auto my-16 p-8 rounded-xl"
          onSubmit={registerLogin}
        >
          <div className="text-center">
            <Title level={5}>New Member</Title>
            <p className="mt-2 text-lg">
              Do you already have an account?{" "}
              <CustomNavLink href="/register" className="text-green">
                Signup Here
              </CustomNavLink>
            </p>
          </div>

          <div className="py-5 mt-8">
            <Caption className="mb-2">Enter Your Email *</Caption>
            <input
              type="email"
              name="email"
              className={commonClassNameOfInput}
              placeholder="Enter Your Email"
              value={formData.email}
              onChange={handleChange}
              required
            />
          </div>
          <div>
            <Caption className="mb-2">Password *</Caption>
            <input
              type="password"
              name="password"
              className={commonClassNameOfInput}
              placeholder="Enter Your Password"
              value={formData.password}
              onChange={handleChange}
              required
            />
          </div>
          <div className="flex items-center gap-2 py-4">
            <input
              type="checkbox"
              name="agreeToTerms"
              checked={formData.agreeToTerms}
              onChange={handleChange}
            />
            <Caption>I agree to the Terms & Policy</Caption>
          </div>
          <PrimaryButton className="w-full rounded-none my-5">
            LOGIN
          </PrimaryButton>
          <div className="text-center border py-4 rounded-lg mt-4">
            <Title>OR SIGNIN WITH</Title>
            <div className="flex items-center justify-center gap-5 mt-5">
              <button className="flex items-center gap-2 bg-red-500 text-white p-3 px-5 rounded-sm">
                <FaGoogle />
                <p className="text-sm">SIGNIN WHIT GOOGLE</p>
              </button>
              <button className="flex items-center gap-2 bg-indigo-500 text-white p-3 px-5 rounded-sm">
                <FaFacebook />
                <p className="text-sm">SIGNIN WHIT FACEBOOK</p>
              </button>
            </div>
          </div>
          <p className="text-center mt-5">
            By clicking the signup button, you create a Cobiro account, and you
            agree to Cobiros{" "}
            <span className="text-green underline">Terms & Conditions</span> &
            <span className="text-green underline"> Privacy Policy </span> .
          </p>
        </form>
        <div className="bg-green w-96 h-96 rounded-full opacity-20 blur-3xl absolute bottom-96 right-0"></div>
      </section>
    </>
  );
};
