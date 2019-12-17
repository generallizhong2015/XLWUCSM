using System.Collections;
using System.Collections.Generic;
using BLL.Common;
using IBLL;
using IDAL;
using Models;

namespace BLL
{
    class ApprBLL : FounDationBLL, IApprBLL
    {
        IApprDAL ApprDAL { get; set; }

        public APPR Select(int p_apprid)
        {
            return ApprDAL.Select(p_apprid);
        }

        public IList<APPR> Select(Hashtable h_appr)
        {
            return ApprDAL.Select(h_appr);
        }

        public void Insert(APPR p_appr)
        {
            ApprDAL.Insert(p_appr);
        }

        public void Update(APPR p_appr)
        {
            ApprDAL.Update(p_appr);
        }

        public void Delete(APPR p_appr)
        {
            ApprDAL.Delete(p_appr);
        }
    }
}
