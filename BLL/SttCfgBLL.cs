using System.Collections;
using System.Collections.Generic;
using BLL.Common;
using IBLL;
using IDAL;
using Models;

namespace BLL
{
    class SttCfgBLL : FounDationBLL, ISttCfgBLL
    {
        ISttCfgDAL SttCfgDAL { get; set; }

        public STTCFG Select(string p_nodtyp, string p_noddtstt)
        {
            return SttCfgDAL.Select(p_nodtyp, p_noddtstt);
        }

        public IList<STTCFG> Select(Hashtable h_sttcfg)
        {
            return SttCfgDAL.Select(h_sttcfg);
        }

        public void Insert(STTCFG p_sttcfg)
        {
            SttCfgDAL.Insert(p_sttcfg);
        }

        public void Update(STTCFG p_sttcfg)
        {
            SttCfgDAL.Update(p_sttcfg);
        }

        public void Delete(STTCFG p_sttcfg)
        {
            SttCfgDAL.Delete(p_sttcfg);
        }
    }
}
