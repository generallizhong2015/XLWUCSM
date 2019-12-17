using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Models;
using System.Collections;
using IDAL.Common;

namespace IDAL
{
    
    public interface ICusApprDAL : IFounDationDAL
    {
        #region CUSAPPR
        /// <summary>
        /// CUSAPPR查询
        /// </summary>
        /// <param name="htCUSAPPR"></param>
        /// <returns></returns>
        IList<CUSAPPR> GetCusAppr(Hashtable htCusAppr);
        #endregion
    }
}
