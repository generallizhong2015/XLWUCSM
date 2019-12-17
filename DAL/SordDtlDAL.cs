using System.Collections;
using System.Collections.Generic;
using DAL.Common;
using IDAL;
using Models;
using System;

namespace DAL
{
    class SordDtlDAL : FounDationDAL, ISordDtlDAL
    {
        public SORDDTL Select(string p_ordno, int p_rcdidx)
        {
            Hashtable h_sorddtl = new Hashtable();
            h_sorddtl["ORDNO"] = p_ordno;
            h_sorddtl["RCDIDX"] = p_rcdidx;
            return QueryForObject<SORDDTL>("sorddtl_map.sorddtl_select", h_sorddtl);
        }

        public IList<SORDDTL> Select(Hashtable h_sorddtl)
        {
            return QueryForList<SORDDTL>("sorddtl_map.sorddtl_select", h_sorddtl);
        }

        public void Insert(SORDDTL p_sorddtl)
        {
            ExecuteSQL("sorddtl_map.sorddtl_insert", p_sorddtl);
        }

        public void Update(SORDDTL p_sorddtl)
        {
            ExecuteSQL("sorddtl_map.sorddtl_update", p_sorddtl);
        }

        public void Delete(SORDDTL p_sorddtl)
        {
            ExecuteSQL("sorddtl_map.sorddtl_delete", p_sorddtl);
        }

        public int GetCurRcdidx(string p_ordno)
        {
            string s_maxrcdidx = Convert.ToString(QueryForObject("sorddtl_map.sorddtl_selectmaxrcdidx", p_ordno));
            if (string.IsNullOrEmpty(s_maxrcdidx)) return 1;
            else return int.Parse(s_maxrcdidx) + 1;
        }
    }
}
