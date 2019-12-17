using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BLL.Common;
using IBLL;
using IDAL;
using System.Collections;

namespace BLL
{
    class NtcPubBLL : FounDationBLL, INtcPubBLL
    {
        INtcPubDAL NtcPubDAL { get; set; }

        public string GetMaxPubNo()
        {
            string MaxNo = NtcPubDAL.GetMaxPubNo();
            int iCurId = 0;
            if (String.IsNullOrEmpty(MaxNo)) iCurId = 0;
            else
                iCurId = int.Parse(MaxNo.Substring(6, 4));
            string NtcPubNo = DateTime.Now.ToString("yyMMdd") + (++iCurId).ToString().PadLeft(4, '0');

            return NtcPubNo;
        }

        public Models.NTCPUB Select(string p_ntcpubno)
        {
            return NtcPubDAL.Select(p_ntcpubno);
        }

        public IList<Models.NTCPUB> Select(System.Collections.Hashtable h_ntcpub)
        {
            return NtcPubDAL.Select(h_ntcpub);
        }

        public int Select_RecordCount(System.Collections.Hashtable h_ntcpub)
        {
            return NtcPubDAL.Select_RecordCount(h_ntcpub);
        }

        public void Insert(Models.NTCPUB p_ntcpub)
        {
            NtcPubDAL.Insert(p_ntcpub);
        }

        public void Update(Models.NTCPUB p_ntcpub)
        {
            NtcPubDAL.Update(p_ntcpub);
        }

        public void Delete(Models.NTCPUB p_ntcpub)
        {
            NtcPubDAL.Delete(p_ntcpub);
        }

        public void Delete(IList<Models.NTCPUB> p_ntcpubs)
        {
            foreach (Models.NTCPUB NtcPub in p_ntcpubs)
            {
                NtcPubDAL.Delete(NtcPub);
            }
        }

        public void PubSvc(IList<Models.NTCPUB> p_ntcpubs)
        {
            foreach (Models.NTCPUB NtcPub in p_ntcpubs)
            {
                NtcPub.STT = 90;
                NtcPubDAL.Update(NtcPub);
            }
        }

        public void RspSvc(IList<Models.NTCPUB> p_ntcpubs)
        {
            foreach (Models.NTCPUB NtcPub in p_ntcpubs)
            {
                NtcPub.ISVLD = "F";
                NtcPubDAL.Update(NtcPub);
            }
        }

        public IList<Models.NTCPUB> GetSrollNtcPub(string p_cusid)
        {
            Hashtable ht = new Hashtable();
            ht["STT"] = "90";
            ht["ISVLD"] = "T";
            ht["BEGIN"] = 0;
            ht["PAGESIZE"] = 5;
            ht["SORDFIELD"] = "PUBDT";
            ht["SORTORDER"] = "DESC";
            ht["SPUBDT"] = DateTime.Now.Date;
            ht["CUSID"] = p_cusid;
            return NtcPubDAL.Select(ht);
        }
    }
}
