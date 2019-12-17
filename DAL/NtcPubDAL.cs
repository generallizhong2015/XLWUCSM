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
    class NtcPubDAL : FounDationDAL, INtcPubDAL
    {
        public Models.NTCPUB Select(string p_ntcpubno)
        {
            Hashtable h_ntcpub = new Hashtable();
            h_ntcpub["NTCPUBNO"] = p_ntcpubno;
            return QueryForObject<NTCPUB>("NTCPUB_MAP.NTCPUB_SELECT", h_ntcpub);
        }

        public IList<Models.NTCPUB> Select(System.Collections.Hashtable h_ntcpub)
        {
            return QueryForList<NTCPUB>("NTCPUB_MAP.NTCPUB_SELECT", h_ntcpub);
        }

        public int Select_RecordCount(System.Collections.Hashtable h_ntcpub)
        {
            return int.Parse(QueryForObject("NTCPUB_MAP.NTCPUB_SELECT_RECORDCOUNT", h_ntcpub).ToString());
        }

        public void Insert(Models.NTCPUB p_ntcpub)
        {
            ExecuteSQL("NTCPUB_MAP.NTCPUB_INSERT", p_ntcpub);
        }

        public void Update(Models.NTCPUB p_ntcpub)
        {
            ExecuteSQL("NTCPUB_MAP.NTCPUB_UPDATE", p_ntcpub);
        }

        public void Delete(Models.NTCPUB p_ntcpub)
        {
            ExecuteSQL("NTCPUB_MAP.NTCPUB_DELETE", p_ntcpub);
        }

        public string GetMaxPubNo()
        {
            object obj = QueryForObject("NTCPUB_MAP.NTCPUB_SELECTPUBNO", null);
            if (obj == null) return "";
            else return obj.ToString();
        }
    }
}
