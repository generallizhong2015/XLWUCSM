using System.Collections;
using System.Collections.Generic;
using DAL.Common;
using IDAL;
using Models;
using System;

namespace DAL
{
    class SordDAL : FounDationDAL, ISordDAL
    {
        public SORD Select(string p_ordno)
        {
            Hashtable h_sord = new Hashtable();
            h_sord["ORDNO"] = p_ordno;
            return QueryForObject<SORD>("sord_map.sord_select", h_sord);
        }

        public IList<SORD> Select(Hashtable h_sord)
        {
            return QueryForList<SORD>("sord_map.sord_select", h_sord);
        }

        public int SelectCount(Hashtable h_sord)
        {
            return int.Parse(QueryForObject("sord_map.sord_selectcount", h_sord).ToString());
        }

        public void Insert(SORD p_sord)
        {
            ExecuteSQL("sord_map.sord_insert", p_sord);
        }

        public void Update(SORD p_sord)
        {
            ExecuteSQL("sord_map.sord_update", p_sord);
        }
        public void UpdateSord(SORD p_sord)
        {
            ExecuteSQL("sord_map.sord_updateSord", p_sord);
        }

        public void Delete(SORD p_sord)
        {
            ExecuteSQL("sord_map.sord_delete", p_sord);
        }

        public string GetCurNo()
        {
            string date = DateTime.Now.ToString("yyMMdd");
            string s_maxno = Convert.ToString(QueryForObject("sord_map.sord_selectmaxno", date));
            if (string.IsNullOrEmpty(s_maxno)) return date + "0001";
            else return date + Convert.ToString(int.Parse(s_maxno.Substring(6)) + 1).PadLeft(4, '0');
        }        
    }
}
