using System.Collections;
using System.Collections.Generic;
using DAL.Common;
using IDAL;
using Models;

namespace DAL
{
    class PwrDAL : FounDationDAL, IPwrDAL
    {
        public PWR Select(string p_PWRID)
        {
            Hashtable h_pwr = new Hashtable();
            h_pwr["PWRID"] = p_PWRID;
            return QueryForObject<PWR>("pwr_map.pwr_select", h_pwr);
        }

        public IList<PWR> Select(Hashtable h_pwr)
        {
            return QueryForList<PWR>("pwr_map.pwr_select", h_pwr);
        }

        public void Insert(PWR p_pwr)
        {
            ExecuteSQL("pwr_map.pwr_insert", p_pwr);
        }

        public void Update(PWR p_pwr)
        {
            ExecuteSQL("pwr_map.pwr_update", p_pwr);
        }

        public void Delete(PWR p_pwr)
        {
            ExecuteSQL("pwr_map.pwr_delete", p_pwr);
        }
    }
}