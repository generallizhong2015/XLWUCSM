using System.Collections;
using System.Collections.Generic;
using BLL.Common;
using IBLL;
using IDAL;
using Models;

namespace BLL
{
    class PwrBLL : FounDationBLL, IPwrBLL
    {
        IPwrDAL pwrDAL { set; get; }
        public PWR Select(string p_PWRID)
        {
            return pwrDAL.Select(p_PWRID);
        }

        public IList<PWR> Select(Hashtable h_pwr)
        {
            return pwrDAL.Select(h_pwr);
        }

        public void Insert(PWR p_pwr)
        {
            pwrDAL.Insert(p_pwr);
        }

        public void Update(PWR p_pwr)
        {
            pwrDAL.Update(p_pwr);
        }

        public void Delete(PWR p_pwr)
        {
            pwrDAL.Delete(p_pwr);
        }
    }
}