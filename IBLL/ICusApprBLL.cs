using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBLL.Common;
using Models;
using System.Collections;

namespace IBLL
{
    public interface ICusApprBLL : IFounDationBLL
    {
        IList<CUSAPPR> GetCusAppr(Hashtable htCusAppr);
    }
}
