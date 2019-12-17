using System.Collections;
using System.Collections.Generic;
using IBLL.Common;
using Models;

namespace IBLL
{
    public interface ICusOrgBLL : IFounDationBLL
    {
        CUSORG Select(string p_cusid, string p_cusorgid);
        IList<CUSORG> Select(Hashtable h_cusorg);
        string GetMaxCusOrgId(string p_cusid);
        void Insert(CUSORG p_cusorg);
        void Update(CUSORG p_cusorg);
        void Delete(CUSORG p_cusorg);
    }
}
