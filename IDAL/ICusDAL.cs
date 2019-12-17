using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IDAL.Common;
using Models;
using System.Collections;

namespace IDAL
{
    public interface ICusDAL : IFounDationDAL
    {
        CUS Select(string p_cusid);
        IList<CUS> Select(Hashtable h_cus);
        int Select_RecordCount(Hashtable h_cus);
        void Insert(CUS p_cus);
        void Update(CUS p_cus);
        void Delete(CUS p_cus);
        string GetMaxCusId();
        string GetMaxCusIdByPrefix(string prefix);
    }
}
