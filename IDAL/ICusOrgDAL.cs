using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IDAL.Common;
using Models;
using System.Collections;

namespace IDAL
{
    public interface ICusOrgDAL : IFounDationDAL
    {
        CUSORG Select(string p_cusid, string p_cusorgid);
        IList<CUSORG> Select(Hashtable h_cusorg);
        string GetMaxCusOrgId(string p_cusid);
        void Insert(CUSORG p_cusorg);
        void Update(CUSORG p_cusorg);
        void Delete(CUSORG p_cusorg);

    }
}
