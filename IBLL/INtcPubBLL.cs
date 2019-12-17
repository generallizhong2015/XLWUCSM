using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBLL.Common;
using Models;
using System.Collections;

namespace IBLL
{
    public interface INtcPubBLL : IFounDationBLL
    {
        string GetMaxPubNo();
        NTCPUB Select(string p_ntcpubno);
        IList<NTCPUB> Select(Hashtable h_ntcpub);
        IList<NTCPUB> GetSrollNtcPub(string p_cusid);
        int Select_RecordCount(Hashtable h_ntcpub);
        void Insert(NTCPUB p_ntcpub);
        void Update(NTCPUB p_ntcpub);
        void Delete(NTCPUB p_ntcpub);
        void Delete(IList<NTCPUB> p_ntcpubs);
        void PubSvc(IList<NTCPUB> p_ntcpubs);
        void RspSvc(IList<NTCPUB> p_ntcpubs);

       
    }
}
