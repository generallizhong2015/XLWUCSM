using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Models;
using System.Collections;
using IDAL.Common;

namespace IDAL
{
    public interface INtcPubDAL : IFounDationDAL
    {
        NTCPUB Select(string p_ntcpubno);
        IList<NTCPUB> Select(Hashtable h_ntcpub);
        int Select_RecordCount(Hashtable h_ntcpub);
        string GetMaxPubNo();
        void Insert(NTCPUB p_ntcpub);
        void Update(NTCPUB p_ntcpub);
        void Delete(NTCPUB p_ntcpub);
    }
}
