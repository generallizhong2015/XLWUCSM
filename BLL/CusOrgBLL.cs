using System.Collections;
using System.Collections.Generic;
using BLL.Common;
using IBLL;
using IDAL;
using Models;
using System;


namespace BLL
{
    class CusOrgBLL : FounDationBLL, ICusOrgBLL
    {
        ICusOrgDAL CusOrgDAL { set; get; }
        public CUSORG Select(string p_cusid, string p_cusorgid)
        {
            return CusOrgDAL.Select(p_cusid, p_cusorgid);
        }

        public IList<CUSORG> Select(Hashtable h_cusorg)
        {
            return CusOrgDAL.Select(h_cusorg);
        }

        public void Insert(CUSORG p_cusorg)
        {
            CusOrgDAL.Insert(p_cusorg);
        }

        public void Update(CUSORG p_cusorg)
        {
            CusOrgDAL.Update(p_cusorg);
        }

        public void Delete(CUSORG p_cusorg)
        {
            CusOrgDAL.Delete(p_cusorg);
        }

        public string GetMaxCusOrgId(string p_cusid)
        {
            string MaxId = CusOrgDAL.GetMaxCusOrgId(p_cusid);
            int iCurId = 0;
            if (String.IsNullOrEmpty(MaxId)) iCurId = 0;
            else iCurId = int.Parse(MaxId);
            return (++iCurId).ToString();
        }
    }
}
