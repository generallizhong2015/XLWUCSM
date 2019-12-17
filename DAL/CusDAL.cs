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
    class CusDAL : FounDationDAL, ICusDAL
    {
        public Models.CUS Select(string p_cusid)
        {
            Hashtable h_cus = new Hashtable();
            h_cus["CUSID"] = p_cusid;
            return QueryForObject<CUS>("CUS_MAP.CUS_SELECT", h_cus);
        }

        public IList<Models.CUS> Select(System.Collections.Hashtable h_cus)
        {
            return QueryForList<CUS>("CUS_MAP.CUS_SELECT", h_cus);
        }

        public int Select_RecordCount(Hashtable h_cus)
        {
            return int.Parse(QueryForObject("CUS_MAP.CUS_SELECT_RECORDCOUNT", h_cus).ToString());
        }

        public void Insert(Models.CUS p_cus)
        {
            ExecuteSQL("CUS_MAP.CUS_INSERT", p_cus);
        }

        public void Update(Models.CUS p_cus)
        {
            ExecuteSQL("CUS_MAP.CUS_UPDATE", p_cus);
        }

        public void Delete(Models.CUS p_cus)
        {
            ExecuteSQL("CUS_MAP.CUS_DELETE", p_cus);
        }

        public string GetMaxCusId()
        {
            object obj = QueryForObject("CUS_MAP.CUS_SELECTCUSID", "^[0-9]*$");
            if (obj == null) return "";
            else return obj.ToString();
        }

        public string GetMaxCusIdByPrefix(string prefix)
        {
            object obj = QueryForObject("CUS_MAP.CUS_SELECTCUSIDBYPREFIT", prefix);
            if (obj == null) return "";
            else return obj.ToString();
        }
    }
}
