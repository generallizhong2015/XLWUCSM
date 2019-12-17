using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBLL;
using BLL.Common;
using IDAL;

namespace BLL
{
    class CusApprBLL : FounDationBLL, ICusApprBLL
    {
        ICusApprDAL CusApprDAL { get; set; }

        public IList<Models.CUSAPPR> GetCusAppr(System.Collections.Hashtable htCusAppr)
        {
            return CusApprDAL.GetCusAppr(htCusAppr);
        }
    }
}
