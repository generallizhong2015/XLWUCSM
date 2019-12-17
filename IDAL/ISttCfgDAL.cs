using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IDAL.Common;
using Models;
using System.Collections;

namespace IDAL
{
    public interface ISttCfgDAL : IFounDationDAL
    {
        STTCFG Select(string p_nodtyp, string p_noddtstt);
        IList<STTCFG> Select(Hashtable h_sttcfg);
        void Insert(STTCFG p_sttcfg);
        void Update(STTCFG p_sttcfg);
        void Delete(STTCFG p_sttcfg);
    }
}
