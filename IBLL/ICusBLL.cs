using System.Collections;
using System.Collections.Generic;
using IBLL.Common;
using Models;

namespace IBLL
{
    public interface ICusBLL : IFounDationBLL
    {
        CUS Select(string p_cusid);
        IList<CUS> Select(Hashtable h_cus);
        int Select_RecordCount(Hashtable h_cus);
        void Insert(CUS p_cus);
        void Insert(IList<CUS> p_cuslist);
        void Update(CUS p_cus);
        void Delete(CUS p_cus);
        string GetMaxCusId(string prefix);
    }
}
