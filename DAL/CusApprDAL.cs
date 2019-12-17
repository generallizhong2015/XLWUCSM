using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DAL.Common;
using IDAL;
using Models;

namespace DAL
{
    class CusApprDAL : FounDationDAL, ICusApprDAL
    {
        public IList<Models.CUSAPPR> GetCusAppr(System.Collections.Hashtable htCusAppr)
        {
            return QueryForList<CUSAPPR>("CUSAPPR_MAP.GetCUSAPPR", htCusAppr);
        }
    }
}
