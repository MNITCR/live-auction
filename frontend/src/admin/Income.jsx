import axios from "axios";
import { Title } from "../router";
import { CgDollar } from "react-icons/cg";
import { useEffect, useState } from "react";
import { toast } from "react-toastify";

export const Income = () => {
  const[commissions, setCommission] = useState();

  useEffect(() => {
    const getCommissionByAdmin = async () => {
      try {
        const { data } = await axios.get(
          `${process.env.REACT_APP_BASE_URL}/api/sum_commission_by_admin`
        );
        setCommission(data.commissions);
        console.log(data.commissions)
      } catch (error) {
        toast.error(error.response.data.error);
      }
    };
    getCommissionByAdmin();
  }, []);

  return (
    <>
      <section>
        <div className="shadow-s1 p-8 rounded-lg  mb-12">
          <Title level={5} className=" font-normal">
            Commission Income
          </Title>

          <div className="shadow-s3 py-16 my-16 border border-green bg-green_100 p-8 flex items-center text-center justify-center gap-5 flex-col rounded-xl">
            <CgDollar size={80} className="text-green" />
            <div>
              <Title level={1}>{commissions}</Title>
              <Title>Total Income</Title>
            </div>
          </div>
        </div>
      </section>
    </>
  );
};
