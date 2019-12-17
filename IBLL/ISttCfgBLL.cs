using System.Collections;
using System.Collections.Generic;
using IBLL.Common;
using Models;

namespace IBLL
{
    public interface ISttCfgBLL : IFounDationBLL
    {
        STTCFG Select(string p_nodtyp, string p_noddtstt);
        IList<STTCFG> Select(Hashtable h_sttcfg);
        void Insert(STTCFG p_sttcfg);
        void Update(STTCFG p_sttcfg);
        void Delete(STTCFG p_sttcfg);
    }
}
