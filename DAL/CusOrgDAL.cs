using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IDAL;
using DAL.Common;
using System.Collections;
using Models;

namespace DAL
{
    class CusOrgDAL : FounDationDAL, ICusOrgDAL
    {

        public Models.CUSORG Select(string p_cusid, string p_cusorgid)
        {
            Hashtable h_cusorg = new Hashtable();
            h_cusorg["CUSID"] = p_cusid;
            h_cusorg["CUSORGID"] = p_cusorgid;
            return QueryForObject<CUSORG>("CUSORG_MAP.CUSORG_SELECT", h_cusorg);
        }

        public IList<Models.CUSORG> Select(System.Collections.Hashtable h_cusorg)
        {
            return QueryForList<CUSORG>("CUSORG_MAP.CUSORG_SELECT", h_cusorg);
        }

        public void Insert(Models.CUSORG p_cusorg)
        {
            ExecuteSQL("CUSORG_MAP.CUSORG_INSERT", p_cusorg);
        }

        public void Update(Models.CUSORG p_cusorg)
        {
            ExecuteSQL("CUSORG_MAP.CUSORG_UPDATE", p_cusorg);
        }

        public void Delete(Models.CUSORG p_cusorg)
        {
            ExecuteSQL("CUSORG_MAP.CUSORG_DELETE", p_cusorg);
        }

        public string GetMaxCusOrgId(string p_cusid)
        {
            Hashtable h_cusorg = new Hashtable();
            h_cusorg["CUSID"] = p_cusid;
            object obj = QueryForObject("CUSORG_MAP.CUSORG_SELECTCUSORGID", h_cusorg);
            if (obj == null) return "";
            else return obj.ToString();
        }
    }
}
