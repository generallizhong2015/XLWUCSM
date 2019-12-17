using System.Collections;
using System.Collections.Generic;
using DAL.Common;
using IDAL;
using Models;

namespace DAL
{
    class ApprDAL : FounDationDAL, IApprDAL
    {
        public APPR Select(int p_apprid)
        {
            Hashtable h_appr = new Hashtable();
            h_appr["APPRID"] = p_apprid;
            return QueryForObject<APPR>("appr_map.appr_select", h_appr);
        }

        public IList<APPR> Select(Hashtable h_appr)
        {
            return QueryForList<APPR>("appr_map.appr_select", h_appr);
        }

        public void Insert(APPR p_appr)
        {
            ExecuteSQL("appr_map.appr_insert", p_appr);
        }

        public void Update(APPR p_appr)
        {
            ExecuteSQL("appr_map.appr_update", p_appr);
        }

        public void Delete(APPR p_appr)
        {
            ExecuteSQL("appr_map.appr_delete", p_appr);
        }
    }
}
