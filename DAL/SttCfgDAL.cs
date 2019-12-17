using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DAL.Common;
using IDAL;
using System.Collections;
using Models;

namespace DAL
{
    class SttCfgDAL : FounDationDAL, ISttCfgDAL
    {
        public Models.STTCFG Select(string p_nodtyp, string p_noddtstt)
        {
            Hashtable h_sttcfg = new Hashtable();
            h_sttcfg["NODTYP"] = p_nodtyp;
            h_sttcfg["NODDTSTT"] = p_noddtstt;
            return QueryForObject<STTCFG>("STTCFG_MAP.STTCFG_SELECT", h_sttcfg);
        }

        public IList<Models.STTCFG> Select(System.Collections.Hashtable h_sttcfg)
        {
            return QueryForList<STTCFG>("STTCFG_MAP.STTCFG_SELECT", h_sttcfg);
        }

        public void Insert(Models.STTCFG p_sttcfg)
        {
            ExecuteSQL("STTCFG_MAP.STTCFG_INSERT", p_sttcfg);
        }

        public void Update(Models.STTCFG p_sttcfg)
        {
            ExecuteSQL("STTCFG_MAP.STTCFG_UPDATE", p_sttcfg);
        }

        public void Delete(Models.STTCFG p_sttcfg)
        {
            ExecuteSQL("STTCFG_MAP.STTCFG_DELETE", p_sttcfg);
        }
    }
}
